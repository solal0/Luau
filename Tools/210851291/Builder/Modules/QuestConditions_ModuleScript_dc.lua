-- File created using ByteCode Inspector (https://github.com/solal0/Luau/)

-- Decompiled in 1s by lunaux
-- Path: ReplicatedStorage.Scripts.QuestConditions
-- Class: ModuleScript

-- If the script cuts off, click Save below to have the full script as a file.

-- Decompiled using LunaUX-Decompiler V1.4.4. Luau decompiler made by boydev1444 & zyx (discord.gg/2mJUD4XDDT)
-- Decompiled at Thu Sep 24 16:38:36 2026 Pacific Standard Time, took 0.004587 second(s)

function conditions(p0, p1, p2: string, p3, p4) --[[ Line: 1 ]]
	local Value = p0.QuestNum.Value
	local ObjectSpace = p0.CFrame:toObjectSpace(p1)
	
	if Value == 1 then
		if ObjectSpace.Y > 100 then
			return false, "Out of bounds"
		elseif string.find(p2, "Jet") then
			return false, "Quest restriction met"
		else
			return true
		end
	elseif Value == 2 then
		if ObjectSpace.Z > -45 then
			return false, "Out of bounds"
		elseif string.find(p2, "Jet") then
			return false, "Quest restriction met"
		else
			return true
		end
	elseif Value == 3 then
		if ObjectSpace.Z > -106 or ObjectSpace.Z < -134 or ObjectSpace.X > 16 or ObjectSpace.X < -8 or ObjectSpace.Y < 184 then
			return false, "Out of bounds"
		elseif string.find(p2, "Jet") then
			return false, "Quest restriction met"
		else
			return true
		end
	elseif Value == 6 then
		if string.find(p2, "Jet") then
			return false, "Quest restriction met"
		else
			return true
		end
	elseif Value == 8 then
		if ObjectSpace.X < 62.6 then
			return false, "Out of bounds"
		else
			return true
		end
	elseif Value == 9 then
		if string.find(p2, "Jet") then
			return false, "Quest restriction met"
		elseif blockLimitQuestReached(p4, p3, 200) then
			return false, "Block limit met"
		else
			return true
		end
	elseif Value == 100 then
		if ObjectSpace.Z > -45 then
			return false, "Out of bounds"
		else
			return true
		end
	elseif Value ~= 101 then
		return true
	elseif ObjectSpace.Z > 0 then
		return false, "Out of bounds"
	elseif string.find(p2, "Jet") then
		return false, "Quest restriction met"
	elseif p0.Quest.NutCrackerBattle.Timer.Value > 0 then
		return false, "Out of bounds"
	else
		return true
	end
end

function blockLimitQuestReached(p5, p6: number, p7): boolean? --[[ Line: 75 ]]
	if p6 and p6 <= 0 then return end
	local v4: number = p6 or 0
	local Children = game.Players:GetChildren()
	
	for i1 = 1, #Children do
		local v2 = Children[i1]
		
		if p5.Team ~= v2.Team or not v2:FindFirstChild("Data") then
			continue
		end
		local Children = v2.Data:GetChildren()
		
		for i = 1, #Children do
			local v3 = Children[i]
			
			if v3:FindFirstChild("Used") then
				v4 += v3.Used.Value
			end
		end
	end
	if p7 >= v4 then return end
	return true
end

return conditions