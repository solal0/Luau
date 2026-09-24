-- File created using ByteCode Inspector (https://github.com/solal0/Luau/)

-- Decompiled in 1s by lunaux
-- Path: ReplicatedStorage.Scripts.BlockFunctions
-- Class: ModuleScript

-- If the script cuts off, click Save below to have the full script as a file.

-- Decompiled using LunaUX-Decompiler V1.4.4. Luau decompiler made by boydev1444 & zyx (discord.gg/2mJUD4XDDT)
-- Decompiled at Thu Sep 24 7:12:34 2026 Pacific Standard Time, took 0.149891 second(s)

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local SetNetworkOwnerModule = RunService:IsServer() and require(game.ServerStorage.Scripts.SetNetworkOwner)
local GetBlockInfoModule = require(game.ReplicatedStorage.Scripts.GetBlockInfo)
local Heartbeat = RunService.Heartbeat
local QueueBlocksRequest = game.ReplicatedStorage:WaitForChild("InputLocalScript"):WaitForChild("QueueBlocksRequest")
local LocalPlayer = game.Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local HeartbeatConnection = nil
local v10 = RunService:IsServer()
local t = {}
local t1 = {}
local t2 = {}
local t3 = {}
local GetStoredBlockState = game.ReplicatedStorage.InputLocalScript.GetStoredBlockState
local Module = { Motor = {} }
Module.Motor.defaultKeys = {
	BindUp = { Enum.KeyCode.W, Enum.KeyCode.Up },
	BindDown = { Enum.KeyCode.S, Enum.KeyCode.Down }
}
Module.Motor.canSetNetworkOwner = true

function Module.Motor.getState(p0) --[[ Line: 31 ]]
	-- upvalues: v10 (copy), GetStoredBlockState (copy)
	local ForwardAttribute = p0:GetAttribute("Forward") or false
	local BackwardAttribute = p0:GetAttribute("Backward") or false
	
	if v10 then
		local Result = GetStoredBlockState:Invoke(p0)
		ForwardAttribute = Result.Forward or false
		BackwardAttribute = Result.Backward or false
	end
	return ForwardAttribute, BackwardAttribute
end

function Module.Motor.calState(_, _, _, _, p5) --[[ Line: 41 ]]
	-- upvalues: CollectionService (copy)
	local v32 = false
	local v33 = false
	local v34 = p5.BindUp.Value == -1
	local v35 = p5.BindDown.Value == -1
	local Children = p5:GetChildren()
	
	for i = 1, #Children do
		local v37 = Children[i]
		local Value = v37:IsA("ObjectValue") and (v37.Name == "ControllerRef" and v37.Value)
		
		if Value and not Value:HasTag("Legacy") then
			if Value.Parent then
				local Value = v37.Value
				local SwitchInput = CollectionService:HasTag(v37.Value, "SwitchInput")
				local OnAttribute = SwitchInput and Value:GetAttribute("On")
				
				if not v32 then
					v32 = SwitchInput and OnAttribute or ((if v34 then Value:GetAttribute("Input" .. tostring(Enum.KeyCode.W.Value)) or Value:GetAttribute("Input" .. tostring(Enum.KeyCode.Up.Value)) else Value:GetAttribute("Input" .. tostring(p5.BindUp.Value))) or false)
				end
				if not v33 then
					v33 = (if v35 then Value:GetAttribute("Input" .. tostring(Enum.KeyCode.S.Value)) or Value:GetAttribute("Input" .. tostring(Enum.KeyCode.Down.Value)) else Value:GetAttribute("Input" .. tostring(p5.BindDown.Value))) or false
				end
			else
				v37:Destroy()
			end
		end
	end
	return v32, v33
end

function Module.Motor.setState(_, p7, _, _, _, _, _, _, p14, p15): boolean --[[ Line: 104 ]]
	-- upvalues: Module (copy), v10 (copy)
	local v42 = false
	local State, State2 = Module[p7.Name].getState(p7)
	
	if State ~= p14 then
		setState(p7, "Forward", p14)
		v42 = true
	end
	if State2 ~= p15 then
		setState(p7, "Backward", p15)
		v42 = true
	end
	if not v10 and v42 then
		local v45 = p7.MaxSpeed.Value * (p7:GetAttribute("SpinFactor") or 1)
		p7.PrimaryPart.HingeConstraint.AngularVelocity = if p14 and not p15 then v45 elseif p14 or not p15 then 0 else -v45
	end
	return v42
end

Module.HugeMotor = Module.Motor
Module.Servo = {}
Module.Servo.defaultKeys = {
	BindLeft = { Enum.KeyCode.A, Enum.KeyCode.Left },
	BindRight = { Enum.KeyCode.D, Enum.KeyCode.Right }
}
Module.Servo.canSetNetworkOwner = true

function Module.Servo.getState(p16) --[[ Line: 147 ]]
	-- upvalues: v10 (copy), GetStoredBlockState (copy)
	local LeftAttribute = p16:GetAttribute("Left") or false
	local RightAttribute = p16:GetAttribute("Right") or false
	
	if v10 then
		local Result = GetStoredBlockState:Invoke(p16)
		LeftAttribute = Result.Left or false
		RightAttribute = Result.Right or false
	end
	return LeftAttribute, RightAttribute
end

function Module.Servo.calState(_, _, _, _, p21) --[[ Line: 157 ]]
	-- upvalues: CollectionService (copy)
	local v49 = false
	local v50 = false
	local v51 = p21.BindLeft.Value == -1
	local v52 = p21.BindRight.Value == -1
	local Children = p21:GetChildren()
	
	for i = 1, #Children do
		local v54 = Children[i]
		local Value = v54:IsA("ObjectValue") and (v54.Name == "ControllerRef" and v54.Value)
		
		if Value and not Value:HasTag("Legacy") then
			if Value.Parent then
				local Value_1 = v54.Value
				local SwitchInput = CollectionService:HasTag(v54.Value, "SwitchInput")
				local OnAttribute = SwitchInput and Value_1:GetAttribute("On")
				
				if not v49 then
					v49 = SwitchInput and OnAttribute or ((if v51 then Value_1:GetAttribute("Input" .. tostring(Enum.KeyCode.A.Value)) or Value_1:GetAttribute("Input" .. tostring(Enum.KeyCode.Left.Value)) else Value_1:GetAttribute("Input" .. tostring(p21.BindLeft.Value))) or false)
				end
				if not v50 then
					v50 = (if v52 then Value_1:GetAttribute("Input" .. tostring(Enum.KeyCode.D.Value)) or Value_1:GetAttribute("Input" .. tostring(Enum.KeyCode.Right.Value)) else Value_1:GetAttribute("Input" .. tostring(p21.BindRight.Value))) or false
				end
			else
				v54:Destroy()
			end
		end
	end
	return v49, v50
end

function Module.Servo.setState(_, p23, _, _, _, _, _, _, p30, p31): boolean --[[ Line: 217 ]]
	-- upvalues: Module (copy), v10 (copy)
	local v59 = false
	local State, State2 = Module[p23.Name].getState(p23)
	
	if State ~= p30 then
		setState(p23, "Left", p30)
		v59 = true
	end
	if State2 ~= p31 then
		setState(p23, "Right", p31)
		v59 = true
	end
	if not v10 and v59 then
		local v63 = p23.TargetAngle.Value * (if p23.ReverseRotation.Value then -1 else 1)
		local v62 = 0
		
		if p30 then
			v62 += v63
		end
		if p31 then
			v62 -= v63
		end
		p23.PrimaryPart.HingeConstraint.TargetAngle = v62
	end
	return v59
end

Module.Piston = {}
Module.Piston.defaultKeys = Module.Motor.defaultKeys
Module.Piston.getState = Module.Motor.getState

function Module.Piston.calState(_, _, _, _, p36) --[[ Line: 257 ]]
	-- upvalues: CollectionService (copy)
	local v64 = false
	local v65 = false
	local v66 = p36.BindUp.Value == -1
	local v67 = p36.BindDown.Value == -1
	local Children = p36:GetChildren()
	
	for i = 1, #Children do
		local v69 = Children[i]
		local Value = v69:IsA("ObjectValue") and (v69.Name == "ControllerRef" and v69.Value)
		
		if Value and not Value:HasTag("Legacy") then
			if Value.Parent then
				local Value = v69.Value
				local SwitchInput = CollectionService:HasTag(v69.Value, "SwitchInput")
				local OnAttribute = SwitchInput and Value:GetAttribute("On")
				
				if not v64 then
					v64 = SwitchInput and OnAttribute or ((if v66 then Value:GetAttribute("Input" .. tostring(Enum.KeyCode.W.Value)) or Value:GetAttribute("Input" .. tostring(Enum.KeyCode.Up.Value)) else Value:GetAttribute("Input" .. tostring(p36.BindUp.Value))) or false)
				end
				if not v65 then
					v65 = (if v67 then SwitchInput and not OnAttribute or (Value:GetAttribute("Input" .. tostring(Enum.KeyCode.S.Value)) or (Value:GetAttribute("Input" .. tostring(Enum.KeyCode.Down.Value)) or Value:GetAttribute("Input" .. tostring(Enum.KeyCode.ButtonL2.Value)))) else SwitchInput and not OnAttribute or Value:GetAttribute("Input" .. tostring(p36.BindDown.Value))) or false
				end
			else
				v69:Destroy()
			end
		end
	end
	if v64 then
		v65 = false
	end
	return v64, v65
end

function Module.Piston.setState(_, p38, _, _, _, _, _, _, p45, p46, p47): boolean --[[ Line: 326 ]]
	-- upvalues: Module (copy), v10 (copy)
	local v74 = false
	local State, State2 = Module[p38.Name].getState(p38)
	
	if State ~= p45 then
		setState(p38, "Forward", p45)
		v74 = true
	end
	if State2 ~= p46 then
		setState(p38, "Backward", p46)
		v74 = true
	end
	if v74 and v10 and not p47 then
		local _ = p38.PrimaryPart
		local Base = p38.Base
		local TopPart = p38.TopPart
		TopPart.Massless = true
		local v77: number? = nil
		
		if p45 and not p46 then
			v77 = p38.ExtendLength.Value
		elseif not p45 and p46 then
			v77 = 0
		end
		if v77 then
			task.spawn(function() --[[ Line: 360 ]]
				-- upvalues: Base (copy), v77 (ref), p38 (copy), TopPart (copy)
				local config = {
					C1 = (Base.CFrame * CFrame.new(-(v77 + 0.4), 0, 0)):toObjectSpace(Base.CFrame)
				}
				local C1 = Base.WeldToTop.C1
				local v83 = (Base.WeldToTop.C1.p - config.C1.p).magnitude / p38.Speed.Value
				local v84: number = v83
				local v85 = 0
				local CurrentTime = tick()
				p38.LastGlobalTick.Value = CurrentTime
				while p38.Parent and CurrentTime == p38.LastGlobalTick.Value do
					local WeldToTop = Base.WeldToTop
					local v87 = 1 - math.max(v84, 0) / v83
					
					if v87 ~= v87 then
						v87 = 1
					end
					WeldToTop.C1 = C1:Lerp(config.C1, v87)
					
					if v84 <= 0 then break end
					v84 -= v85
					v85 = task.wait()
				end
				TopPart.Massless = false
			end)
		else
			p38.LastGlobalTick.Value = tick()
		end
	end
	return v74
end

Module.BoatMotor = {}
Module.BoatMotor.defaultKeys = {
	BindUp = { Enum.KeyCode.W, Enum.KeyCode.Up },
	BindDown = { Enum.KeyCode.S, Enum.KeyCode.Down },
	BindLeft = { Enum.KeyCode.A, Enum.KeyCode.Left },
	BindRight = { Enum.KeyCode.D, Enum.KeyCode.Right }
}
Module.BoatMotor.canSetNetworkOwner = true

function Module.BoatMotor.getState(p48) --[[ Line: 429 ]]
	-- upvalues: v10 (copy), GetStoredBlockState (copy)
	local ForwardAttribute = p48:GetAttribute("Forward") or false
	local BackwardAttribute = p48:GetAttribute("Backward") or false
	local LeftAttribute = p48:GetAttribute("Left") or false
	local RightAttribute = p48:GetAttribute("Right") or false
	
	if v10 then
		local Result = GetStoredBlockState:Invoke(p48)
		ForwardAttribute = Result.Forward or false
		BackwardAttribute = Result.Backward or false
		LeftAttribute = Result.Left or false
		RightAttribute = Result.Right or false
	end
	return ForwardAttribute, BackwardAttribute, LeftAttribute, RightAttribute
end

function Module.BoatMotor.calState(_, _, _, _, p53) --[[ Line: 443 ]]
	-- upvalues: CollectionService (copy)
	local v94 = false
	local v95 = false
	local v96 = false
	local v97 = false
	local BindLeft = p53:FindFirstChild("BindLeft")
	local v99: boolean = BindLeft and p53.BindLeft.Value == -1
	local v100: boolean = BindLeft and p53.BindRight.Value == -1
	local v101 = p53.BindUp.Value == -1
	local v102 = p53.BindDown.Value == -1
	local Children = p53:GetChildren()
	
	for i = 1, #Children do
		local v107 = Children[i]
		local Value = v107:IsA("ObjectValue") and (v107.Name == "ControllerRef" and v107.Value)
		
		if Value and not Value:HasTag("Legacy") then
			if not Value.Parent then
				v107:Destroy()
				continue
			end
			local Value = v107.Value
			local SwitchInput = CollectionService:HasTag(v107.Value, "SwitchInput")
			local OnAttribute = SwitchInput and Value:GetAttribute("On")
			
			if not v94 and BindLeft then
				v94 = (if v99 then Value:GetAttribute("Input" .. tostring(Enum.KeyCode.A.Value)) or Value:GetAttribute("Input" .. tostring(Enum.KeyCode.Left.Value)) else Value:GetAttribute("Input" .. tostring(p53.BindLeft.Value))) or false
			end
			if not v95 and BindLeft then
				v95 = (if v100 then Value:GetAttribute("Input" .. tostring(Enum.KeyCode.D.Value)) or Value:GetAttribute("Input" .. tostring(Enum.KeyCode.Right.Value)) else Value:GetAttribute("Input" .. tostring(p53.BindRight.Value))) or false
			end
			if not v97 then
				v97 = SwitchInput and OnAttribute or ((if v101 then Value:GetAttribute("Input" .. tostring(Enum.KeyCode.W.Value)) or Value:GetAttribute("Input" .. tostring(Enum.KeyCode.Up.Value)) else Value:GetAttribute("Input" .. tostring(p53.BindUp.Value))) or false)
			end
			if not v96 then
				v96 = (if v102 then Value:GetAttribute("Input" .. tostring(Enum.KeyCode.S.Value)) or Value:GetAttribute("Input" .. tostring(Enum.KeyCode.Down.Value)) else Value:GetAttribute("Input" .. tostring(p53.BindDown.Value))) or false
			end
		end
	end
	return v97, v96, v94, v95
end

function Module.BoatMotor.setState(_, p55, _, _, p58, _, _, _, p62, p63, p64, p65): boolean --[[ Line: 534 ]]
	-- upvalues: Module (copy), v10 (copy)
	local v109 = false
	local State, State2, State3, State4 = Module[p55.Name].getState(p55)
	
	if State ~= p62 then
		setState(p55, "Forward", p62)
		v109 = true
	end
	if State2 ~= p63 then
		setState(p55, "Backward", p63)
		v109 = true
	end
	if State3 ~= p64 then
		setState(p55, "Left", p64)
		v109 = true
	end
	if State4 ~= p65 then
		setState(p55, "Right", p65)
		v109 = true
	end
	if v109 and not v10 then
		local v114: number = if p65 then 1 else 0
		
		if p64 then
			v114 -= 1
		end
		local v115: number = if p62 then 1 else 0
		
		if p63 then
			v115 -= 1
		end
		if p55.Direction.Value ~= v114 or p55.DirectionThrust.Value ~= v115 then
			p55.Direction.Value = v114
			p55.DirectionThrust.Value = v115
			local VehicleSeat = p58 and p58:FindFirstChildOfClass("VehicleSeat")
			
			if not p55:FindFirstChild("TurnPart") and VehicleSeat and VehicleSeat.Parent then
				local BAV = Instance.new("BodyAngularVelocity")
				BAV.Name = "BAV"
				BAV.AngularVelocity = Vector3.new(0, 0, 0)
				BAV.MaxTorque = Vector3.new(0, 0, 0)
				local TurnPart = Instance.new("Part")
				TurnPart.Name = "TurnPart"
				TurnPart.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
				TurnPart.Material = Enum.Material.SmoothPlastic
				TurnPart.CanCollide = false
				TurnPart.Anchored = false
				TurnPart.TopSurface = Enum.SurfaceType.Smooth
				TurnPart.BottomSurface = Enum.SurfaceType.Smooth
				TurnPart.CFrame = VehicleSeat.CFrame
				TurnPart.Massless = true
				TurnPart.Parent = p55
				WeldTogether(VehicleSeat, TurnPart)
				local NoWelds = Instance.new("BoolValue")
				NoWelds.Name = "NoWelds"
				NoWelds.Parent = TurnPart
				BAV.Parent = TurnPart
				task.spawn(function() --[[ Line: 606 ]]
					-- upvalues: VehicleSeat (copy), TurnPart (copy)
					VehicleSeat:GetPropertyChangedSignal("Occupant"):Wait()
					TurnPart:Destroy()
				end)
			end
			local _, _, _, _, _, Components6, _, _, _, _, _, _ = p55.PrimaryPart.CFrame:toObjectSpace(p55.Motor.PrimaryPart.CFrame):GetComponents()
			local v129 = 0
			
			if Components6 < -0.5 then
				v129 = -1
			elseif Components6 > 0.5 then
				v129 = 1
			end
			if v114 == 0 then
				p55.PrimaryPart.WeldMotor.C1 *= CFrame.Angles(0, math.rad(v129 * 45), 0)
				
				if p55:FindFirstChild("TurnPart") then
					p55.TurnPart.BAV.AngularVelocity = Vector3.new(0, 0, 0)
					p55.TurnPart.BAV.MaxTorque = Vector3.new(0, 0, 0)
				end
			elseif v114 == 1 then
				p55.PrimaryPart.WeldMotor.C1 *= CFrame.Angles(0, math.rad(v129 * 45 + -45), 0)
				
				if p55:FindFirstChild("TurnPart") then
					p55.TurnPart.BAV.AngularVelocity = Vector3.new(0, -p55.TurningSpeed.Value, 0)
					p55.TurnPart.BAV.MaxTorque = Vector3.new(0, p55.MaxTurningForce.Value, 0)
				end
			else
				p55.PrimaryPart.WeldMotor.C1 *= CFrame.Angles(0, math.rad(v129 * 45 + 45), 0)
				
				if p55:FindFirstChild("TurnPart") then
					p55.TurnPart.BAV.AngularVelocity = Vector3.new(0, p55.TurningSpeed.Value, 0)
					p55.TurnPart.BAV.MaxTorque = Vector3.new(0, p55.MaxTurningForce.Value, 0)
				end
			end
			if v115 ~= 0 and not p55.PrimaryPart.Start.IsPlaying and not p55.PrimaryPart.Loop.IsPlaying then
				p55.PrimaryPart.End:Stop()
				p55.PrimaryPart.Start:Play()
				task.delay(p55.PrimaryPart.Start.TimeLength, function() --[[ Line: 651 ]]
					-- upvalues: p55 (copy)
					if p55.Parent and p55.DirectionThrust.Value ~= 0 then
						p55.PrimaryPart.Loop:Play()
					end
				end)
			elseif v115 == 0 and (p55.PrimaryPart.Start.IsPlaying or p55.PrimaryPart.Loop.IsPlaying) then
				p55.PrimaryPart.Start:Stop()
				p55.PrimaryPart.Loop:Stop()
				
				if not p55.PrimaryPart.End.IsPlaying then
					p55.PrimaryPart.End:Play()
				end
			end
			updateForceLoop(p55)
		end
	end
	return v109
end

Module.BoatMotorWinter = Module.BoatMotor
Module.BoatMotorUltra = Module.BoatMotor

function updateForceLoop(p66) --[[ Line: 677 ]]
	spawn(function() --[[ Line: 678 ]]
		-- upvalues: p66 (copy)
		local CurrentTime = tick()
		p66.ForceLoopTick.Value = CurrentTime
		while p66.Parent and p66.DirectionThrust.Value ~= 0 and p66.ForceLoopTick.Value == CurrentTime do
			local LookVector = p66.PrimaryPart.CFrame.LookVector
			p66.PrimaryPart.BV.Velocity = Vector3.new(LookVector.X, 0, LookVector.Z).Unit * p66.MaxSpeed.Value * p66.DirectionThrust.Value
			p66.PrimaryPart.BV.MaxForce = Vector3.new(p66.MaxThrustForce.Value, 0, p66.MaxThrustForce.Value)
			local Children = p66.Motor.Bottom:GetChildren()
			
			for i = 1, #Children do
				if Children[i].Name == "WeldBlade" then
					local v134 = Children[i]
					v134.C1 = (v134.Part1.CFrame * CFrame.Angles(0, 0, (math.rad(-30 * p66.DirectionThrust.Value)))):toObjectSpace(v134.Part0.CFrame)
				end
			end
			wait()
		end
		if p66.Parent then
			p66.PrimaryPart.BV.MaxForce = Vector3.new(0, 0, 0)
			
			return
		end
	end)
end

Module.FrontWheel = {}
Module.FrontWheel.defaultKeys = Module.BoatMotor.defaultKeys
Module.FrontWheel.canSetNetworkOwner = true
Module.FrontWheel.getState = Module.BoatMotor.getState
Module.FrontWheel.calState = Module.BoatMotor.calState

function Module.FrontWheel.setState(_, p68, _, _, _, _, _, _, p75, p76, p77, p78): boolean --[[ Line: 716 ]]
	-- upvalues: Module (copy), v10 (copy)
	local v137 = true
	local State, State2, State3, State4 = Module[p68.Name].getState(p68)
	
	if State ~= p75 then
		setState(p68, "Forward", p75)
		v137 = true
	end
	if State2 ~= p76 then
		setState(p68, "Backward", p76)
		v137 = true
	end
	if State3 ~= p77 then
		setState(p68, "Left", p77)
		v137 = true
	end
	if State4 ~= p78 then
		setState(p68, "Right", p78)
		v137 = true
	end
	if not v10 and v137 then
		local v147 = p68.MaxSpeed.Value * (p68:GetAttribute("SpinFactor") or 1)
		local v142 = if p75 then v147 else 0
		
		if p76 then
			v142 -= v147
		end
		local v143: boolean = p68.PrimaryPart.Att.Orientation.Y <= -59 and p68.PrimaryPart.Att.Orientation.Y >= -61
		local v144: boolean = p68.PrimaryPart.Att.Orientation.Y <= -119 and p68.PrimaryPart.Att.Orientation.Y >= -121
		local NoP78: boolean = p77 and not p78
		local NoP77: boolean = p78 and not p77
		p68.PrimaryPart.HingeConstraint.AngularVelocity = v142
		
		if not v143 and NoP78 then
			p68.PrimaryPart.Att.Orientation = Vector3.new(0, -60, 0)
			
			return v137
		elseif not v144 and NoP77 then
			p68.PrimaryPart.Att.Orientation = Vector3.new(0, -120, 0)
			
			return v137
		elseif not NoP78 and not NoP77 and (v143 or v144) then
			p68.PrimaryPart.Att.Orientation = Vector3.new(0, -90, 0)
		end
	end
	return v137
end

Module.FrontWheelCookie = Module.FrontWheel
Module.FrontWheelMint = Module.FrontWheel
Module.HugeFrontWheel = Module.FrontWheel
Module.BackWheel = {}
Module.BackWheel.defaultKeys = Module.Motor.defaultKeys
Module.BackWheel.canSetNetworkOwner = true
Module.BackWheel.getState = Module.FrontWheel.getState
Module.BackWheel.calState = Module.FrontWheel.calState
Module.BackWheel.setState = Module.FrontWheel.setState
Module.BackWheelCookie = Module.BackWheel
Module.BackWheelMint = Module.BackWheel
Module.HugeBackWheel = Module.BackWheel
Module.CarSeat = {}

function Module.CarSeat.getState(p79) --[[ Line: 792 ]]
	-- upvalues: v10 (copy)
	local t = {}
	
	if not v10 then
		for i, attribute in p79:GetAttributes() do
			if attribute then
				t[i] = attribute
			end
		end
	end
	return t
end

Module.CarSeat.calState = Module.CarSeat.getState

function Module.CarSeat.setState(p80, p81, p82, p83, _, p85, p86, p87, p88): boolean --[[ Line: 805 ]]
	local v151 = nil
	local v149 = false
	local t = {}
	
	for i, value in pairs(p88) do
		v151 = "Input" .. i
		
		if p81:GetAttribute(v151) ~= value then
			v149 = true
			t[i] = true
			setState(p81, v151, value or nil)
		end
	end
	if p87 and v149 then
		addConnectionsToQueue(p81:GetChildren(), p80, p82, p83, p81, p85, p86, t)
	end
	return v149
end

Module.PilotSeat = {}
Module.PilotSeat.defaultKeys = Module.BoatMotor.defaultKeys
Module.PilotSeat.canSetNetworkOwner = true
Module.PilotSeat.getState = Module.CarSeat.getState
Module.PilotSeat.calState = Module.CarSeat.calState

function Module.PilotSeat.setState(p89, p90, p91, p92, _, p94, p95, p96, p97): boolean --[[ Line: 833 ]]
	-- upvalues: v10 (copy), HeartbeatConnection (ref), RunService (copy)
	local v162 = nil
	local v152 = false
	local t = {}
	
	for i, value in pairs(p97) do
		v162 = "Input" .. i
		
		if p90:GetAttribute(v162) ~= value then
			v152 = true
			t[i] = true
			setState(p90, v162, value or nil)
		end
	end
	if p96 and v152 then
		addConnectionsToQueue(p90:GetChildren(), p89, p91, p92, p90, p94, p95, t)
	end
	if not v10 then
		local v156 = p90.BindDown.Value == -1
		local v157 = p90.BindLeft.Value == -1
		local v158 = p90.BindRight.Value == -1
		local v159 = (if v156 then p90:GetAttribute("Input" .. tostring(Enum.KeyCode.S.Value)) or p90:GetAttribute("Input" .. tostring(Enum.KeyCode.Down.Value)) else p90:GetAttribute("Input" .. tostring(p90.BindDown.Value))) or false
		local v160 = (if v157 then p90:GetAttribute("Input" .. tostring(Enum.KeyCode.A.Value)) or p90:GetAttribute("Input" .. tostring(Enum.KeyCode.Left.Value)) else p90:GetAttribute("Input" .. tostring(p90.BindLeft.Value))) or false
		local v161 = (if v158 then p90:GetAttribute("Input" .. tostring(Enum.KeyCode.D.Value)) or p90:GetAttribute("Input" .. tostring(Enum.KeyCode.Right.Value)) else p90:GetAttribute("Input" .. tostring(p90.BindRight.Value))) or false
		local v155 = 0
		
		if (if p90.BindUp.Value == -1 then p90:GetAttribute("Input" .. tostring(Enum.KeyCode.W.Value)) or p90:GetAttribute("Input" .. tostring(Enum.KeyCode.Up.Value)) else p90:GetAttribute("Input" .. tostring(p90.BindUp.Value))) or false then
			v155 += 2
		end
		if v159 then
			v155 -= 2
		end
		local v154 = 0
		
		if v160 then
			v154 += 2
		end
		if v161 then
			v154 -= 2
		end
		if HeartbeatConnection then
			HeartbeatConnection:Disconnect()
		end
		if v155 == 0 and v154 == 0 then
			p90.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
			task.spawn(function() --[[ Line: 928 ]]
				-- upvalues: RunService (upval), p90 (copy)
				RunService.Heartbeat:Wait()
				p90.VehicleSeat.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			end)
		else
			p90.VehicleSeat.BAV.MaxTorque = Vector3.new(1e999, 1e999, 1e999)
			HeartbeatConnection = RunService.Heartbeat:Connect(function() --[[ Line: 920 ]]
				-- upvalues: p90 (copy), v155 (ref), v154 (ref)
				if p90.Parent then
					p90.VehicleSeat.BAV.AngularVelocity = p90.VehicleSeat.CFrame.RightVector * v155 + p90.VehicleSeat.CFrame.UpVector * v154
				end
			end)
		end
	end
	return v152
end

Module.RemoteController = Module.CarSeat
Module.Lever = {}

function Module.Lever.getState(p98) --[[ Line: 943 ]]
	-- upvalues: v10 (copy), GetStoredBlockState (copy)
	return (if v10 then GetStoredBlockState:Invoke(p98).On else p98:GetAttribute("On")) or false
end

function Module.Lever.calState(_, _, _, _, p103) --[[ Line: 951 ]]
	-- upvalues: Module (copy)
	return Module.Lever.getState(p103)
end

function Module.Lever.setState(p104, p105, p106, p107, p108, p109, p110, p111, p112, p113): boolean --[[ Line: 954 ]]
	-- upvalues: Module (copy), v10 (copy), CollectionService (copy)
	local P113: boolean = p113 or false
	local Lever = not v10 and p105:FindFirstChild("Lever")
	local ColorPart = Lever and Lever:FindFirstChild("ColorPart")
	
	if Module[p105.Name].getState(p105) ~= p112 then
		setState(p105, "On", p112)
		P113 = true
		
		if not v10 then
			local Lever = p105.Lever
			local Animator = Lever.AnimationController.Animator
			local PlayingAnimationTracks = Animator:GetPlayingAnimationTracks()
			
			if p112 then
				Animator:LoadAnimation(Lever.Down):Play()
			else
				for i = 1, #PlayingAnimationTracks do
					PlayingAnimationTracks[i]:Stop()
				end
			end
			p105.PrimaryPart.Sound:Play()
		end
	end
	if not v10 and ColorPart then
		if p105:HasTag("Legacy") then
			ColorPart.Color = Color3.fromRGB(237, 234, 234)
		elseif p112 then
			ColorPart.Color = Color3.fromRGB(0, 255, 0)
		else
			ColorPart.Color = Color3.fromRGB(255, 0, 0)
		end
	end
	if P113 and p111 then
		if not CollectionService:HasTag(p105, "Legacy") then
			addConnectionsToQueue(p105:GetChildren(), p104, p112, false, p105, p109, p110)
			
			return P113
		end
		runLegacyBlock(p104, p105, p106, p107, p108, p109, p110, p111, p112)
	end
	return P113
end

Module.Switch = {}
Module.Switch.getState = Module.Lever.getState
Module.Switch.calState = Module.Lever.calState

function Module.Switch.setState(p114, p115, p116, p117, p118, p119, p120, p121, p122, p123): boolean --[[ Line: 1012 ]]
	-- upvalues: Module (copy), v10 (copy), CollectionService (copy)
	local P123: boolean = p123 or false
	local Part = not v10 and p115:FindFirstChild("Part")
	
	if Module[p115.Name].getState(p115) ~= p122 then
		setState(p115, "On", p122)
		P123 = true
		
		if not v10 then
			local Switch = p115.Switch
			local Animator = Switch.AnimationController.Animator
			local PlayingAnimationTracks = Animator:GetPlayingAnimationTracks()
			
			if p122 then
				Animator:LoadAnimation(Switch.Down):Play()
				p115.PrimaryPart.SoundOn:Play()
			else
				for i = 1, #PlayingAnimationTracks do
					PlayingAnimationTracks[i]:Stop()
				end
				p115.PrimaryPart.SoundOff:Play()
			end
		end
	end
	if not v10 and Part then
		if p115:HasTag("Legacy") then
			Part.Color = Color3.fromRGB(60, 72, 65)
		elseif p122 then
			Part.Color = Color3.fromRGB(0, 255, 0)
		else
			Part.Color = Color3.fromRGB(255, 0, 0)
		end
	end
	if P123 and p121 then
		if not CollectionService:HasTag(p115, "Legacy") then
			addConnectionsToQueue(p115:GetChildren(), p114, p122, false, p115, p119, p120)
			
			return P123
		end
		runLegacyBlock(p114, p115, p116, p117, p118, p119, p120, p121, p122)
	end
	return P123
end

Module.SwitchBig = {}
Module.SwitchBig.getState = Module.Lever.getState
Module.SwitchBig.calState = Module.Lever.calState

function Module.SwitchBig.setState(p124, p125, p126, p127, p128, p129, p130, p131, p132, p133): boolean --[[ Line: 1071 ]]
	-- upvalues: Module (copy), v10 (copy), CollectionService (copy)
	local P133: boolean = p133 or false
	local Switch = not v10 and p125:FindFirstChild("Switch")
	local Part3 = Switch and Switch:FindFirstChild("Part3")
	local Part4 = Switch and Switch:FindFirstChild("Part4")
	local Part5 = Switch and Switch:FindFirstChild("Part5")
	
	if Module[p125.Name].getState(p125) ~= p132 then
		setState(p125, "On", p132)
		P133 = true
		
		if not v10 then
			local Switch = p125.Switch
			local Animator = Switch.AnimationController.Animator
			local PlayingAnimationTracks = Animator:GetPlayingAnimationTracks()
			
			if p132 then
				Animator:LoadAnimation(Switch.Down):Play()
				p125.PrimaryPart.SoundOn:Play()
			else
				for i = 1, #PlayingAnimationTracks do
					PlayingAnimationTracks[i]:Stop()
				end
				p125.PrimaryPart.SoundOff:Play()
			end
		end
	end
	if not v10 and Switch then
		if p125:HasTag("Legacy") then
			if Part3 then
				Part3.Color = Color3.fromRGB(237, 234, 234)
			end
			if Part4 then
				Part4.Color = Color3.fromRGB(237, 234, 234)
			end
			if Part5 then
				Part5.Color = Color3.fromRGB(237, 234, 234)
			end
		elseif p132 then
			if Part3 then
				Part3.Color = Color3.fromRGB(0, 255, 0)
			end
			if Part4 then
				Part4.Color = Color3.fromRGB(0, 255, 0)
			end
			if Part5 then
				Part5.Color = Color3.fromRGB(0, 255, 0)
			end
		else
			if Part3 then
				Part3.Color = Color3.fromRGB(255, 0, 0)
			end
			if Part4 then
				Part4.Color = Color3.fromRGB(255, 0, 0)
			end
			if Part5 then
				Part5.Color = Color3.fromRGB(255, 0, 0)
			end
		end
	end
	if P133 and p131 then
		if not CollectionService:HasTag(p125, "Legacy") then
			addConnectionsToQueue(p125:GetChildren(), p124, p132, false, p125, p129, p130)
			
			return P133
		end
		runLegacyBlock(p124, p125, p126, p127, p128, p129, p130, p131, p132)
	end
	return P133
end

Module.Button = {}
Module.Button.getState = Module.Lever.getState
Module.Button.calState = Module.Lever.calState

function Module.Button.setState(p134, p135, p136, p137, p138, p139, p140, p141, p142, p143): boolean --[[ Line: 1157 ]]
	-- upvalues: Module (copy), v10 (copy), CollectionService (copy)
	local P143: boolean = p143 or false
	local Button = not v10 and p135:FindFirstChild("Button")
	
	if Module[p135.Name].getState(p135) ~= p142 then
		setState(p135, "On", p142)
		P143 = true
		
		if not v10 then
			if p142 then
				p135.PrimaryPart.Sound:Play()
				goButtonDown(Button)
			else
				goButtonUp(Button)
			end
		end
	end
	if Button then
		if v10 then
			if Button:HasTag("Legacy") then
				if not Button:HasTag("CantPaint") then
					Button:AddTag("CantPaint")
				end
			elseif Button:HasTag("CantPaint") then
				Button:RemoveTag("CantPaint")
			end
		elseif p135:HasTag("Legacy") then
			Button.Color = Color3.fromRGB(237, 234, 234)
		elseif p142 then
			Button.Color = Color3.fromRGB(0, 255, 0)
		else
			local PrimaryPart = p135.PrimaryPart
			
			if PrimaryPart and PrimaryPart.Color ~= game.ReplicatedStorage.BuildingParts.Button.PrimaryPart.Color then
				Button.Color = PrimaryPart.Color
			else
				Button.Color = Color3.fromRGB(255, 0, 0)
			end
		end
	end
	if P143 and p141 then
		if not CollectionService:HasTag(p135, "Legacy") then
			addConnectionsToQueue(p135:GetChildren(), p134, p142, false, p135, p139, p140)
			
			return P143
		end
		runLegacyBlock(p134, p135, p136, p137, p138, p139, p140, p141, p142)
	end
	return P143
end

function goButtonDown(p144) --[[ Line: 1224 ]]
	local v185 = game.ReplicatedStorage.BuildingParts[p144.Parent.Name].Button.Size - Vector3.new(0.20000000298023224, 0, 0)
	p144.CanCollide = false
	p144:BreakJoints()
	p144.Size = v185
	WeldTogether(p144.Parent.PrimaryPart, p144)
end

function goButtonUp(p145) --[[ Line: 1233 ]]
	local Size = game.ReplicatedStorage.BuildingParts[p145.Parent.Name].Button.Size
	p145:BreakJoints()
	p145.Size = Size
	WeldTogether(p145.Parent.PrimaryPart, p145)
end

Module.SensorBlock = {}
Module.SensorBlock.getState = Module.Lever.getState
Module.SensorBlock.calState = Module.Lever.calState

function Module.SensorBlock.setState(p146, p147, _, _, _, p151, p152, p153, p154, _): boolean --[[ Line: 1243 ]]
	-- upvalues: Module (copy), v10 (copy)
	local v187 = false
	local PrimaryPart = p147.PrimaryPart
	
	if Module[p147.Name].getState(p147) ~= p154 then
		setState(p147, "On", p154)
		v187 = true
		
		if not v10 and PrimaryPart then
			if p154 then
				PrimaryPart.Color = Color3.fromRGB(0, 255, 0)
			else
				PrimaryPart.Color = Color3.fromRGB(255, 0, 0)
			end
		end
	end
	if v187 and p153 then
		addConnectionsToQueue(p147:GetChildren(), p146, p154, false, p147, p151, p152)
	end
	return v187
end

Module.Delay = {}
Module.Delay.defaultKeys = { BindFire = { Enum.KeyCode.F, Enum.KeyCode.ButtonL2 } }

function Module.Delay.getState(p156) --[[ Line: 1277 ]]
	-- upvalues: v10 (copy), GetStoredBlockState (copy)
	return (if v10 then GetStoredBlockState:Invoke(p156).On else p156:GetAttribute("On")) or false, if v10 then p156.RunningWaitTimeOnServer.Value ~= 0 else p156.RunningWaitTime.Value ~= 0, p156.RunningWaitTimeOnServer.Value
end

function Module.Delay.calState(_, p158, _, p160, p161) --[[ Line: 1295 ]]
	-- upvalues: Module (copy), CollectionService (copy)
	local v189 = false
	local _, State2 = Module[p161.Name].getState(p161)
	local v192 = p161.BindFire.Value == -1
	
	if State2 then
		return v189, State2
	end
	local Children = p161:GetChildren()
	
	for i = 1, #Children do
		local v193 = Children[i]
		local Value = v193:IsA("ObjectValue") and (v193.Name == "ControllerRef" and v193.Value)
		local SwitchInput = Value and CollectionService:HasTag(v193.Value, "SwitchInput")
		
		if Value and (Value == p160 and SwitchInput) then
			if p158 then
				return p158, State2
			end
		elseif Value and not Value:HasTag("Legacy") then
			if Value.Parent then
				local OnAttribute = SwitchInput and Value:GetAttribute("On")
				
				if not SwitchInput then
					v189 = (if v192 then Value:GetAttribute("Input" .. tostring(Enum.KeyCode.F.Value)) or Value:GetAttribute("Input" .. tostring(Enum.KeyCode.ButtonL2.Value)) else Value:GetAttribute("Input" .. tostring(p161.BindFire.Value))) or false
				elseif OnAttribute then
					v189 = true
				end
				if v189 then
					return v189, State2
				end
			else
				v193:Destroy()
			end
		end
	end
	return v189, State2
end

function Module.Delay.setState(p162, p163, p164, p165, p166, p167, p168, p169, p170: boolean, p171, p172: number): boolean --[[ Line: 1352 ]]
	-- upvalues: Module (copy), CollectionService (copy), v10 (copy), TweenService (copy), LocalPlayer (copy), t3 (ref)
	local v198 = false
	local P172: number = p172 or p163.WaitDuration.Value
	local v200 = p172 ~= nil
	local State: boolean = Module.Delay.getState(p163)
	
	if p163.Parent then
		if CollectionService:HasTag(p163, "Legacy") then
			if p163.Glass.BrickColor ~= BrickColor.Red() and (not p165 or p164) then
				v198 = true
				setState(p163, "On", false)
				local Value = p163.WaitDuration.Value
				
				if not v10 then
					p163.Glass.BrickColor = BrickColor.Red()
					p163.Part.BrickColor = BrickColor.Red()
				end
				delay(Value, function() --[[ Line: 1512 ]]
					-- upvalues: p163 (copy), v10 (upval), p169 (copy), p172 (copy), LocalPlayer (upval), p162 (copy), p164 (copy), p165 (copy), p166 (copy), p167 (copy), p168 (copy), p170 (ref)
					if not p163.Parent or not p163:HasTag("Legacy") then return end
					p163.Glass.Color = game.ReplicatedStorage.BuildingParts[p163.Name].Glass.Color
					p163.Part.Color = game.ReplicatedStorage.BuildingParts[p163.Name].Part.Color
					
					if not v10 and (p169 or p172 and p172 > 0 and LocalPlayer.UserId == p162) then
						runLegacyBlock(p162, p163, p164, p165, p166, p167, p168, p169, p170)
					end
				end)
			end
		elseif not p171 and State ~= p170 or v200 then
			local v206 = if v10 then p163.RunningWaitTimeOnServer else p163.RunningWaitTime
			
			if v200 then
				setState(p163, "On", p170)
				
				if not v10 then
					if p170 then
						p163.Glass.Color = Color3.fromRGB(0, 255, 0)
						p163.Part.Color = Color3.fromRGB(0, 255, 0)
					else
						p163.Glass.Color = game.ReplicatedStorage.BuildingParts[p163.Name].Glass.Color
						p163.Part.Color = game.ReplicatedStorage.BuildingParts[p163.Name].Part.Color
					end
				end
				State = p170
				
				if p172 > 0 then
					p170 = not p170
				end
				v198 = true
			end
			if State ~= p170 or v200 and p172 > 0 then
				local Gui = nil
				local Bar = nil
				
				if not v10 then
					Gui = p163.PPart.Gui
					Bar = Gui.Frame.Bar
				end
				v206.Value = P172
				local v205 = TweenService:Create(v206, TweenInfo.new(P172, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { Value = 0 })
				v205:Play()
				v205.Completed:Connect(function(p173) --[[ Line: 1414 ]]
					-- upvalues: p163 (copy), v10 (upval), Gui (ref), p170 (ref), p169 (copy), p172 (copy), LocalPlayer (upval), p162 (copy), Module (upval), p167 (copy), p168 (copy), t3 (upval)
					if p173 ~= Enum.PlaybackState.Completed or not p163.Parent then return end
					if not p163:HasTag("Legacy") then
						setState(p163, "On", p170)
						
						if not v10 then
							if p170 then
								p163.Glass.Color = Color3.fromRGB(0, 255, 0)
								p163.Part.Color = Color3.fromRGB(0, 255, 0)
							else
								p163.Glass.Color = game.ReplicatedStorage.BuildingParts[p163.Name].Glass.Color
								p163.Part.Color = game.ReplicatedStorage.BuildingParts[p163.Name].Part.Color
							end
							Gui.Enabled = false
						end
						if not v10 and (p169 or p172 and (p172 > 0 and LocalPlayer.UserId == p162)) then
							if p170 ~= Module[p163.Name].calState(p162, false, false, false, p163) then
								local list = {
									{
										p163, p170, false, false, p167, p168, true, false
									},
									true
								}
								
								if not t3[p162] then
									t3[p162] = {}
								end
								table.insert(t3[p162], list)
							end
							addConnectionsToQueue(p163:GetChildren(), p162, p170, false, p163, p167, p168)
							checkToRunQueue(p162)
						end
						return
					elseif not v10 then
						Gui.Enabled = false
					end
				end)
				
				if not v10 then
					if p170 then
						Bar.Size = UDim2.new(0, 0, 1, 0)
						Bar.Position = UDim2.new(0, 0, 0, 0)
						Bar.AnchorPoint = Vector2.new(0, 0)
						Bar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
						TweenService:Create(Bar, TweenInfo.new(P172, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0) }):Play()
					else
						Bar.Size = UDim2.new(1, 0, 1, 0)
						Bar.Position = UDim2.new(1, 0, 0, 0)
						Bar.AnchorPoint = Vector2.new(1, 0)
						Bar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
						TweenService:Create(Bar, TweenInfo.new(P172, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { Size = UDim2.new(0, 0, 1, 0) }):Play()
					end
					Gui.Enabled = true
				end
				v198 = true
			end
		end
	end
	return v198
end

function runLegacyBlock(p174, p175, p176, p177, _, p179, p180, _, _) --[[ Line: 1536 ]]
	-- upvalues: Module (copy)
	local Children = p175:GetChildren()
	local t = {}
	
	for i = 1, #Children do
		local v210 = Children[i]
		
		if v210:IsA("Beam") then
			if v210.Attachment1 and v210.Attachment1.Parent and v210.Attachment1.Parent.Parent and v210.Attachment1.Parent.Parent.Parent then
				local Parent = v210.Attachment1.Parent.Parent
				local list = {}
				local v213 = 1
				
				if not Module[Parent.Name].stateless then
					local State, State2, State3, State4 = Module[Parent.Name].getState(Parent)
					list = if Parent.Name == "Delay" then { State } else { State, State2, State3, State4 }
					
					if p177 then
						local BindUp = Parent:FindFirstChild("BindUp")
						local BindDown = Parent:FindFirstChild("BindDown")
						local BindLeft = Parent:FindFirstChild("BindLeft")
						local BindRight = Parent:FindFirstChild("BindRight")
						
						if Parent:FindFirstChild("BindFire") then
							if Parent.BindFire.Value == -1 then
								if p177 == Enum.KeyCode.F or p177 == Enum.KeyCode.ButtonL2 then
									list[1] = not list[1]
								end
							elseif p177.Value == Parent.BindFire.Value then
								list = { not State }
							end
						end
						if BindUp then
							if Parent.BindUp.Value == -1 then
								if p177 == Enum.KeyCode.W or p177 == Enum.KeyCode.Up then
									list[v213] = not list[v213]
									v213 += 1
									
									if Parent.Name == "Piston" then
										list = { true, false }
									end
								end
							elseif p177.Value == Parent.BindUp.Value then
								list[v213] = not list[v213]
								v213 += 1
								
								if Parent.Name == "Piston" then
									list = { true, false }
								end
							end
						end
						if BindDown then
							if Parent.BindDown.Value == -1 then
								if p177 == Enum.KeyCode.S or p177 == Enum.KeyCode.Down then
									list[v213] = not list[v213]
									v213 += 1
									
									if Parent.Name == "Piston" then
										list = { false, true }
									end
								end
							elseif p177.Value == Parent.BindDown.Value then
								list[v213] = not list[v213]
								v213 += 1
								
								if Parent.Name == "Piston" then
									list = { false, true }
								end
							end
						end
						if BindLeft then
							if Parent.BindLeft.Value == -1 then
								if p177 == Enum.KeyCode.A or p177 == Enum.KeyCode.Left then
									list[v213] = not list[v213]
									v213 += 1
								end
							elseif p177.Value == Parent.BindLeft.Value then
								list[v213] = not list[v213]
								v213 += 1
							end
						end
						if BindRight then
							if Parent.BindRight.Value == -1 then
								if p177 == Enum.KeyCode.D or p177 == Enum.KeyCode.Right then
									list[v213] = not list[v213]
									local _ = v213 + 1
								end
							elseif p177.Value == Parent.BindRight.Value then
								list[v213] = not list[v213]
								local _ = v213 + 1
							end
						end
					else
						list[1] = not list[1]
						
						if Parent.Name == "Piston" then
							list[2] = not list[1]
						end
					end
				end
				table.insert(t, {
					Parent, p176, p177, p175, p179, p180, true, true, table.unpack(list)
				})
			elseif v210.Attachment1 == nil or (v210.Attachment1.Parent == nil or (v210.Attachment1.Parent.Parent == nil or v210.Attachment1.Parent.Parent.Parent == nil)) then
				v210:Destroy()
			end
		end
	end
	if t[1] then
		Module.addBulkToRunQueue(p174, t)
	end
end

Module.Gate = {}
Module.Gate.defaultKeys = Module.Delay.defaultKeys
Module.Gate.getState = Module.Lever.getState

function Module.Gate.calState(_, p184, _, p186, p187): boolean --[[ Line: 1688 ]]
	-- upvalues: CollectionService (copy)
	local Value: boolean = p187.And.Value
	local v225 = false
	local Value_1 = p187.Or.Value
	local Value_2 = p187.And.Value
	local Value_3 = p187.Xor.Value
	local Value_4 = p187.Not.Value
	local v230 = p187.BindFire.Value == -1
	local Children = p187:GetChildren()
	
	for i = 1, #Children do
		local v232 = Children[i]
		local Value_5 = v232:IsA("ObjectValue") and (v232.Name == "ControllerRef" and v232.Value)
		
		if Value_5 and not Value_5:HasTag("Legacy") then
			if not Value_5.Parent then
				v232:Destroy()
				continue
			end
			local SwitchInput = CollectionService:HasTag(v232.Value, "SwitchInput")
			local OnAttribute = SwitchInput and Value_5:GetAttribute("On")
			local v234 = false
			v225 = true
			
			if Value_5 == p186 and SwitchInput then
				v234 = p184
			elseif not SwitchInput then
				v234 = (if v230 then Value_5:GetAttribute("Input" .. tostring(Enum.KeyCode.F.Value)) or Value_5:GetAttribute("Input" .. tostring(Enum.KeyCode.ButtonL2.Value)) else Value_5:GetAttribute("Input" .. tostring(p187.BindFire.Value))) or false
			elseif OnAttribute then
				v234 = true
			end
			if Value_1 then
				Value = Value or v234
				
				if Value then break end
			elseif Value_2 then
				Value = Value and v234
			elseif Value_3 and v234 then
				Value = not Value
			end
		end
	end
	if Value_2 and not v225 then
		Value = false
	end
	if Value_4 then
		Value = not Value
	end
	return Value
end

function Module.Gate.setState(p188, p189, _, _, _, p193, p194, p195, p196): boolean --[[ Line: 1768 ]]
	-- upvalues: Module (copy), v10 (copy)
	local v237 = false
	
	if Module[p189.Name].getState(p189) ~= p196 then
		setState(p189, "On", p196)
		v237 = true
		
		if not v10 and (p189.Parent and p189.PrimaryPart) then
			local v238 = if p196 then Color3.fromRGB(0, 255, 0) else p189.PrimaryPart.Color
			local v239, v240, v241 = v238:ToHSV()
			p189.Part.Color = Color3.fromHSV(v239, v240, v241 - math.random(0, 100) / 100 * 0.2)
			local CurrentTime = tick()
			p189:SetAttribute("lastUpdateTick", CurrentTime)
			task.delay(0, function() --[[ Line: 1793 ]]
				-- upvalues: CurrentTime (copy), p189 (copy), v238 (ref)
				if CurrentTime == p189:GetAttribute("lastUpdateTick") then
					p189.Part.Color = v238
					p189:SetAttribute("lastUpdateTick", nil)
				end
			end)
		end
	end
	if v237 and p195 then
		addConnectionsToQueue(p189:GetChildren(), p188, p196, false, p189, p193, p194)
	end
	return v237
end

Module.LightBulb = {}
Module.LightBulb.defaultKeys = Module.Delay.defaultKeys
Module.LightBulb.getState = Module.Lever.getState

function Module.LightBulb.calState(_, p198, p199, _, p201): boolean --[[ Line: 1821 ]]
	-- upvalues: CollectionService (copy), Module (copy)
	local v243 = false
	local v244 = p201.BindFire.Value == -1
	
	if p199 then
		local State = Module[p201.Name].getState(p201)
		v243 = State
		
		if p198 then
			if v244 then
				if p199 == Enum.KeyCode.F or p199 == Enum.KeyCode.ButtonL2 then
					v243 = not State
					
					return v243
				end
			elseif p199.Value == p201.BindFire.Value then
				v243 = not State
			end
		end
	else
		local Children = p201:GetChildren()
		
		for i = 1, #Children do
			local v245 = Children[i]
			local Value = v245:IsA("ObjectValue") and (v245.Name == "ControllerRef" and v245.Value)
			
			if Value and not Value:HasTag("Legacy") then
				if Value.Parent then
					local SwitchInput = CollectionService:HasTag(v245.Value, "SwitchInput")
					
					if SwitchInput and (SwitchInput and v245.Value:GetAttribute("On")) then
						v243 = true
					end
					if not v243 then
						continue
					end
				else
					v245:Destroy()
				end
			end
		end
		return v243
	end
	return v243
end

function Module.LightBulb.setState(_, p203, _, _, _, _, _, _, p210): boolean --[[ Line: 1882 ]]
	-- upvalues: Module (copy), v10 (copy)
	local v250 = false
	
	if Module[p203.Name].getState(p203) ~= p210 then
		setState(p203, "On", p210)
		v250 = true
		
		if not v10 and (p203.Parent and (p203.PrimaryPart and (p203:FindFirstChild("BulbEnd") and (p203:FindFirstChild("BulbMid") and p203:FindFirstChild("BulbStart"))))) then
			if p210 then
				p203.BulbEnd.Material = Enum.Material.Neon
				p203.BulbMid.Material = Enum.Material.Neon
				p203.BulbStart.Material = Enum.Material.Neon
				p203.BulbEnd.PointLight.Color = p203.BulbEnd.Color
				p203.BulbEnd.PointLight.Enabled = true
				
				return v250
			else
				p203.BulbEnd.Material = Enum.Material.Glass
				p203.BulbMid.Material = Enum.Material.Glass
				p203.BulbStart.Material = Enum.Material.Glass
				p203.BulbEnd.PointLight.Enabled = false
			end
		end
	end
	return v250
end

Module.Note = {}
Module.Note.defaultKeys = Module.Delay.defaultKeys
Module.Note.stateless = true

function Module.Note.willActivate(p211, p212, p213, _) --[[ Line: 1919 ]]
	if not p213 or not p212 then
		return p212
	elseif p211.BindFire.Value == -1 then
		if p213 == Enum.KeyCode.F or p213 == Enum.KeyCode.ButtonL2 then
			return true
		end
	elseif p213.Value == p211.BindFire.Value then
		return true
	end
	return false
end

function Module.Note.setState(p215, p216, _, _, _, _, _, _): boolean --[[ Line: 1939 ]]
	-- upvalues: v10 (copy), LocalPlayer (copy), CurrentCamera (copy)
	local PlayerByUserId = game.Players:GetPlayerByUserId(p215)
	
	if not v10 and (PlayerByUserId and PlayerByUserId.Team == LocalPlayer.Team) then
		local v255 = false
		local PrimaryPart = p216.PrimaryPart
		
		if CurrentCamera and PrimaryPart then
			local v252 = PrimaryPart.Position - CurrentCamera.CFrame.Position
			local _Vector3 = Vector3.new(math.abs(v252.X), math.abs(v252.Y), (math.abs(v252.Z)))
			local RollOffMaxDistance = p216.PrimaryPart.Sound.RollOffMaxDistance
			v255 = _Vector3.X < RollOffMaxDistance and (_Vector3.Y < RollOffMaxDistance and _Vector3.Z < RollOffMaxDistance)
		end
		if v255 then
			playNoteFunction(p216)
		end
	end
	return true
end

local t4 = {}
local v17 = 0

function playNoteFunction(p223) --[[ Line: 1969 ]]
	-- upvalues: v17 (ref), t4 (copy), TweenService (copy)
	if v17 > 7 then
		local Removed = table.remove(t4, 8)
		
		if Removed.Parent then
			Removed:Stop()
			Removed:Destroy()
		end
	else
		v17 += 1
	end
	local Copy = p223.PrimaryPart.Sound:Clone()
	game.Debris:AddItem(Copy, 2)
	Copy.Parent = p223.PrimaryPart
	Copy:Play()
	table.insert(t4, 1, Copy)
	local BaseWeld = p223.PrimaryPart.BaseWeld
	BaseWeld.C0 = CFrame.new(0, 0, 0)
	TweenService:Create(BaseWeld, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut, 0, true), { C0 = CFrame.new(0, 1, 0) }):Play()
end

Module.DisplayBlock = {}
Module.DisplayBlock.defaultKeys = Module.Delay.defaultKeys
Module.DisplayBlock.stateless = true

function Module.DisplayBlock.willActivate(p224, p225, p226, p227) --[[ Line: 1999 ]]
	if p224.Parent and p224.Additive.Value then
		return true
	elseif not p227 or (not p227.Parent or not p224.Parent) then
		return false
	elseif not p226 then
		return p225
	elseif p224.BindFire.Value == -1 then
		if p226 == Enum.KeyCode.F or p226 == Enum.KeyCode.ButtonL2 then
			return true
		end
	elseif p226.Value == p224.BindFire.Value then
		return true
	end
	return false
end

function Module.DisplayBlock.setState(_, p229, p230, _, p232, _, _, _, p236) --[[ Line: 2025 ]]
	-- upvalues: v10 (copy), CollectionService (copy), LocalPlayer (copy)
	local v260 = true
	
	if not p229.Parent then return end
	local _Color3: Color3 = p236 or p232 and p232.PrimaryPart.Color
	
	if not v10 and not p236 then
		local v277 = p229.BindFire.Value == -1
		local R = 0
		local G = 0
		local B = 0
		
		if p229.Additive.Value then
			local Children = p229:GetChildren()
			
			for i = 1, #Children do
				local v269 = Children[i]
				local Value = v269:IsA("ObjectValue") and (v269.Name == "ControllerRef" and v269.Value)
				local PrimaryPart = Value and Value.PrimaryPart
				
				if not Value or (Value:HasTag("Legacy") or not PrimaryPart) then
					continue
				elseif not Value.Parent then
					v269:Destroy()
					continue
				end
				local SwitchInput = CollectionService:HasTag(v269.Value, "SwitchInput")
				local OnAttribute = SwitchInput and Value:GetAttribute("On")
				local v273 = false
				
				if Value == p232 and SwitchInput then
					v273 = p230
				elseif not SwitchInput then
					v273 = (if v277 then Value:GetAttribute("Input" .. tostring(Enum.KeyCode.F.Value)) or Value:GetAttribute("Input" .. tostring(Enum.KeyCode.ButtonL2.Value)) else Value:GetAttribute("Input" .. tostring(p229.BindFire.Value))) or false
				elseif OnAttribute then
					v273 = true
				end
				if v273 then
					local Color = PrimaryPart.Color
					R += Color.R
					G += Color.G
					B += Color.B
				end
			end
		else
			if not p230 or not p232 or not p232.PrimaryPart then
				v260 = false
				
				return v260
			end
			local Color = p232.PrimaryPart.Color
			R = Color.R
			G = Color.G
			B = Color.B
		end
		_Color3 = Color3.new(math.min(R, 1), math.min(G, 1), (math.min(B, 1)))
	end
	if v260 then
		setState(p229, "NextColor", _Color3)
		
		if not v10 then
			if p236 then
				p229:SetAttribute("NextColor", p236)
			end
			if LocalPlayer:FindFirstChild("OtherData") and LocalPlayer.OtherData:FindFirstChild("CanFlash") then
				p229.PrimaryPart.Color = p229:GetAttribute("NextColor")
			elseif not p229:GetAttribute("Waiting") then
				p229:SetAttribute("Waiting", true)
				local v261 = 0.33
				local Size = p229.PrimaryPart.Size
				local Largest = math.max(Size.X * Size.Y, (math.max(Size.X * Size.Z, Size.Y * Size.Z)))
				
				if Largest > 64 then
					v261 += (1 - v261) * math.min(1, Largest / 2500)
				end
				task.delay(v261, function() --[[ Line: 2138 ]]
					-- upvalues: p229 (copy)
					if p229.Parent then
						p229:SetAttribute("Waiting", nil)
						p229.PrimaryPart.Color = p229:GetAttribute("NextColor")
					end
				end)
				
				return v260, _Color3
			end
		end
	end
	return v260, _Color3
end

Module.BoxingGlove = {}
Module.BoxingGlove.defaultKeys = Module.Delay.defaultKeys
Module.BoxingGlove.stateless = true
Module.BoxingGlove.willActivate = Module.Note.willActivate

function Module.BoxingGlove.setState(p237, p238, _, _, _, _, _, _): boolean --[[ Line: 2171 ]]
	-- upvalues: v10 (copy), GetBlockInfoModule (copy), Heartbeat (copy)
	if not v10 then
		local Value = p238.AniTrack.Value or p238.AnimationController.Animator:LoadAnimation(p238.PunchAnimation)
		p238.AniTrack.Value = Value
		local TouchedConnection = p238.Glove.Touched:Connect(function(p245) --[[ Line: 2179 ]]
			-- upvalues: p237 (copy), p238 (copy), GetBlockInfoModule (upval), Heartbeat (upval)
			if p245:IsGrounded() then return end
			local Parent = p245.Parent
			while Parent and Parent.Parent ~= workspace.Blocks and not game.Players:GetPlayerFromCharacter(Parent) do
				Parent = Parent.Parent
			end
			local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(Parent)
			local PlayerByUserId = game.Players:GetPlayerByUserId(p237)
			local Glove = p238.Glove
			
			if Parent then
				local v285 = nil
				
				if PlayerFromCharacter and (PlayerFromCharacter.Team == PlayerByUserId.Team or PlayerFromCharacter.Settings.PVP.Value and PlayerByUserId.Settings.PVP.Value) then
					v285 = PlayerFromCharacter.Character:FindFirstChildOfClass("Humanoid")
					
					if v285.PlatformStand then
						v285 = nil
					end
				end
				local Position = Glove.Position
				local _Vector3: Vector3 = p245.Position
				local v284 = 20
				
				if v285 then
					v285.PlatformStand = true
					_Vector3 = Vector3.new(p245.Position.X + math.random(-4, 4), Position.Y + 10, p245.Position.Z + math.random(-4, 4))
					v284 = 200
				end
				if not PlayerFromCharacter or v285 then
					local _, v282 = GetBlockInfoModule(p245)
					
					if PlayerFromCharacter or v282 and (v282.Team == PlayerByUserId.Team or v282.Settings.PVP.Value and PlayerByUserId.Settings.PVP.Value) then
						local _Vector3 = Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
						p245.AssemblyLinearVelocity = (_Vector3 - Position).Unit * v284
						p245.AssemblyAngularVelocity = _Vector3
					end
				end
				if v285 then
					(function(p246, p247) --[[ Line: 2232 | Named "stunEffect" ]]
						-- upvalues: Heartbeat (upval)
						if not p246 then return end
						local Sound = Instance.new("Sound")
						Sound.SoundId = "rbxassetid://133218697256077"
						Sound.RollOffMaxDistance = 800
						Sound.RollOffMinDistance = 250
						Sound.Volume = 0.4
						game.Debris:AddItem(Sound, 10)
						Sound.Parent = p246
						Sound:Play()
						local t = {}
						local v298 = 0
						
						for i1 = 1, 5 do
							local Part = Instance.new("Part")
							local Mesh = Instance.new("SpecialMesh")
							Mesh.MeshId = "http://www.roblox.com/asset/?id=45428961"
							Mesh.TextureId = "http://www.roblox.com/asset/?id=45021124"
							Mesh.Scale = Vector3.new(4, 4, 4)
							Mesh.Parent = Part
							Part.Size = Vector3.new(1, 1, 1)
							Part.Anchored = true
							Part.CanCollide = false
							Part.CanQuery = false
							Part.CanTouch = false
							Part.CFrame = (Part.CFrame - Part.Position + p246.Position + p246.CFrame:vectorToWorldSpace((Vector3.new(math.cos(v298), 3, (math.sin(v298)))))) * CFrame.Angles(-0.7853981633974483, 0, 0)
							t[i1] = Part
							game.Debris:AddItem(Part, p247)
							Part.Parent = workspace.TempStuff
							v298 += 1.2566370614359172
						end
						local v295: number = p247
						local v291 = 0
						while v295 > 0 do
							local v294: number = Heartbeat:Wait()
							v295 -= v294
							local v293 = v291 / 10
							
							for i = 1, 5 do
								local v292 = t[i]
								v293 += 1.2566370614359172
								v292.CFrame = v292.CFrame:Lerp((v292.CFrame - v292.Position + p246.Position + p246.CFrame:vectorToWorldSpace((Vector3.new(math.cos(v293), 3, (math.sin(v293)))))) * CFrame.Angles(0 * v294, 20 * v294, 0 * v294), 0.5)
							end
							if v295 < 0.25 then
								t[1].Transparency = 1 - v295 / 0.25
								t[2].Transparency = 1 - v295 / 0.25
								t[3].Transparency = 1 - v295 / 0.25
								t[4].Transparency = 1 - v295 / 0.25
								t[5].Transparency = 1 - v295 / 0.25
							end
							v291 += 1
						end
					end)(v285.Parent:FindFirstChild("Head"), 5)
					v285.PlatformStand = false
				end
			end
		end)
		Value:Play()
		task.spawn(function() --[[ Line: 2311 ]]
			-- upvalues: Value (copy), TouchedConnection (ref)
			Value.Ended:Wait()
			TouchedConnection:Disconnect()
			TouchedConnection = nil
		end)
		p238.Glove.Sound:Play()
	end
	return true
end

Module.Firework = {}
Module.Firework.defaultKeys = Module.Delay.defaultKeys
Module.Firework.stateless = true
Module.Firework.willActivate = Module.Note.willActivate

function Module.Firework.setState(_, p249, _, _, _, _, _, _): boolean --[[ Line: 2330 ]]
	-- upvalues: v10 (copy)
	if v10 then
		p249.PrimaryPart.Activate:Fire()
	end
	return true
end

Module.FireworkA = Module.Firework
Module.FireworkB = Module.Firework
Module.FireworkC = Module.Firework
Module.FireworkD = Module.Firework
Module.Glue = {}
Module.Glue.defaultKeys = Module.Delay.defaultKeys
Module.Glue.stateless = true
Module.Glue.willActivate = Module.Note.willActivate

function Module.Glue.setState(_, p257, _, _, _, _, _, _): boolean --[[ Line: 2352 ]]
	-- upvalues: v10 (copy)
	local PrimaryPart = p257.PrimaryPart
	local Sound = PrimaryPart and PrimaryPart:FindFirstChild("Sound")
	
	if Sound then
		Sound.PlayOnRemove = true
		Sound:Destroy()
	end
	if v10 then
		p257:Destroy()
	else
		local Part = p257:FindFirstChild("Part")
		local ClickDetector = p257:FindFirstChild("ClickDetector")
		
		if PrimaryPart then
			PrimaryPart.Transparency = 1
		end
		if Part then
			Part.Transparency = 1
		end
		if ClickDetector then
			ClickDetector:Destroy()
		end
	end
	return true
end

Module.SticksOfTNT = Module.Firework
Module.Cannon = {}
Module.Cannon.defaultKeys = Module.Delay.defaultKeys
Module.Cannon.stateless = true
Module.Cannon.willActivate = Module.Note.willActivate

function Module.Cannon.setState(p264, p265, _, _, _, _, _, _): boolean --[[ Line: 2396 ]]
	-- upvalues: v10 (copy)
	if v10 then
		p265.PrimaryPart.Activate:Fire((game.Players:GetPlayerByUserId(p264)))
	end
	return true
end

Module.MiniGun = Module.Cannon
Module.Harpoon = Module.Cannon
Module.HarpoonGold = Module.Cannon
Module.DualCaneHarpoon = Module.Cannon
Module.HarpoonDragon = Module.Cannon
local v18 = nil
local v19 = 0
Module.Camera = {}
Module.Camera.defaultKeys = Module.Delay.defaultKeys
Module.Camera.stateless = true

function Module.Camera.willActivate(p272, p273, p274, _) --[[ Line: 2421 ]]
	if not p273 then
		return false
	elseif not p274 then
		return p273
	elseif p272.BindFire.Value == -1 then
		if p274 == Enum.KeyCode.F or p274 == Enum.KeyCode.ButtonL2 then
			return true
		end
	elseif p274.Value == p272.BindFire.Value then
		return true
	end
	return false
end

function Module.Camera.setState(p276, p277, _, _, _, p281, _, _): boolean --[[ Line: 2443 ]]
	-- upvalues: v10 (copy), LocalPlayer (copy), v19 (ref), v18 (ref)
	if not v10 and game.Players:GetPlayerByUserId(p276) == LocalPlayer then
		local CurrentTime = tick()
		local v306 = 0.016666666666666666
		local OtherData = LocalPlayer:FindFirstChild("OtherData")
		
		if not OtherData or not OtherData:FindFirstChild("CanFlash") then
			v306 = 0.39
		end
		if v306 < CurrentTime - v19 and (p281 and p281 == LocalPlayer.Character) then
			local v305 = v18
			
			if v305 then
				deactivateCam()
			end
			if v305 ~= p277 then
				activateCam(p277)
			end
			v19 = CurrentTime
		end
	end
	return false
end

Module.CameraDome = Module.Camera
local AncestryChangedConnection = nil
local MouseButton1ClickConnection = nil
local Connection = nil
local Custom = Enum.CameraType.Custom
local Humanoid = LocalPlayer and (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid"))

function activateCam(p284) --[[ Line: 2479 ]]
	-- upvalues: v18 (ref), Custom (ref), CurrentCamera (copy), Humanoid (ref), RunService (copy), AncestryChangedConnection (ref), MouseButton1ClickConnection (ref), Connection (ref)
	v18 = p284
	local LocalPlayer = game.Players.LocalPlayer
	local IsCameraDome = p284.Name == "CameraDome"
	local PrimaryPart = p284.PrimaryPart
	local Copy = p284.CameraScreenGui:Clone()
	Copy.Parent = LocalPlayer.PlayerGui
	Copy.Sound:Play()
	Custom = CurrentCamera.CameraType
	Humanoid = CurrentCamera.CameraSubject
	
	if IsCameraDome then
		CurrentCamera.CameraSubject = PrimaryPart
	else
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
	end
	RunService:BindToRenderStep("CameraBlock", 1, function() --[[ Line: 2498 ]]
		-- upvalues: IsCameraDome (copy), CurrentCamera (upval), PrimaryPart (copy), Copy (copy)
		if not IsCameraDome then
			CurrentCamera.CFrame = PrimaryPart.CFrame * CFrame.new(0, 0, 1.1) * CFrame.Angles(0, 3.141592653589793, 0)
		end
		if os.time() % 2 == 1 then
			Copy.Frame.Crosshairs.RecCircle.Visible = false
			
			return
		else
			Copy.Frame.Crosshairs.RecCircle.Visible = true
		end
	end)
	AncestryChangedConnection = PrimaryPart.AncestryChanged:Connect(function() --[[ Line: 2509 ]]
		-- upvalues: PrimaryPart (copy)
		if not PrimaryPart:IsDescendantOf(game) then
			deactivateCam()
		end
	end)
	MouseButton1ClickConnection = Copy:WaitForChild("Frame"):WaitForChild("ExitLabel"):WaitForChild("ExitButton").MouseButton1Click:Connect(function() --[[ Line: 2515 ]]
		-- upvalues: MouseButton1ClickConnection (upval)
		MouseButton1ClickConnection:Disconnect()
		MouseButton1ClickConnection = nil
		deactivateCam()
	end)
	Connection = LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("SeatPart"):Connect(function() --[[ Line: 2521 ]]
		-- upvalues: LocalPlayer (copy)
		local SeatPart = LocalPlayer.Character.Humanoid.SeatPart
		
		if not SeatPart or SeatPart:IsA("VehicleSeat") then
			deactivateCam()
		end
	end)
end

function deactivateCam() --[[ Line: 2529 ]]
	-- upvalues: v18 (ref), AncestryChangedConnection (ref), MouseButton1ClickConnection (ref), Connection (ref), RunService (copy), CurrentCamera (copy), Custom (ref), Humanoid (ref)
	v18 = nil
	local LocalPlayer = game.Players.LocalPlayer
	
	if AncestryChangedConnection then
		AncestryChangedConnection:Disconnect()
		AncestryChangedConnection = nil
	end
	if MouseButton1ClickConnection then
		MouseButton1ClickConnection:Disconnect()
		MouseButton1ClickConnection = nil
	end
	if Connection then
		Connection:Disconnect()
		Connection = nil
	end
	pcall(function() --[[ Line: 2544 ]]
		-- upvalues: RunService (upval)
		RunService:UnbindFromRenderStep("CameraBlock")
	end)
	CurrentCamera.CameraType = Custom
	CurrentCamera.CameraSubject = Humanoid
	local CameraScreenGui = LocalPlayer.PlayerGui:FindFirstChild("CameraScreenGui")
	
	if CameraScreenGui then
		CameraScreenGui:Destroy()
	end
end

if not v10 then
	LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 2554 ]]
		-- upvalues: LocalPlayer (copy)
		if LocalPlayer.PlayerGui:FindFirstChild("CameraScreenGui") then
			deactivateCam()
		end
	end)
end
Module.Thruster = {}
Module.Thruster.defaultKeys = Module.Delay.defaultKeys
Module.Thruster.canSetNetworkOwner = true
Module.Thruster.getState = Module.LightBulb.getState
Module.Thruster.calState = Module.LightBulb.calState

function Module.Thruster.setState(_, p286, _, _, _, _, _, _, p293): boolean --[[ Line: 2567 ]]
	-- upvalues: Module (copy), v10 (copy)
	local v316 = false
	local PrimaryPart = p286.PrimaryPart
	
	if Module[p286.Name].getState(p286) ~= p293 and (not p293 or not PrimaryPart:IsGrounded() and p286.Fuel.Value > 0) then
		v316 = true
		setState(p286, "On", p293)
		
		if not v10 then
			local function _(p294) --[[ Line: 2579 | Named "stopThrust" ]]
				p294.ThrusterSound:Stop()
				p294.BodyThrust.Force = Vector3.new(0, 0, 0)
				p294.ParticleEmitter.Enabled = false
				local ParticleEmitter2 = p294:FindFirstChild("ParticleEmitter2")
				
				if ParticleEmitter2 then
					ParticleEmitter2.Enabled = false
				end
			end
			
			if p293 then
				PrimaryPart.BodyThrust.Force = Vector3.new(0, 0, -1) * ((function(p295) --[[ Line: 2591 | Named "getTotalMass" ]]
					local ConnectedParts = p295:GetConnectedParts(true)
					local Mass = p295:GetMass()
					
					for i = 1, #ConnectedParts do
						Mass += ConnectedParts[i]:GetMass()
						
						if i >= 850 then
							return Mass
						end
					end
					return Mass
				end)(PrimaryPart) * workspace.Gravity) * p286.MassMuiltiplier.Value + Vector3.new(0, 0, 10)
				PrimaryPart.ParticleEmitter.Enabled = true
				local ParticleEmitter2 = PrimaryPart:FindFirstChild("ParticleEmitter2")
				
				if ParticleEmitter2 then
					ParticleEmitter2.Enabled = true
				end
				PrimaryPart.ThrusterSound:Play()
				task.spawn(function() --[[ Line: 2613 ]]
					-- upvalues: p286 (copy), PrimaryPart (copy)
					local CurrentTime = tick()
					p286.LastGlobalTick.Value = CurrentTime
					local v325 = 0
					while PrimaryPart.Parent and p286.LastGlobalTick.Value == CurrentTime and p286.Fuel.Value > 0 do
						local Fuel = p286.Fuel
						Fuel.Value -= v325
						v325 = task.wait(0.2)
					end
					if PrimaryPart.Parent and (p286.Parent and p286.Fuel.Value <= 0) then
						local v326 = PrimaryPart
						v326.ThrusterSound:Stop()
						v326.BodyThrust.Force = Vector3.new(0, 0, 0)
						v326.ParticleEmitter.Enabled = false
						local ParticleEmitter2 = v326:FindFirstChild("ParticleEmitter2")
						
						if ParticleEmitter2 then
							ParticleEmitter2.Enabled = false
						end
						p286.ClickDetector:Destroy()
						PrimaryPart.BrickColor = BrickColor.Red()
					end
				end)
				
				return v316
			else
				p286.LastGlobalTick.Value = 0
				PrimaryPart.ThrusterSound:Stop()
				PrimaryPart.BodyThrust.Force = Vector3.new(0, 0, 0)
				PrimaryPart.ParticleEmitter.Enabled = false
				local ParticleEmitter2 = PrimaryPart:FindFirstChild("ParticleEmitter2")
				
				if ParticleEmitter2 then
					ParticleEmitter2.Enabled = false
				end
			end
		end
	end
	return v316
end

Module.MegaThruster = Module.Thruster
Module.UltraThruster = Module.Thruster
Module.WinterThruster = Module.Thruster
Module.HalloweenThruster = Module.Thruster
Module.LockedDoor = {}
Module.LockedDoor.defaultKeys = Module.Delay.defaultKeys
Module.LockedDoor.getState = Module.LightBulb.getState
Module.LockedDoor.calState = Module.LightBulb.calState

function Module.LockedDoor.setState(_, p297, _, _, _, _, _, _, p304): boolean --[[ Line: 2652 ]]
	-- upvalues: Module (copy), v10 (copy)
	local v329 = false
	
	if Module[p297.Name].getState(p297) ~= p304 then
		setState(p297, "On", p304)
		v329 = true
		
		if v10 then
			local Door = p297.Door
			local PPart = p297.PPart
			local IsWoodDoor = p297.Name == "WoodDoor"
			local IsWoodTrapDoor = p297.Name == "WoodTrapDoor"
			local v336: number = if IsWoodDoor then 0 else 0.5
			Door:BreakJoints()
			
			if IsWoodTrapDoor then
				if p304 then
					Door:SetPrimaryPartCFrame(Door.PrimaryPart.CFrame * CFrame.new(-PPart.Size.X / 2, 0, 0))
					Door:SetPrimaryPartCFrame(Door.PrimaryPart.CFrame * CFrame.Angles(0, 0, -1.5707963267948966))
					Door:SetPrimaryPartCFrame(Door.PrimaryPart.CFrame * CFrame.new(PPart.Size.X / 2, 0, 0))
				else
					Door:SetPrimaryPartCFrame(Door.PrimaryPart.CFrame * CFrame.new(-PPart.Size.X / 2, 0, 0))
					Door:SetPrimaryPartCFrame(Door.PrimaryPart.CFrame * CFrame.Angles(0, 0, 1.5707963267948966))
					Door:SetPrimaryPartCFrame(Door.PrimaryPart.CFrame * CFrame.new(PPart.Size.X / 2, 0, 0))
				end
			elseif p304 then
				Door:SetPrimaryPartCFrame(Door.PrimaryPart.CFrame * CFrame.new(-PPart.Size.X / 2 + v336, 0, 0))
				Door:SetPrimaryPartCFrame(Door.PrimaryPart.CFrame * CFrame.Angles(0, -1.5707963267948966, 0))
				Door:SetPrimaryPartCFrame(Door.PrimaryPart.CFrame * CFrame.new(PPart.Size.X / 2 - v336, 0, 0))
			else
				Door:SetPrimaryPartCFrame(Door.PrimaryPart.CFrame * CFrame.new(-PPart.Size.X / 2 + v336, 0, 0))
				Door:SetPrimaryPartCFrame(Door.PrimaryPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 0))
				Door:SetPrimaryPartCFrame(Door.PrimaryPart.CFrame * CFrame.new(PPart.Size.X / 2 - v336, 0, 0))
			end
			local Children = Door:GetChildren()
			
			for i = 1, #Children do
				local v330 = Children[i]
				
				if v330:IsA("BasePart") then
					WeldTogether(v330, PPart)
				end
			end
			if PPart.Sound.Playing then
				PPart.Sound:Stop()
			end
			PPart.Sound:Play()
		end
	end
	return v329
end

Module.WoodDoor = Module.LockedDoor
Module.WoodTrapDoor = Module.LockedDoor
Module.JetTurbine = {}
Module.JetTurbine.defaultKeys = Module.Delay.defaultKeys
Module.JetTurbine.canSetNetworkOwner = true
Module.JetTurbine.getState = Module.LightBulb.getState
Module.JetTurbine.calState = Module.LightBulb.calState

function Module.JetTurbine.setState(_, p306, _, _, _, _, _, _, p313): boolean --[[ Line: 2728 ]]
	-- upvalues: Module (copy), v10 (copy), Heartbeat (copy)
	local v337 = false
	local PrimaryPart = p306.PrimaryPart
	
	if Module[p306.Name].getState(p306) ~= p313 and (not p313 or not PrimaryPart:IsGrounded() and p306.Fuel.Value > 0) then
		v337 = true
		setState(p306, "On", p313)
		
		if not v10 then
			local function stopThrust(p314) --[[ Line: 2740 ]]
				local Parent = p314.Parent
				p314.BodyVelocity.MaxForce = Vector3.new(0, 0, 0)
				Parent.Nose.Reflectance = 0
				p314.Sound:Stop()
				Parent.Nose.Trail.Enabled = false
				local Trail2 = Parent.Nose:FindFirstChild("Trail2")
				
				if Trail2 then
					Trail2.Enabled = false
				end
				local Trail3 = Parent.Nose:FindFirstChild("Trail3")
				
				if Trail3 then
					Trail3.Enabled = false
				end
			end
			
			if p313 then
				local X: number = p306.MaxForce.Value
				
				if X == 10000000000 then
					X = 1e999
				end
				PrimaryPart.BodyVelocity.MaxForce = Vector3.new(X, X, X)
				p306.Nose.Reflectance = 0.5
				PrimaryPart.Sound:Play()
				p306.Nose.Trail.Enabled = true
				local Trail2 = p306.Nose:FindFirstChild("Trail2")
				
				if Trail2 then
					Trail2.Enabled = true
				end
				local Trail3 = p306.Nose:FindFirstChild("Trail3")
				
				if Trail3 then
					Trail3.Enabled = true
				end
				task.spawn(function() --[[ Line: 2775 ]]
					-- upvalues: PrimaryPart (copy), p306 (copy), Heartbeat (upval), stopThrust (copy)
					local function _(): boolean --[[ Line: 2777 | Named "inStages" ]]
						-- upvalues: PrimaryPart (upval)
						local Position = PrimaryPart.Position
						
						return Position.Z > 1359 and Position.Z < 8358
					end
					
					local _ = function(): boolean --[[ Line: 2785 | Named "outOfBounds" ]]
						-- upvalues: PrimaryPart (upval)
						local Position = PrimaryPart.Position
						local Position_1 = PrimaryPart.Position
						
						return Position_1.Z > 1359 and Position_1.Z < 8358 and (Position.Y >= 150 or (Position.Y <= -18 or (Position.X >= 525 or Position.X <= -530)))
					end
					
					local CurrentTime = tick()
					p306.LastGlobalTick.Value = CurrentTime
					local Value: number = p306.MaxStageSpeed.Value
					local v349 = 0
					while PrimaryPart.Parent and p306.LastGlobalTick.Value == CurrentTime and p306.Fuel.Value > 0 do
						local Fuel = p306.Fuel
						Fuel.Value -= v349
						local Value: number = p306.MaxSpeed.Value
						local Position = PrimaryPart.Position
						
						if Position.Z < 8358 or Position.Z > 1359 then
							local Position = PrimaryPart.Position
							local Position_1 = PrimaryPart.Position
							
							if Position.Y >= 150 or (Position.Y <= -18 or (Position.X >= 525 or Position.X <= -530)) or Position_1.Z > 1359 and Position_1.Z < 8358 then
								PrimaryPart.BodyVelocity.Velocity = PrimaryPart.CFrame.LookVector * Value
							else
								PrimaryPart.BodyVelocity.Velocity = PrimaryPart.CFrame.LookVector * math.min(Value, Value)
							end
							v349 = Heartbeat:Wait()
						end
					end
					if PrimaryPart.Parent and p306.Parent and p306.Fuel.Value <= 0 then
						stopThrust(PrimaryPart)
						p306.ClickDetector:Destroy()
						p306.Nose.BrickColor = BrickColor.Red()
					end
				end)
				
				return v337
			else
				p306.LastGlobalTick.Value = 0
				stopThrust(PrimaryPart)
			end
		end
	end
	return v337
end

Module.SonicJetTurbine = Module.JetTurbine
Module.JetTurbineWinter = Module.JetTurbine
Module.BalloonBlock = {}
Module.BalloonBlock.defaultKeys = Module.Delay.defaultKeys
Module.BalloonBlock.getState = Module.LightBulb.getState
Module.BalloonBlock.calState = Module.LightBulb.calState

function Module.BalloonBlock.setState(_, p316, _, _, _, Callback, _, _, p322): boolean --[[ Line: 2837 ]]
	-- upvalues: Module (copy), v10 (copy), GetBlockInfoModule (copy)
	local v358 = false
	local _ = p316.PrimaryPart
	
	if Module[p316.Name].getState(p316) ~= p322 then
		v358 = true
		setState(p316, "On", p322)
		
		if v10 then
			local PrimaryPart = p316.PrimaryPart
			
			if p322 then
				local _, v368 = GetBlockInfoModule(p316)
				local IsBalloonStarBlock = p316.Name == "BalloonStarBlock"
				local BalloonPart_1 = p316:FindFirstChild("BalloonPart")
				local v370 = PrimaryPart.Size.X * PrimaryPart.Size.Y * PrimaryPart.Size.Z
				
				if BalloonPart_1 then
					BalloonPart_1:BreakJoints()
					local NoWelds = BalloonPart_1:FindFirstChild("NoWelds")
					
					if NoWelds then
						NoWelds:Destroy()
					end
				else
					BalloonPart_1 = if IsBalloonStarBlock then game.ReplicatedStorage.BuildingParts.Star.PrimaryPart:Clone() else Instance.new("Part")
				end
				BalloonPart_1.Size = Vector3.new(math.min(3.5 + (v370 - 1) / 2.2, 250), math.min(3.5 + (v370 - 1) / 2.2, 250), (math.min(3.5 + (v370 - 1) / 2.2, 250)))
				
				if PrimaryPart.Color ~= game.ReplicatedStorage.BuildingParts[p316.Name].PrimaryPart.Color then
					BalloonPart_1.Color = PrimaryPart.Color
				elseif IsBalloonStarBlock then
					local list = {
						Color3.fromRGB(27, 42, 53),
						Color3.fromRGB(255, 255, 0),
						Color3.fromRGB(255, 176, 0)
					}
					BalloonPart_1.Color = list[math.random(1, #list)]
				else
					BalloonPart_1.BrickColor = BrickColor.Random()
				end
				BalloonPart_1.Name = "BalloonPart"
				BalloonPart_1.Anchored = false
				BalloonPart_1.CanCollide = false
				BalloonPart_1.Material = Enum.Material.SmoothPlastic
				BalloonPart_1.Transparency = 0.1
				BalloonPart_1.CastShadow = false
				BalloonPart_1.CollisionGroup = tostring(v368.TeamColor) .. "CG"
				PrimaryPart.RopeConstraint.Thickness = math.clamp(v370 / 100, 0.1, 1)
				local Att1 = Instance.new("Attachment")
				Att1.Name = "Att1"
				Att1.Parent = BalloonPart_1
				
				if IsBalloonStarBlock then
					BalloonPart_1.CFrame = PrimaryPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
				else
					BalloonPart_1.CFrame = PrimaryPart.CFrame
					BalloonPart_1.Shape = "Ball"
				end
				local BalloonWeld_1 = PrimaryPart:FindFirstChild("BalloonWeld")
				
				if BalloonWeld_1 then
					BalloonWeld_1:Destroy()
				end
				local BalloonWeld = WeldTogether(PrimaryPart, BalloonPart_1)
				BalloonWeld.Name = "BalloonWeld"
				BalloonPart_1.Parent = PrimaryPart.Parent
				PrimaryPart.RopeConstraint.Attachment1 = Att1
				PrimaryPart.RopeConstraint.Enabled = true
				PrimaryPart.InflateSound:Play()
				task.delay(2, function() --[[ Line: 2924 ]]
					-- upvalues: BalloonWeld (copy), BalloonPart_1 (ref), PrimaryPart (copy), v370 (copy)
					if BalloonWeld.Parent then
						BalloonWeld:Destroy()
					end
					if BalloonPart_1.Parent then
						PrimaryPart.RopeConstraint.Length = 4.5 + BalloonPart_1.Size.Y
						local BodyVelocity = Instance.new("BodyVelocity")
						BodyVelocity.MaxForce = Vector3.new(500, math.pow(10000, v370) + BalloonPart_1:GetMass() * workspace.Gravity, 500)
						BodyVelocity.Velocity = Vector3.new(0, 6, 0)
						BodyVelocity.Parent = BalloonPart_1
					end
				end)
				
				return v358
			else
				local BalloonPart = p316:FindFirstChild("BalloonPart")
				while BalloonPart do
					BalloonPart:Destroy()
					BalloonPart = p316:FindFirstChild("BalloonPart")
				end
				PrimaryPart.InflateSound:Stop()
				PrimaryPart.PopSound:Play()
			end
		end
	end
	return v358
end

Module.BalloonStarBlock = Module.BalloonBlock
Module.ParachuteBlock = {}
Module.ParachuteBlock.defaultKeys = Module.Delay.defaultKeys
Module.ParachuteBlock.getState = Module.LightBulb.getState
Module.ParachuteBlock.calState = Module.LightBulb.calState

function Module.ParachuteBlock.setState(_, p324, _, _, _, _, _, _, p331): boolean --[[ Line: 2964 ]]
	-- upvalues: Module (copy), v10 (copy), GetBlockInfoModule (copy)
	local v373 = false
	local _ = p324.PrimaryPart
	
	if Module[p324.Name].getState(p324) ~= p331 then
		v373 = true
		setState(p324, "On", p331)
		
		if v10 then
			local PrimaryPart = p324.PrimaryPart
			
			if p331 then
				local _, v382 = GetBlockInfoModule(p324)
				local v383 = PrimaryPart.Size.X * PrimaryPart.Size.Y * PrimaryPart.Size.Z
				local Smallest = math.min(30, (math.sqrt(v383)))
				local Copy = game.ReplicatedStorage.OtherParts.Parachute:Clone()
				Copy.PrimaryPart.Size *= Smallest
				local Descendants = Copy:GetDescendants()
				
				for i1 = 1, #Descendants do
					local v380 = Descendants[i1]
					
					if v380:IsA("Bone") or v380:IsA("Attachment") then
						v380.Position *= Smallest
					elseif v380:IsA("RopeConstraint") then
						v380.Length *= Smallest
					end
				end
				if PrimaryPart.Color ~= game.ReplicatedStorage.BuildingParts[p324.Name].PrimaryPart.Color then
					Copy.PrimaryPart.Color = PrimaryPart.Color
				end
				Copy.PrimaryPart.CollisionGroup = tostring(v382.TeamColor) .. "CG"
				local ClampedValue = math.clamp(Smallest / 100, 0.1, 1)
				Copy.PrimaryPart.CFrame = PrimaryPart.CFrame
				Copy.Parent = p324
				PrimaryPart.OpenSound:Play()
				Copy.AnimationController:LoadAnimation(Copy.Open):Play()
				local Children = Copy:GetChildren()
				
				for i = 1, #Children do
					local v377 = Children[i]
					
					if v377:IsA("RopeConstraint") then
						v377.Thickness = ClampedValue
						v377.Attachment1 = PrimaryPart.Att
					end
				end
				local BodyVelocity = Instance.new("BodyVelocity")
				BodyVelocity.MaxForce = Vector3.new(500, 10000 * v383 + Copy.PrimaryPart:GetMass() * workspace.Gravity, 500)
				BodyVelocity.Velocity = Vector3.new(0, -6, 0)
				BodyVelocity.Parent = Copy.PrimaryPart
				
				return v373
			else
				local Parachute = p324:FindFirstChild("Parachute")
				while Parachute do
					Parachute:Destroy()
					Parachute = p324:FindFirstChild("Parachute")
				end
				PrimaryPart.CloseSound:Play()
			end
		end
	end
	return v373
end

Module.ShieldGenerator = {}
Module.ShieldGenerator.defaultKeys = Module.Delay.defaultKeys
Module.ShieldGenerator.getState = Module.LightBulb.getState
Module.ShieldGenerator.calState = Module.LightBulb.calState

function Module.ShieldGenerator.setState(_, p333, _, _, _, _, _, _, p340: boolean): boolean --[[ Line: 3047 ]]
	-- upvalues: Module (copy), v10 (copy), TweenService (copy)
	local v388 = false
	local _ = p333.PrimaryPart
	
	if Module[p333.Name].getState(p333) ~= p340 then
		v388 = true
		local v393 = (function(p341) --[[ Line: 3057 | Named "findOnFriend" ]]
			local Value = nil
			local Children = p341:GetChildren()
			
			for i = 1, #Children do
				local v395 = Children[i]
				
				if v395:IsA("ObjectValue") and v395.Name == "Friend" then
					Value = v395.Value
					
					if Value and Value.Parent then
						if Value:GetAttribute("On") then
							return Value
						end
					else
						v395:Destroy()
					end
				end
			end
		end)(p333) or p333
		
		if v393 ~= p333 then
			p340 = false
			p333 = v393
		end
		setState(p333, "On", p340)
		local PrimaryPart = p333.PrimaryPart
		
		if v10 then
			PrimaryPart.Activate:Invoke(p340)
			
			return v388
		elseif p340 then
			local X = math.min(math.sqrt(p333.NumOfFriends.Value + 1) * 60, 360)
			p333.ForceFieldServer.Transparency = 1
			TweenService:Create(p333.ForceField1, TweenInfo.new(5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false), { Size = Vector3.new(X, X, X) }):Play()
			TweenService:Create(p333.ForceField2, TweenInfo.new(5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false), { Size = Vector3.new(X, X, X) + Vector3.new(5, 5, 5) }):Play()
			PrimaryPart.Sound2:Stop()
			PrimaryPart.Sound:Play()
			
			return v388
		else
			local config = { Size = Vector3.new() }
			local _TweenInfo = TweenInfo.new(1.75, Enum.EasingStyle.Quart, Enum.EasingDirection.In, 0, false)
			TweenService:Create(p333.ForceField1, _TweenInfo, config):Play()
			TweenService:Create(p333.ForceField2, _TweenInfo, config):Play()
			PrimaryPart.Sound2:Play()
		end
	end
	return v388
end

Module.Magnet = {}
Module.Magnet.defaultKeys = Module.Delay.defaultKeys
Module.Magnet.getState = Module.LightBulb.getState
Module.Magnet.calState = Module.LightBulb.calState

function Module.Magnet.setState(p342, p343, _, _, _, _, _, _, p350): boolean --[[ Line: 3139 ]]
	-- upvalues: Module (copy), v10 (copy)
	local v397 = false
	local _ = p343.PrimaryPart
	
	if Module[p343.Name].getState(p343) ~= p350 then
		v397 = true
		setState(p343, "On", p350)
		local PrimaryPart = p343.PrimaryPart
		
		if v10 then
			PrimaryPart.Activate:Invoke(game.Players:GetPlayerByUserId(p342), p350)
		end
	end
	return v397
end

function WeldTogether(p351, p352) --[[ Line: 3164 ]]
	if p351:HasTag("NoNewWelds") or p352:HasTag("NoNewWelds") then return end
	local Weld = Instance.new("Weld")
	Weld.Part0 = p351
	Weld.Part1 = p352
	Weld.C0 = CFrame.new()
	Weld.C1 = p352.CFrame:toObjectSpace(p351.CFrame)
	Weld.Parent = p351
	
	return Weld
end

function displayError(p353) --[[ Line: 3178 ]]
	warn("An error occurred!\nError:", p353, "\nTraceback:", debug.traceback())
end

function Module.addBulkToRunQueue(p354, Entry) --[[ Line: 3182 ]]
	-- upvalues: Module (copy), CollectionService (copy), t1 (copy), t2 (copy), t (ref)
	if not Entry[1] then return end
	for i2 = #Entry, 1, -1 do
		local v401 = Entry[i2]
		local v402 = v401[1]
		
		if not v402 or not Module[v402.Name] then
			table.remove(Entry, i2)
			continue
		end
		local v407 = v401[2]
		local v408 = v401[3]
		local v409 = v401[4]
		
		if CollectionService:HasTag(v402, "SeatInput") then
			local _ = v401[9]
		end
		local Stateless = Module[v402.Name].stateless
		
		if Stateless and not (if Stateless then Module[v402.Name].willActivate(v402, v407, v408, v409) else nil) then
			table.remove(Entry, i2)
		else
			if Stateless then
				v401[8] = true
			end
			if t1[p354] and t1[p354][v402] then
				if CollectionService:HasTag(v402, "SeatInput") then
					local v403 = v401[9]
					
					for i1, value in pairs(t1[p354][v402][9]) do
						if v403[i1] == nil then
							v403[i1] = value
						end
					end
				end
				for i = 1, math.max(#v401, #t1[p354][v402]) do
					t1[p354][v402][i] = v401[i]
				end
				table.remove(Entry, i2)
				continue
			else
				if not t1[p354] then
					t1[p354] = {}
					t2[p354] = 0
				end
				t1[p354][v402] = v401
				local v404 = t2
				v404[p354] += 1
			end
		end
	end
	if Entry[1] then
		if not t[p354] then
			t[p354] = {}
		end
		table.insert(t[p354], Entry)
		checkToRunQueue(p354)
	end
end

function addConnectionsToQueue(Entry, p355, p356, p357, p358, p359, p360, p361) --[[ Line: 3264 ]]
	-- upvalues: Module (copy), t3 (ref)
	local v412 = nil
	local v413 = nil
	if not Entry[1] then return end
	local t = {}
	local v411 = false
	
	for i = 1, #Entry do
		local v410 = Entry[i]
		
		if v410:IsA("Beam") then
			if v410.Attachment1 and v410.Attachment1.Parent and v410.Attachment1.Parent.Parent and v410.Attachment1.Parent.Parent.Parent then
				local Parent = v410.Attachment1.Parent.Parent
				
				if p361 then
					local DefaultKeys = Module[Parent.Name].defaultKeys
					
					local function _(p362): boolean --[[ Line: 3283 | Named "checkBind" ]]
						-- upvalues: DefaultKeys (copy), Parent (copy), p361 (copy)
						local v428 = DefaultKeys[p362]
						
						if v428 then
							local Value = Parent[p362].Value
							
							if Value == -1 then
								if p361[v428[1].Value] or p361[v428[2].Value] then
									return true
								end
							elseif p361[Value] then
								return true
							end
						end
						return false
					end
					
					local BindFire = DefaultKeys.BindFire
					
					if BindFire then
						local Value = Parent.BindFire.Value
						
						if Value == -1 then
							if p361[BindFire[1].Value] or p361[BindFire[2].Value] then
								v413 = true
							else
								v413 = false
							end
							if not v413 then
								local BindUp = DefaultKeys.BindUp
								
								if BindUp then
									local Value = Parent.BindUp.Value
									
									if Value == -1 then
										if p361[BindUp[1].Value] or p361[BindUp[2].Value] then
											v413 = true
										else
											v413 = false
										end
										if not v413 then
											local BindDown = DefaultKeys.BindDown
											
											if BindDown then
												local Value = Parent.BindDown.Value
												
												if Value == -1 then
													if p361[BindDown[1].Value] or p361[BindDown[2].Value] then
														v413 = true
													else
														v413 = false
													end
													if not v413 then
														local BindLeft = DefaultKeys.BindLeft
														
														if BindLeft then
															local Value = Parent.BindLeft.Value
															
															if Value == -1 then
																if p361[BindLeft[1].Value] or p361[BindLeft[2].Value] then
																	v413 = true
																else
																	v413 = false
																end
																if not v413 then
																	local BindRight = DefaultKeys.BindRight
																	
																	if BindRight then
																		local Value = Parent.BindRight.Value
																		
																		if Value == -1 then
																			if p361[BindRight[1].Value] or p361[BindRight[2].Value] then
																				v413 = true
																			else
																				v413 = false
																			end
																		else
																			if p361[Value] then
																				v413 = true
																			end
																		end
																	end
																end
															else
																if p361[Value] then
																	v413 = true
																end
															end
														end
													end
												else
													if p361[Value] then
														v413 = true
													end
												end
											end
										end
									else
										if p361[Value] then
											v413 = true
										end
									end
								end
							end
							v412 = v413
						else
							if p361[Value] then
								v413 = true
							end
						end
					end
				else
					v412 = true
				end
				if v412 then
					table.insert(t, {
						Parent, p356, p357, p358, p359, p360, true, false
					})
					
					if Parent:GetAttribute("Running") then
						v411 = true
					end
				end
			elseif v410.Attachment1 == nil or (v410.Attachment1.Parent == nil or (v410.Attachment1.Parent.Parent == nil or v410.Attachment1.Parent.Parent.Parent == nil)) then
				v410:Destroy()
			end
		end
	end
	if t[1] then
		table.insert(t, v411)
		
		if not t3[p355] then
			t3[p355] = {}
		end
		table.insert(t3[p355], t)
		checkToRunQueue(p355)
	end
end

local t5 = {}
local t6 = {}

function checkToRunQueue(p363) --[[ Line: 3359 ]]
	-- upvalues: t6 (copy), t5 (copy), t (ref), t3 (ref), Module (copy), t1 (copy), t2 (copy), v10 (copy), SetNetworkOwnerModule (copy)
	if not t6[p363] then
		t6[p363] = true
		task.spawn(function() --[[ Line: 3365 ]]
			-- upvalues: t5 (upval), t (upval), p363 (copy), t3 (upval), Module (upval), t1 (upval), t2 (upval), v10 (upval), SetNetworkOwnerModule (upval), t6 (upval)
			local v430 = 0
			
			local function spendBudget(p364, p365) --[[ Line: 3369 ]]
				-- upvalues: t5 (upval), v430 (ref)
				if not t5[p364] then
					t5[p364] = 20
				end
				while t5[p364] < p365 do
					task.wait(0.016666666666666666)
					t5[p364] += v430
					v430 = 0
				end
				t5[p364] -= p365
				v430 += p365
			end
			
			xpcall(function() --[[ Line: 3386 ]]
				-- upvalues: t (upval), p363 (upval), t3 (upval), Module (upval), t1 (upval), t2 (upval), v10 (upval), spendBudget (copy), SetNetworkOwnerModule (upval)
				while t[p363] and t[p363][1] or t3[p363] and t3[p363][1] do
					if t3[p363] then
						while t3[p363][1] do
							local Removed_1 = table.remove(t3[p363], 1)
							table.remove(Removed_1, #Removed_1)
							Module.addBulkToRunQueue(p363, Removed_1)
						end
						t3[p363] = nil
					end
					local t4 = {}
					
					if t[p363] and t[p363][1] then
						local Removed = table.remove(t[p363], 1)
						while Removed[1] do
							local list = table.remove(Removed, 1)
							local v454 = list[1]
							
							if t1[p363] and t1[p363][v454] then
								t1[p363][v454] = nil
								local v452 = t2
								local v453 = p363
								v452[v453] -= 1
								
								if t2[p363] < 1 then
									t1[p363] = nil
									t2[p363] = nil
								end
							end
							local v445 = list[2]
							local v446 = list[3]
							local v447 = list[4]
							local v448 = list[5]
							local v449 = list[6]
							local v450 = list[7]
							local v451 = list[8]
							local CalStateFunction = Module[v454.Name].calState
							
							if not v454 or not v454.Parent then continue end
							if v451 then
								table.remove(list, 8)
							else
								list = {
									v454, v445, v446, v447, v448, v449, v450,
									CalStateFunction(p363, v445, v446, v447, v454)
								}
							end
							table.insert(t4, list)
							
							if not v10 then
								v454:SetAttribute("Running", true)
							end
							spendBudget(p363, 0.1)
						end
					end
					while t4[1] do
						local Removed = table.remove(t4, 1)
						local v441 = Removed[1]
						local _ = Removed[5]
						local v443 = Removed[6]
						local SetStateFunction = Module[v441.Name].setState
						
						if not v10 then
							v441:SetAttribute("Running", nil)
						end
						if not v441 or not v441.Parent then continue end
						local v438, v439 = SetStateFunction(p363, table.unpack(Removed))
						
						if v438 then
							if Removed[7] then
								if v441.Name == "Delay" then
									sendRequestToOtherClients({
										Removed[1], Removed[2], Removed[3], Removed[4], Removed[5], Removed[6], false,
										true, not Removed[8], Removed[9], v441.WaitDuration.Value
									})
								else
									sendRequestToOtherClients({
										Removed[1], Removed[2], Removed[3], Removed[4], Removed[5], Removed[6], false,
										true, Removed[8] or v441.Name == "DisplayBlock" and v439, Removed[9],
										Removed[10], Removed[11]
									})
								end
							end
							spendBudget(p363, 1)
						end
						if not v438 or (not Module[v441.Name].canSetNetworkOwner or not v443) then continue end
						if v10 then
							SetNetworkOwnerModule(v441, (game.Players:GetPlayerByUserId(p363)))
						else
							local Descendants = v441:GetDescendants()
							
							for i = 1, #Descendants do
								local v435 = Descendants[i]
								
								if v435:IsA("BasePart") then
									local AssemblyRootPart = v435.AssemblyRootPart
									
									if AssemblyRootPart then
										AssemblyRootPart:SetAttribute("LastRequesterID", p363)
									end
								end
							end
						end
					end
					if not t3[p363] then continue end
					local v433 = #t3[p363]
					local v432 = 1
					while v433 > 0 do
						local v434 = t3[p363][v432]
						
						if v434[#v434] then
							table.insert(t3[p363], (table.remove(t3[p363], v432)))
						else
							v432 += 1
						end
						v433 -= 1
					end
				end
			end, displayError)
			t6[p363] = nil
			
			if t[p363] then
				t[p363] = nil
			end
			if t3[p363] then
				t3[p363] = nil
			end
			if t1[p363] then
				t1[p363] = nil
			end
			if t2[p363] then
				t2[p363] = nil
			end
			if v430 > 0 then
				task.wait(0.016666666666666666)
				t5[p363] += v430
				
				if t5[p363] == 20 and not t6[p363] then
					t5[p363] = nil
				end
			end
		end)
	end
end

local v27 = false
local t7 = {}

function sendRequestToOtherClients(p366) --[[ Line: 3612 ]]
	-- upvalues: t7 (ref), v27 (ref), v10 (copy), QueueBlocksRequest (copy)
	if #t7 < 50 then
		table.insert(t7, p366)
	end
	if not v27 then
		v27 = true
		task.spawn(function() --[[ Line: 3623 ]]
			-- upvalues: t7 (upval), v10 (upval), QueueBlocksRequest (upval), v27 (upval)
			while t7[1] do
				if not v10 then
					QueueBlocksRequest:FireServer(t7)
					t7 = {}
				end
				task.wait(0.016666666666666666)
			end
			v27 = false
		end)
		
		return
	end
end

function Module.getSynchronizeInfo() --[[ Line: 3639 ]]
	-- upvalues: v10 (copy), Module (copy), t (ref), t3 (ref)
	if not v10 then return end
	local t1 = {}
	local _ = {}
	local Children = workspace.Blocks:GetChildren()
	
	for i2 = 1, #Children do
		local v458 = Children[i2]
		local v459 = game.Players:FindFirstChild(v458.Name)
		
		if not v459 then
			continue
		end
		local UserId = v459.UserId
		local Children = v458:GetChildren()
		
		for i1 = 1, #Children do
			local v460 = Children[i1]
			local v461 = Module[v460.Name]
			local IsDisplayBlock: boolean = v461 and (v461.stateless and v460.Name == "DisplayBlock")
			
			if not v461 or v461.stateless and not IsDisplayBlock then
				continue
			elseif not t1[UserId] then
				t1[UserId] = {}
			end
			local list = nil
			
			if IsDisplayBlock then
				local NextColor = game.ReplicatedStorage.InputLocalScript.GetStoredBlockState:Invoke(v460).NextColor
				
				if NextColor then
					list = {
						{
							v460, false, false, false, false, false, false, true, NextColor
						}
					}
				end
			else
				list = {
					{
						v460, false, false, false, false, false, false, true, v461.getState(v460)
					}
				}
			end
			if list then
				table.insert(t1[UserId], list)
			end
		end
	end
	for i, value in pairs(t) do
		if not t1[i] then
			t1[i] = {}
		end
		for _, value_1 in ipairs(value) do
			table.insert(t1[i], value_1)
		end
	end
	return t1, t3
end

function setState(p367, p368, Enabled) --[[ Line: 3703 ]]
	-- upvalues: v10 (copy)
	if Enabled == false then
		Enabled = nil
	end
	if v10 then
		game.ReplicatedStorage.InputLocalScript.StoreBlockState:Invoke(p367, p368, Enabled)
		
		return
	else
		p367:SetAttribute(p368, Enabled)
	end
end

function Module.synchronizeClient() --[[ Line: 3714 ]]
	-- upvalues: v10 (copy), t (ref), t3 (ref)
	if v10 then return end
	t, t3 = game.ReplicatedStorage.InputLocalScript:WaitForChild("getSynchronizeInfo"):InvokeServer()
	
	for i1, _ in pairs(t) do
		checkToRunQueue(i1)
	end
	for i, _ in pairs(t3) do
		checkToRunQueue(i)
	end
end

return Module