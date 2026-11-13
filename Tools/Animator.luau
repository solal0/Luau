-- written by ChatGPT :/

-- RawR6Animator.luau (v3)
-- Server-side R6 + legacy Motor6D R15 KeyframeSequence player.
-- Uses replicated Motor6D.C0, not Animator:LoadAnimation / uploaded IDs.
-- The HumanoidRootPart is NEVER directly moved or rotated by this module.
-- RootJoint/Root poses animate the torso relative to the HRP instead.
-- Additional Motor6Ds (equipped tools, weapon joints, custom parts) are discovered.
-- New-style AnimationConstraint avatar rigs are NOT supported by this C0 player.

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

assert(RunService:IsServer(), "RawR6Animator must run on the server")

-- Retained original module name/API for drop-in compatibility.
local RawR6Animator = {}

-- Unlike v2, allow Torso (R6) / LowerTorso (R15) to animate from the HRP.
RawR6Animator.AnimateRootJoint = true
-- 1 = retain animated root-joint translation; 0 = torso lean/rotation only.
-- This changes the Torso relative to the HRP; it never translates the HRP.
RawR6Animator.RootTranslationScale = 1
RawR6Animator.MuteNativeAnimations = true
-- Also detect motors whose Part0/Part1 are set after they were parented.
RawR6Animator.JointRescanInterval = 0.25

local REMOTE_NAME = "AnimatorEvent"
local nativeMuteRemote = ReplicatedStorage:FindFirstChild(REMOTE_NAME)
if not nativeMuteRemote then
	nativeMuteRemote = Instance.new("RemoteEvent")
	nativeMuteRemote.Name = REMOTE_NAME
	nativeMuteRemote.Parent = ReplicatedStorage
end
assert(nativeMuteRemote:IsA("RemoteEvent"), REMOTE_NAME .. " must be a RemoteEvent")

local Track = {}
local controllers = setmetatable({}, { __mode = "k" })
local parsed = setmetatable({}, { __mode = "k" })
local IDENTITY = CFrame.identity
local EPS = 1e-7
local SEP = "\0"

-- Enum.AnimationPriority.Core.Value is 1000, but is LOWEST priority.
local PRIORITIES = { 5, 4, 3, 2, 1, 0, -1 }

local function priorityRank(priority)
	return priority == Enum.AnimationPriority.Core and -1 or priority.Value
end

local function pairKey(parentName, childName)
	return "pair:" .. parentName .. SEP .. childName
end

local function singleKey(name)
	return "single:" .. name
end

local function easedAlpha(alpha, style, direction)
	alpha = math.clamp(alpha, 0, 1)
	if style == Enum.PoseEasingStyle.Constant then
		-- Constant = hold current pose until the next key.
		return alpha >= 1 and 1 or 0
	end
	if style == Enum.PoseEasingStyle.Linear then
		return alpha
	end

	local tweenStyle = Enum.EasingStyle.Linear
	if style == Enum.PoseEasingStyle.Cubic or style == Enum.PoseEasingStyle.CubicV2 then
		tweenStyle = Enum.EasingStyle.Cubic
	elseif style == Enum.PoseEasingStyle.Bounce then
		tweenStyle = Enum.EasingStyle.Bounce
	elseif style == Enum.PoseEasingStyle.Elastic then
		tweenStyle = Enum.EasingStyle.Elastic
	end

	local tweenDirection = Enum.EasingDirection.Out
	if direction == Enum.PoseEasingDirection.In then
		tweenDirection = Enum.EasingDirection.In
	elseif direction == Enum.PoseEasingDirection.InOut then
		tweenDirection = Enum.EasingDirection.InOut
	end

	return TweenService:GetValue(alpha, tweenStyle, tweenDirection)
end

local function parseSequence(sequence)
	local cached = parsed[sequence]
	if cached then
		return cached
	end

	assert(typeof(sequence) == "Instance" and sequence:IsA("KeyframeSequence"),
		"Expected a KeyframeSequence (e.g. Moon Animator 2 > Export Rigs)")

	local data = {
		length = 0,
		-- Pair channel: Pose.Parent.Name / Pose.Name = Motor6D.Part0.Name / Part1.Name.
		-- For flat exports, also support Pose.Name by itself.
		channels = {},
		-- Unambiguous pose-name fallback for malformed/alternate rig exports.
		uniqueByName = {},
		events = {},
		looped = sequence.Loop,
		priority = sequence.Priority,
	}

	-- Every keyframe may contain arbitrary nested poses, including extra parts,
	-- tools and R15 body segments. Never restrict names to the stock R6 limbs.
	for _, keyframe in ipairs(sequence:GetKeyframes()) do
		local time = keyframe.Time
		data.length = math.max(data.length, time)
		local markers = {}
		for _, marker in ipairs(keyframe:GetMarkers()) do
			table.insert(markers, { name = marker.Name, value = marker.Value })
		end
		table.insert(data.events, {
			time = time,
			keyName = keyframe.Name,
			markers = markers,
		})

		for _, pose in ipairs(keyframe:GetDescendants()) do
			if pose:IsA("Pose") and pose.Weight > 0 then
				local poseParent = pose.Parent
				local key = poseParent and poseParent:IsA("Pose")
					and pairKey(poseParent.Name, pose.Name)
					or singleKey(pose.Name)
				local channel = data.channels[key]
				if not channel then
					channel = {}
					data.channels[key] = channel
				end
				table.insert(channel, {
					time = time,
					cf = IDENTITY:Lerp(pose.CFrame, math.clamp(pose.Weight, 0, 1)),
					style = pose.EasingStyle,
					direction = pose.EasingDirection,
				})

				local previous = data.uniqueByName[pose.Name]
				if previous == nil then
					data.uniqueByName[pose.Name] = channel
				elseif previous ~= channel then
					-- Two distinct pose paths use this name. Never guess.
					data.uniqueByName[pose.Name] = false
				end
			end
		end
	end

	table.sort(data.events, function(a, b) return a.time < b.time end)
	for _, channel in pairs(data.channels) do
		table.sort(channel, function(a, b) return a.time < b.time end)
	end
	assert(#data.events > 0, "KeyframeSequence contains no keyframes")
	parsed[sequence] = data
	return data
end

local function channelForJoint(data, joint)
	local p0 = joint.motor.Part0
	local p1 = joint.motor.Part1
	if not p0 or not p1 then return nil end

	-- Normal KeyframeSequence semantics: pose targets Part1, parent pose = Part0.
	local channels = data.channels
	local parentName = p0.Name
	local childName = p1.Name
	local motorName = joint.motor.Name
	return channels[pairKey(parentName, childName)]
		-- Some hand-authored rigs use the Motor6D name as the pose name.
		or channels[pairKey(parentName, motorName)]
		-- Handle flat, top-level poses or Moon Animator exports with a wrapper.
		or channels[singleKey(childName)]
		or channels[singleKey(motorName)]
		-- Only take a name-only fallback if no other pose path shares the name.
		or data.uniqueByName[childName]
		or data.uniqueByName[motorName]
end

local function sample(channel, time)
	local count = #channel
	if count == 0 then
		return IDENTITY
	end

	local first = channel[1]
	if time <= first.time then
		if first.time > 0 then
			return IDENTITY:Lerp(first.cf, time / first.time)
		end
		return first.cf
	end

	local last = channel[count]
	if time >= last.time then
		return last.cf
	end

	-- Find last key at or before time (binary search).
	local low, high = 1, count
	while low + 1 < high do
		local mid = math.floor((low + high) / 2)
		if channel[mid].time <= time then
			low = mid
		else
			high = mid
		end
	end

	local from, to = channel[low], channel[high]
	if to.time <= from.time then
		return to.cf
	end
	local alpha = (time - from.time) / (to.time - from.time)
	return from.cf:Lerp(to.cf, easedAlpha(alpha, from.style, from.direction))
end

local function makeEvent()
	return Instance.new("BindableEvent")
end

function Track.__index(self, key)
	if Track[key] then
		return Track[key]
	end
	if key == "Animation" then return self._source end -- KeyframeSequence, not an Animation instance
	if key == "IsPlaying" then return self._playing end
	if key == "Length" then return self._data.length end
	if key == "Looped" then return self._looped end
	if key == "Priority" then return self._priority end
	if key == "Speed" then return self._speed end
	if key == "TimePosition" then return self._time end
	if key == "WeightCurrent" then return self._weight end
	if key == "WeightTarget" then return self._weightTarget end
	if key == "Stopped" then return self._stopped and self._stopped.Event or nil end
	if key == "Ended" then return self._ended and self._ended.Event or nil end
	if key == "DidLoop" then return self._didLoop and self._didLoop.Event or nil end
	if key == "KeyframeReached" then return self._keyframeReached and self._keyframeReached.Event or nil end
	error("Unknown RawR6Animator track property: " .. tostring(key), 2)
end

function Track.__newindex(self, key, value)
	if self._destroyed then return end -- stale track references are harmless
	if key == "Looped" then
		assert(type(value) == "boolean", "Looped must be a boolean")
		rawset(self, "_looped", value)
	elseif key == "Priority" then
		assert(typeof(value) == "EnumItem" and value.EnumType == Enum.AnimationPriority,
			"Priority must be Enum.AnimationPriority")
		rawset(self, "_priority", value)
		self._controller:render()
	elseif key == "TimePosition" then
		assert(type(value) == "number", "TimePosition must be a number")
		rawset(self, "_time", math.clamp(value, 0, self._data.length))
		self._controller:render()
	else
		error("Track property is read-only or unknown: " .. tostring(key), 2)
	end
end

function Track:_fadeTo(target, duration)
	self._fadeFrom = self._weight
	self._weightTarget = math.max(0, target)
	self._fadeDuration = math.max(0, duration)
	self._fadeElapsed = 0
	if self._fadeDuration == 0 then
		self._weight = self._weightTarget
	end
end

function Track:Play(fadeTime, weight, speed)
	if self._destroyed or self._controller._disposed then return end
	fadeTime = fadeTime == nil and 0.1 or fadeTime
	weight = weight == nil and 1 or weight
	speed = speed == nil and 1 or speed
	assert(fadeTime >= 0 and weight >= 0, "fadeTime and weight must be >= 0")

	self._speed = speed
	self._time = speed < 0 and self._data.length or 0
	self._playing = true
	self._active = true
	self._ending = false
	self._pendingEnd = false
	self._pendingInitialMarkers = true
	self:_fadeTo(weight, fadeTime)

	self._controller:start()
	self._controller:render() -- Apply pose in the SAME call, no asset loading.
end

function Track:Stop(fadeTime)
	if self._destroyed or self._controller._disposed then return end
	if not self._active then return end
	local wasPlaying = self._playing
	fadeTime = fadeTime == nil and 0.1 or fadeTime
	assert(fadeTime >= 0, "fadeTime must be >= 0")

	self._playing = false
	self._ending = true
	self:_fadeTo(0, fadeTime)
	if wasPlaying then self._stopped:Fire() end
	if self._weight <= EPS then
		self._active = false
		self._ending = false
		self._pendingEnd = true
	end
	self._controller:render()
	self._controller:flushEnds()
end

function Track:AdjustSpeed(speed)
	if self._destroyed or self._controller._disposed then return end
	assert(type(speed) == "number", "speed must be a number")
	self._speed = speed
end

function Track:AdjustWeight(weight, fadeTime)
	if self._destroyed or self._controller._disposed then return end
	assert(type(weight) == "number" and weight >= 0, "weight must be >= 0")
	fadeTime = fadeTime == nil and 0.1 or fadeTime
	assert(fadeTime >= 0, "fadeTime must be >= 0")
	self:_fadeTo(weight, fadeTime)
	self._controller:render()
end

function Track:GetMarkerReachedSignal(name)
	if self._destroyed or self._controller._disposed then return end
	assert(type(name) == "string", "marker name must be a string")
	local event = self._markerEvents[name]
	if not event then
		event = makeEvent()
		self._markerEvents[name] = event
	end
	return event.Event
end

function Track:GetTimeOfKeyframe(name)
	if self._destroyed then return nil end
	for _, keyframe in ipairs(self._data.events) do
		if keyframe.keyName == name then
			return keyframe.time
		end
	end
	error("Keyframe not found: " .. tostring(name), 2)
end

function Track:_fireBetween(from, to, forward)
	if self._destroyed then return end
	local events = self._data.events
	if forward then
		for _, item in ipairs(events) do
			if item.time > from + EPS and item.time <= to + EPS then
				if self._destroyed then return end
				self._keyframeReached:Fire(item.keyName)
				for _, marker in ipairs(item.markers) do
					local event = self._markerEvents[marker.name]
					if self._destroyed then return end
					if event then event:Fire(marker.value) end
				end
			end
		end
	else
		for i = #events, 1, -1 do
			local item = events[i]
			if item.time < from - EPS and item.time >= to - EPS then
				if self._destroyed then return end
				self._keyframeReached:Fire(item.keyName)
				for _, marker in ipairs(item.markers) do
					local event = self._markerEvents[marker.name]
					if self._destroyed then return end
					if event then event:Fire(marker.value) end
				end
			end
		end
	end
end

function Track:_advance(dt)
	if self._destroyed or not self._active then return end

	if self._fadeDuration > 0 then
		self._fadeElapsed = math.min(self._fadeElapsed + dt, self._fadeDuration)
		local alpha = self._fadeElapsed / self._fadeDuration
		self._weight = self._fadeFrom + (self._weightTarget - self._fadeFrom) * alpha
	end

	if self._playing then
		if self._pendingInitialMarkers then
			self._pendingInitialMarkers = false
			if self._speed < 0 then
				self:_fireBetween(self._data.length + 2 * EPS, self._data.length, false)
			else
				self:_fireBetween(-2 * EPS, 0, true)
			end
		end
		local length = self._data.length
		local distance = dt * self._speed
		if self._looped and length > 0 and math.abs(distance) > EPS then
			local forward = distance > 0
			local remaining = math.abs(distance)
			local position = self._time
			local wraps = 0

			-- Bound work during severe lag / huge Speed values.
			while remaining > EPS and wraps < 128 do
				local untilEdge = forward and (length - position) or position
				if untilEdge <= EPS then
					position = forward and 0 or length
					if self._destroyed then return end
					self._didLoop:Fire()
					if forward then
						self:_fireBetween(-2 * EPS, 0, true)
					else
						self:_fireBetween(length + 2 * EPS, length, false)
					end
					wraps += 1
				elseif remaining < untilEdge then
					local nextPosition = position + (forward and remaining or -remaining)
					self:_fireBetween(position, nextPosition, forward)
					position = nextPosition
					remaining = 0
				else
					local nextPosition = forward and length or 0
					self:_fireBetween(position, nextPosition, forward)
					remaining -= untilEdge
					position = forward and 0 or length
					if self._destroyed then return end
					self._didLoop:Fire()
					if forward then
						self:_fireBetween(-2 * EPS, 0, true)
					else
						self:_fireBetween(length + 2 * EPS, length, false)
					end
					wraps += 1
				end
			end
			if remaining > EPS then
				position = (position + (forward and remaining or -remaining)) % length
			end
			if self._destroyed then return end
			self._time = position
		elseif math.abs(distance) > EPS then
			local nextPosition = math.clamp(self._time + distance, 0, length)
			self:_fireBetween(self._time, nextPosition, distance > 0)
			if self._destroyed then return end
			self._time = nextPosition
			if (distance > 0 and nextPosition >= length) or
				(distance < 0 and nextPosition <= 0) then
				self._playing = false
				self._ending = true
				self:_fadeTo(0, 0.1)
				if not self._destroyed then self._stopped:Fire() end
			end
		end
	end

	if self._ending and self._weight <= EPS then
		self._weight = 0
		self._active = false
		self._ending = false
		self._pendingEnd = true
	end
end

function Track:Destroy(skipRender)
	if self._destroyed then return end
	self._destroyed = true
	self._active = false
	self._playing = false
	local controller = self._controller
	controller.tracks[self] = nil
	-- Disconnect listeners immediately. Keep the track's state readable.
	for _, name in ipairs({ "_stopped", "_ended", "_didLoop", "_keyframeReached" }) do
		local event = self[name]
		if event then event:Destroy() end
	end
	for _, event in pairs(self._markerEvents) do event:Destroy() end
	table.clear(self._markerEvents)
	if not skipRender and not controller._disposed then
		controller:render()
	end
end

local Controller = {}
Controller.__index = Controller

-- The default Roblox Animate LocalScript is independent of this module. Its
-- AnimationTracks are blended by Animator through Motor6D.Transform, not our
-- raw C0 priority buckets. We must explicitly mute it to prevent double posing.
function Controller:_setNativeMuted(muted)
	if self._disposed then return end
	if self.nativeMuted == muted then
		return
	end

	self.nativeMuted = muted
	if muted then
		local animate = self.rig:FindFirstChild("Animate")
		if animate and animate:IsA("BaseScript") then
			self.animateScript = animate
			self.animateWasEnabled = animate.Enabled
			animate.Enabled = false
		end
	else
		if self.animateScript and self.animateScript.Parent and self.animateWasEnabled ~= nil then
			self.animateScript.Enabled = self.animateWasEnabled
		end
		self.animateScript = nil
		self.animateWasEnabled = nil
	end

	-- Clients with the optional RawR6AnimatorClient LocalScript will also
	-- stop tracks locally, eliminating client-owned Animate replication races.
	nativeMuteRemote:FireAllClients(self.rig, muted)
end

function Controller:_stopNativeTracks()
	if self._disposed then return end
	-- If a character's Animate script appeared after Play, mute it too.
	if not self.animateScript then
		local animate = self.rig:FindFirstChild("Animate")
		if animate and animate:IsA("BaseScript") then
			self.animateScript = animate
			self.animateWasEnabled = animate.Enabled
			animate.Enabled = false
		end
	end

	local humanoid = self.rig:FindFirstChildOfClass("Humanoid")
	local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
	if animator then
		for _, nativeTrack in ipairs(animator:GetPlayingAnimationTracks()) do
			if nativeTrack.IsPlaying then
				nativeTrack:Stop(0)
			end
		end
	end
end

-- Re-scan the live rig. Tools and custom motors may appear after Play() starts.
-- Each joint's original C0 is recorded exactly once and restored on fade-out.
function Controller:_refreshJoints()
	if self._disposed then return end
	if not self.jointsDirty then return end
	self.jointsDirty = false
	local seen = {}
	local joints = {}

	for _, descendant in ipairs(self.rig:GetDescendants()) do
		if descendant:IsA("Motor6D") and descendant.Part0 and descendant.Part1
			and descendant.Part0:IsDescendantOf(self.rig)
			and descendant.Part1:IsDescendantOf(self.rig) then

			local joint = self.jointMap[descendant]
			if joint and (joint.part0 ~= descendant.Part0 or joint.part1 ~= descendant.Part1) then
				-- Part0/Part1 were replaced. The previous base is invalid.
				if joint.applied then
					descendant.C0 = joint.base
				end
				joint = nil
			end
			if not joint then
				joint = {
					motor = descendant,
					part0 = descendant.Part0,
					part1 = descendant.Part1,
					base = descendant.C0,
					isRoot = descendant.Part0 == self.hrp
						and (descendant.Part1.Name == "Torso" or descendant.Part1.Name == "LowerTorso"),
					applied = false,
				}
				self.jointMap[descendant] = joint
			end
			seen[descendant] = true
			table.insert(joints, joint)
		end
	end

	for motor, joint in pairs(self.jointMap) do
		if not seen[motor] then
			if joint.applied and motor.Parent then
				motor.C0 = joint.base
			end
			self.jointMap[motor] = nil
		end
	end
	self.joints = joints
end

function Controller:render()
	if self._disposed then return end
	if not self.rig.Parent or not self.hrp:IsDescendantOf(self.rig) then
		self:dispose()
		return
	end
	self:_refreshJoints()

	local hasActive = false
	for track in pairs(self.tracks) do
		if track._active then
			hasActive = true
			break
		end
	end

	local shouldMute = hasActive and RawR6Animator.MuteNativeAnimations
	self:_setNativeMuted(shouldMute)
	if shouldMute then
		self:_stopNativeTracks()
	end

	for _, joint in ipairs(self.joints) do
		local motor = joint.motor
		if motor.Parent and motor.Part0 == joint.part0 and motor.Part1 == joint.part1 then
			local used, blended = 0, IDENTITY

			-- Crucial: the animated root channel targets the MOTOR connecting
			-- HRP -> Torso (R6), or HRP -> LowerTorso (R15). We only write C0;
			-- we NEVER write HumanoidRootPart.CFrame, PivotTo(), or velocity.
			if hasActive and (RawR6Animator.AnimateRootJoint or not joint.isRoot) then
				local buckets = {}
				for track in pairs(self.tracks) do
					if track._active and track._weight > EPS then
						local channel = channelForJoint(track._data, joint)
						if channel then
							local rank = priorityRank(track._priority)
							local bucket = buckets[rank]
							if not bucket then
								bucket = { weight = 0, cf = IDENTITY }
								buckets[rank] = bucket
							end
							local weight = track._weight
							local pose = sample(channel, track._time)
							local total = bucket.weight + weight
							if bucket.weight == 0 then
								bucket.cf = pose
							else
								bucket.cf = bucket.cf:Lerp(pose, weight / total)
							end
							bucket.weight = total
						end
					end
				end

				local remaining = 1
				for _,rank in ipairs(PRIORITIES) do
					local bucket = buckets[rank]
					if bucket and bucket.weight > EPS then
						blended = bucket.cf
						used = math.min(bucket.weight, 1)
						break
					end
				end
			end

			if used > EPS then
				local offset = IDENTITY:Lerp(blended, used)
				if joint.isRoot then
					local scale = math.clamp(RawR6Animator.RootTranslationScale, 0, 1)
					offset = CFrame.new(offset.Position * scale) * offset.Rotation
				end
				motor.C0 = joint.base * offset
				joint.applied = true
			elseif joint.applied then
				motor.C0 = joint.base
				joint.applied = false
			end
		else
			-- Motor6D reassignment can occur without a descendant event.
			self.jointsDirty = true
		end
	end

	if not hasActive and self.connection then
		self.connection:Disconnect()
		self.connection = nil
	end
end

function Controller:flushEnds()
	if self._disposed then return end
	for track in pairs(self.tracks) do
		if not track._destroyed and track._pendingEnd then
			track._pendingEnd = false
			track._ended:Fire()
		end
	end
end

-- Idempotent cleanup for respawns, model removal, and explicit destruction.
function Controller:dispose()
	if self._disposed then return end
	self._disposed = true
	if self.connection then self.connection:Disconnect(); self.connection = nil end
	if self.addedConnection then self.addedConnection:Disconnect(); self.addedConnection = nil end
	if self.removedConnection then self.removedConnection:Disconnect(); self.removedConnection = nil end
	if self.destroyConnection then self.destroyConnection:Disconnect(); self.destroyConnection = nil end
	for track in pairs(self.tracks) do track:Destroy(true) end
	-- Restore surviving joints only if they still belong to the rig.
	for _, joint in pairs(self.jointMap) do
		local motor = joint.motor
		if joint.applied and motor.Parent and motor:IsDescendantOf(self.rig)
			and motor.Part0 == joint.part0 and motor.Part1 == joint.part1 then
			motor.C0 = joint.base
		end
	end
	if self.animateScript and self.animateScript.Parent and self.animateWasEnabled ~= nil then
		self.animateScript.Enabled = self.animateWasEnabled
	end
	if self.nativeMuted and self.rig.Parent then
		nativeMuteRemote:FireAllClients(self.rig, false)
	end
	self.nativeMuted = false
	controllers[self.rig] = nil
	table.clear(self.joints)
	table.clear(self.jointMap)
end

function Controller:start()
	if self._disposed or self.connection then return end
	if not self.rig.Parent then self:dispose(); return end
	self.jointsDirty = true
	self.rescanElapsed = 0
	self.connection = RunService.PreSimulation:Connect(function(dt)
		if self._disposed then return end
		if not self.rig.Parent or not self.hrp:IsDescendantOf(self.rig) then
			self:dispose()
			return
		end
		self.rescanElapsed += dt
		if self.rescanElapsed >= math.max(0.05, RawR6Animator.JointRescanInterval) then
			self.rescanElapsed = 0
			self.jointsDirty = true
		end
		for track in pairs(self.tracks) do
			if not track._destroyed then track:_advance(dt) end
		end
		if self._disposed then return end
		self:render()
		self:flushEnds()
	end)
end

local function getController(rig)
	assert(rig.Parent ~= nil, "Cannot animate a rig that is not in the DataModel")
	assert(typeof(rig) == "Instance" and rig:IsA("Model"), "Expected an R6/R15 rig Model")
	local existing = controllers[rig]
	if existing and not existing._disposed then return existing end

	local humanoid = rig:FindFirstChildOfClass("Humanoid")
	if humanoid then
		assert(humanoid.RigType == Enum.HumanoidRigType.R6 or
			humanoid.RigType == Enum.HumanoidRigType.R15, "Only R6 and R15 rigs are supported")
	end
	local hrp = rig:FindFirstChild("HumanoidRootPart")
	assert(hrp and hrp:IsA("BasePart"), "Rig needs a HumanoidRootPart")

	local controller = setmetatable({
		_disposed = false,
		rig = rig,
		hrp = hrp,
		joints = {},
		jointMap = {},
		jointsDirty = true,
		rescanElapsed = 0,
		tracks = {},
		connection = nil,
		nativeMuted = false,
		animateScript = nil,
		animateWasEnabled = nil,
		addedConnection = nil,
		removedConnection = nil,
	}, Controller)

	controller:_refreshJoints()
	local hasRootMotor = false
	for _, joint in ipairs(controller.joints) do
		if joint.isRoot then
			hasRootMotor = true
			break
		end
	end
	assert(hasRootMotor,
		"Rig needs a Motor6D from HumanoidRootPart to Torso (R6) or LowerTorso (R15). " ..
			"AnimationConstraint-only R15 avatars require a different animation player; " ..
			"disable AvatarJointUpgrade for a legacy Motor6D rig where available")

	controller.addedConnection = rig.DescendantAdded:Connect(function()
		controller.jointsDirty = true
	end)
	controller.removedConnection = rig.DescendantRemoving:Connect(function()
		controller.jointsDirty = true
	end)
	controllers[rig] = controller
	controller.destroyConnection = rig.Destroying:Connect(function()
		controller:dispose()
	end)

	return controller
end

-- Call after constructing / replacing an accessory or tool joint to bind it immediately.
function RawR6Animator.RefreshJoints(rig)
	local controller = controllers[rig]
	if not controller or controller._disposed then return end
	controller.jointsDirty = true
	controller:render()
end

function RawR6Animator.new(rig, sequence)
	local controller = getController(rig)
	if controller._disposed then return nil end
	local data = parseSequence(sequence)
	local track = setmetatable({
		_source = sequence,
		_data = data,
		_controller = controller,
		_looped = data.looped,
		_priority = data.priority,
		_speed = 1,
		_time = 0,
		_weight = 0,
		_weightTarget = 0,
		_fadeFrom = 0,
		_fadeDuration = 0,
		_fadeElapsed = 0,
		_active = false,
		_playing = false,
		_ending = false,
		_pendingEnd = false,
		_pendingInitialMarkers = false,
		_destroyed = false,
		_stopped = makeEvent(),
		_ended = makeEvent(),
		_didLoop = makeEvent(),
		_keyframeReached = makeEvent(),
		_markerEvents = {},
	}, Track)
	controller.tracks[track] = true
	return track
end

-- No separate load step: builds a track and plays it immediately.
function RawR6Animator.Play(rig, sequence, fadeTime, weight, speed)
	local track = RawR6Animator.new(rig, sequence)
	if track then track:Play(fadeTime == nil and 0 or fadeTime, weight, speed) end
	return track
end

return RawR6Animator
