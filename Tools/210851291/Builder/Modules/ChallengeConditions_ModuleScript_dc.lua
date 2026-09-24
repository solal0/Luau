-- File created using ByteCode Inspector (https://github.com/solal0/Luau/)

-- Decompiled in 1s by lunaux
-- Path: ReplicatedStorage.Scripts.ChallengeConditions
-- Class: ModuleScript

-- If the script cuts off, click Save below to have the full script as a file.

-- Decompiled using LunaUX-Decompiler V1.4.4. Luau decompiler made by boydev1444 & zyx (discord.gg/2mJUD4XDDT)
-- Decompiled at Thu Sep 24 16:38:49 2026 Pacific Standard Time, took 0.010006 second(s)

local Module = {
	isCompeting = function(p0) --[[ Line: 4 ]]
		return workspace.Challenge.Teams:FindFirstChild(p0.Team.Name)
	end,
	GetBlockCount = function(p1): number --[[ Line: 8 ]]
		local v0 = 0
		local Children = game.Players:GetChildren()
		
		for i = 1, #Children do
			local v2 = Children[i]
			
			if p1.Team ~= v2.Team or not v2:FindFirstChild("Data") then
				continue
			end
			local Children = v2.Data:GetChildren()
			
			for i1 = 1, #Children do
				local v3 = Children[i1]
				
				if v3:FindFirstChild("Used") then
					v0 += v3.Used.Value
				end
			end
		end
		return v0
	end
}

function Module.blockLimitChallengeReached(p2, p3: number) --[[ Line: 28 ]]
	-- upvalues: Module (copy)
	if Module.isCompeting(p2) then
		if p3 and p3 <= 0 then return end
		local Value = workspace.Challenge.Settings.BlockLimit.Value
		
		if Value ~= -1 and Value < (p3 or 0) + Module.GetBlockCount(p2) then
			return true, "Block limit met"
		end
	end
end

function Module.itemRestriction(p4, p5) --[[ Line: 47 ]]
	-- upvalues: Module (copy)
	if not Module.isCompeting(p4) or (workspace.Challenge.Settings.PlaneParts.Value or p5 ~= "PilotSeat" and p5 ~= "JetTurbine" and p5 ~= "JetTurbineWinter" and p5 ~= "SonicJetTurbine" and p5 ~= "JetPack" and p5 ~= "JetPackEaster" and p5 ~= "JetPackStar" and p5 ~= "JetPackSteampunk" and p5 ~= "JetPackUltra") and (workspace.Challenge.Settings.CarParts.Value or p5 ~= "Motor" and (p5 ~= "HugeMotor" and (p5 ~= "Servo" and (p5 ~= "Spring" and (p5 ~= "Hinge" and (p5 ~= "BackWheel" and (p5 ~= "BackWheelCookie" and (p5 ~= "HugeBackWheel" and p5 ~= "FrontWheel" and p5 ~= "FrontWheelCookie" and p5 ~= "HugeFrontWheel")))))))) then return end
	return true, "Challenge restriction met"
end

function isPartInZone(p6, p7): boolean --[[ Line: 53 ]]
	local v6 = if typeof(p6) == "CFrame" then p6.Position else p6.Position
	local Position = p7.Position
	local Size = p7.Size
	local X: number = Size.X
	local _ = Size.Y
	local Z: number = Size.Z
	
	if p7.Rotation.Y > 89 and p7.Rotation.Y < 91 or p7.Rotation.Y < -89 and p7.Rotation.Y > -91 then
		X = Size.Z
		Z = Size.X
	end
	return Position.X - X / 2 < v6.X and (v6.X < Position.X + X / 2 and Position.Z - Z / 2 < v6.Z and v6.Z < Position.Z + Z / 2)
end

return Module