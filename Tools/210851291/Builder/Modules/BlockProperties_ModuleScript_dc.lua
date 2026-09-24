-- File created using ByteCode Inspector (https://github.com/solal0/Luau/)

-- Decompiled in 1s by lunaux
-- Path: ReplicatedStorage.Scripts.BlockProperties
-- Class: ModuleScript

-- If the script cuts off, click Save below to have the full script as a file.

-- Decompiled using LunaUX-Decompiler V1.4.4. Luau decompiler made by boydev1444 & zyx (discord.gg/2mJUD4XDDT)
-- Decompiled at Thu Sep 24 7:12:23 2026 Pacific Standard Time, took 0.027305 second(s)

local Module = {}
setmetatable(Module, {
	__index = function(p0, p1) --[[ Line: 4 ]]
		p0[p1] = {}
		
		return p0[p1]
	end
})
local _ = game:GetService("CollectionService")
local _ = game:GetService("RunService")
local _ = require(game.ReplicatedStorage.Scripts.BlockFunctions)

function stringToNum(p2, p3) --[[ Line: 16 ]]
	local Number: number? = tonumber(p2)
	
	return if Number and (Number == Number and math.abs(Number) ~= 1e999) then Number else p3
end

local v3 = 1000
local v4 = v3 - 1
local config = {
	ValueType = "boolean",
	Name = "Anchored",
	OrderPriority = v3,
	GetState = function(p4) --[[ Line: 35 ]]
		return p4.PrimaryPart.Anchored
	end,
	GetPropertyState = function(p5, p6): number --[[ Line: 38 ]]
		local v100 = -1
		
		for i = 1, #p6 do
			local v101 = p6[i]
			
			if v101.PrimaryPart then
				local State = p5.GetState(v101)
				
				if v100 == -1 then
					v100 = if State then 1 else 0
				elseif v100 == 1 and State == false or v100 == 0 and State == true then
					v100 = 2
				end
			end
		end
		return v100
	end,
	UpdatePropertyButtonFunction = function(p7, p8, p9, p10) --[[ Line: 58 ]]
		local PropertyState = p7.GetPropertyState(p7, p9)
		
		if PropertyState == 1 then
			p8.CheckBox.On.Visible = true
			p8.CheckBox.Mixed.Visible = false
		elseif PropertyState == 0 then
			p8.CheckBox.On.Visible = false
			p8.CheckBox.Mixed.Visible = false
		elseif PropertyState == 2 then
			p8.CheckBox.On.Visible = false
			p8.CheckBox.Mixed.Visible = true
		end
		if workspace.Challenge.Teams:FindFirstChild(p10.Team.Name) then
			p8.CheckBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			
			return
		else
			p8.CheckBox.BackgroundColor3 = Color3.fromRGB(132, 132, 132)
		end
	end
}
Module.All.Anchored = config
local Collision = {}
local config_1 = { Anchored = config, Collision = Collision }
Collision.ValueType = "boolean"
Collision.Name = "Collision"
Collision.OrderPriority = v4
local v8 = v4 - 1

function Collision.GetState(p11): boolean --[[ Line: 87 ]]
	return not p11:HasTag("NotCanCollideByTool")
end

Collision.GetPropertyState = config_1.Anchored.GetPropertyState

function Collision.UpdatePropertyButtonFunction(p12, p13, p14) --[[ Line: 91 ]]
	local PropertyState = p12.GetPropertyState(p12, p14)
	
	if PropertyState == 1 then
		p13.CheckBox.On.Visible = true
		p13.CheckBox.Mixed.Visible = false
		
		return
	end
	if PropertyState == 0 then
		p13.CheckBox.On.Visible = false
		p13.CheckBox.Mixed.Visible = false
		
		return
	end
	if PropertyState == 2 then
		p13.CheckBox.On.Visible = false
		p13.CheckBox.Mixed.Visible = true
	end
end

Module.All.Collision = Collision
local t = {}
config_1["Cast shadow"] = t
t.ValueType = "boolean"
t.Name = "Cast shadow"
t.OrderPriority = v8
local v10 = v8 - 1

function t.GetState(p15) --[[ Line: 115 ]]
	return p15.PrimaryPart.CastShadow
end

t.GetPropertyState = config_1.Collision.GetPropertyState
t.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.All["Cast shadow"] = t
local Transparency = {}
config_1.Transparency = Transparency
Transparency.ValueType = "number+"
Transparency.Name = "Transparency"
Transparency.Max = 1
Transparency.Min = 0
Transparency.OrderPriority = v10
local v12 = v10 - 1

function Transparency.GetState(p16) --[[ Line: 133 ]]
	return p16:GetAttribute("Transparency") or 0
end

function Transparency.GetPropertyState(p17, p18): number --[[ Line: 136 ]]
	local v105 = -2
	
	for i = 1, #p18 do
		local v106 = p18[i]
		
		if v106.PrimaryPart then
			local State = p17.GetState(v106)
			
			if v105 == -2 then
				v105 = State
			elseif v105 ~= State then
				v105 = -1
			end
		end
	end
	return v105
end

function Transparency.UpdatePropertyButtonFunction(p19, p20, p21, _) --[[ Line: 155 ]]
	local PropertyState: number = p19.GetPropertyState(p19, p21)
	
	if PropertyState == -1 then
		p20.TextNum.Text = ""
		p20.TextNum.Mixed.Visible = true
		
		return
	else
		p20.TextNum.Text = tostring((math.round(PropertyState * 100))) .. "%"
		p20.TextNum.Mixed.Visible = false
	end
end

Module.All.Transparency = Transparency
local t = {}
config_1["Total mass"] = t
t.ValueType = "numberReadOnly"
t.Name = "Total mass"
t.Max = 1e999
t.Min = 0
t.OrderPriority = v12
local v14 = v12 - 1

function t.GetState(p23): number --[[ Line: 178 ]]
	local v109 = 0
	local Descendants = p23:GetDescendants()
	
	for i = 1, #Descendants do
		local v111 = Descendants[i]
		
		if v111:IsA("BasePart") then
			v109 += v111.Mass
		end
	end
	return v109
end

function t.GetPropertyState(p24, p25): number --[[ Line: 189 ]]
	local v112 = -2
	
	for i = 1, #p25 do
		local v113 = p25[i]
		
		if v113.PrimaryPart then
			if v112 == -2 then
				v112 = 0
			end
			v112 += p24.GetState(v113)
		end
	end
	return v112
end

function t.UpdatePropertyButtonFunction(p26, p27, p28, _) --[[ Line: 207 ]]
	local PropertyState: number = p26.GetPropertyState(p26, p28)
	
	if PropertyState == -1 then
		p27.TextNum.Text = ""
		p27.TextNum.Mixed.Visible = true
		
		return
	else
		p27.TextNum.Text = tostring(math.ceil(PropertyState * 1000) / 1000)
		p27.TextNum.Mixed.Visible = false
	end
end

Module.All["Total mass"] = t
local Density = {}
config_1.Density = Density
Density.ValueType = "number+"
Density.Name = "Density"
Density.Max = 100
Density.Min = 0.0001
Density.OrderPriority = v14
local v16 = v14 - 1

function Density.GetState(p30): number --[[ Line: 230 ]]
	local v115 = 0
	local v116 = 0
	local Descendants = p30:GetDescendants()
	
	for i = 1, #Descendants do
		local v118 = Descendants[i]
		
		if v118:IsA("BasePart") then
			local Density = v118.CurrentPhysicalProperties.Density
			local v120 = v118.Mass / Density
			v115 += v120
			v116 += Density * v120
		end
	end
	return v116 / v115
end

function Density.GetPropertyState(p31, p32): number --[[ Line: 247 ]]
	local v121 = -2
	
	for i = 1, #p32 do
		local v122 = p32[i]
		
		if v122.PrimaryPart then
			local State = p31.GetState(v122)
			
			if v121 == -2 then
				v121 = State
			elseif v121 ~= State then
				v121 = -1
				
				return v121
			end
		end
	end
	return v121
end

function Density.UpdatePropertyButtonFunction(p33, p34, p35, _) --[[ Line: 267 ]]
	local PropertyState: number = p33.GetPropertyState(p33, p35)
	
	if PropertyState == -1 then
		p34.TextNum.Text = ""
		p34.TextNum.Mixed.Visible = true
		
		return
	else
		p34.TextNum.Text = tostring(math.round(PropertyState * 10000) / 10000)
		p34.TextNum.Mixed.Visible = false
	end
end

Module.All.Density = Density
local t = {}
config_1["Piston length"] = t
t.ValueType = "number+"
t.Name = "Piston length"
t.Max = 10.5
t.Min = 0.3
t.OrderPriority = v16
local v18 = v16 - 1

function t.GetState(p37) --[[ Line: 291 ]]
	return p37.ExtendLength.Value
end

function t.GetPropertyState(p38, p39): number --[[ Line: 294 ]]
	-- upvalues: Module (copy)
	local v125 = -2
	
	for i = 1, #p39 do
		local v126 = p39[i]
		local v127 = Module[v126.Name]
		
		if v126.PrimaryPart and v127 and v127[p38.Name] then
			local State = p38.GetState(v126)
			
			if v125 == -2 then
				v125 = State
			elseif v125 ~= State then
				v125 = -1
			end
		end
	end
	return v125
end

function t.UpdatePropertyButtonFunction(p40, p41, p42, _) --[[ Line: 314 ]]
	local PropertyState: number = p40.GetPropertyState(p40, p42)
	
	if PropertyState == -1 then
		p41.TextNum.Text = ""
		p41.TextNum.Mixed.Visible = true
		
		return
	else
		p41.TextNum.Text = tostring(math.round(PropertyState * 100) / 100)
		p41.TextNum.Mixed.Visible = false
	end
end

Module.Piston["Piston length"] = t
local t = {}
config_1["Piston speed"] = t
t.ValueType = "number+"
t.Name = "Piston speed"
t.Max = 600
t.Min = 1
t.OrderPriority = v18
local v20 = v18 - 1

function t.GetState(p44) --[[ Line: 337 ]]
	return p44.Speed.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.Piston["Piston speed"] = t
local t = {}
config_1["Wheel torque"] = t
t.ValueType = "level"
t.Name = "Wheel torque"
t.OrderPriority = v20
local v22 = v20 - 1

function t.GetState(p45): number --[[ Line: 353 ]]
	return (math.clamp(string.len(p45.PrimaryPart.HingeConstraint.MotorMaxTorque / 1000000), 1, 5))
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState

function t.UpdatePropertyButtonFunction(p46, p47, p48, _) --[[ Line: 358 ]]
	local PropertyState = p46.GetPropertyState(p46, p48)
	p47.bg.l1.Visible = false
	p47.bg.l2.Visible = false
	p47.bg.l3.Visible = false
	p47.bg.l4.Visible = false
	p47.bg.l5.Visible = false
	p47.bg.Mixed.Visible = false
	
	if PropertyState == -1 then
		p47.bg.Mixed.Visible = true
		
		return
	else
		p47.bg["l" .. tostring(PropertyState)].Visible = true
	end
end

Module.Motor["Wheel torque"] = t
Module.HugeMotor["Wheel torque"] = t
Module.FrontWheel["Wheel torque"] = t
Module.BackWheel["Wheel torque"] = t
Module.HugeFrontWheel["Wheel torque"] = t
Module.HugeBackWheel["Wheel torque"] = t
Module.FrontWheelCookie["Wheel torque"] = t
Module.BackWheelCookie["Wheel torque"] = t
Module.FrontWheelMint["Wheel torque"] = t
Module.BackWheelMint["Wheel torque"] = t
local t = {}
config_1["Wheel speed"] = t
t.ValueType = "number+"
t.Name = "Wheel speed"
t.Max = 50
t.Min = 0
t.OrderPriority = v22
local v24 = v22 - 1

function t.GetState(p50) --[[ Line: 395 ]]
	return p50.MaxSpeed.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.Motor["Wheel speed"] = t
Module.HugeMotor["Wheel speed"] = t
Module.FrontWheel["Wheel speed"] = t
Module.BackWheel["Wheel speed"] = t
Module.HugeFrontWheel["Wheel speed"] = t
Module.HugeBackWheel["Wheel speed"] = t
Module.FrontWheelCookie["Wheel speed"] = t
Module.BackWheelCookie["Wheel speed"] = t
Module.FrontWheelMint["Wheel speed"] = t
Module.BackWheelMint["Wheel speed"] = t
local t = {}
config_1["Reverse spin"] = t
t.ValueType = "boolean"
t.Name = "Reverse spin"
t.OrderPriority = v24
local v26 = v24 - 1

function t.GetState(p51): boolean --[[ Line: 420 ]]
	return p51:GetAttribute("SpinFactor") ~= -1
end

function t.GetPropertyState(p52, p53): number --[[ Line: 429 ]]
	-- upvalues: Module (copy)
	local v131 = -1
	
	for i = 1, #p53 do
		local v132 = p53[i]
		local v133 = Module[v132.Name]
		
		if v132.PrimaryPart and (v133 and v133[p52.Name]) then
			local State = p52.GetState(v132)
			
			if v131 == -1 then
				v131 = if State then 1 else 0
			elseif v131 == 1 and State == false or v131 == 0 and State == true then
				v131 = 2
			end
		end
	end
	return v131
end

t.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.Motor["Reverse spin"] = t
Module.HugeMotor["Reverse spin"] = t
Module.FrontWheel["Reverse spin"] = t
Module.BackWheel["Reverse spin"] = t
Module.HugeFrontWheel["Reverse spin"] = t
Module.HugeBackWheel["Reverse spin"] = t
Module.FrontWheelCookie["Reverse spin"] = t
Module.BackWheelCookie["Reverse spin"] = t
Module.FrontWheelMint["Reverse spin"] = t
Module.BackWheelMint["Reverse spin"] = t
local t = {}
config_1["Servo torque"] = t
t.ValueType = "level"
t.Name = "Servo torque"
t.OrderPriority = v26
local v28 = v26 - 1

function t.GetState(p54): number --[[ Line: 471 ]]
	return (math.clamp(string.len(p54.PrimaryPart.HingeConstraint.ServoMaxTorque / 1000000), 1, 5))
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Wheel torque"].UpdatePropertyButtonFunction
Module.Servo["Servo torque"] = t
local t = {}
config_1["Servo speed"] = t
t.ValueType = "number+"
t.Name = "Servo speed"
t.Max = 50
t.Min = 0
t.OrderPriority = v28
local v30 = v28 - 1

function t.GetState(p55) --[[ Line: 490 ]]
	return p55.PrimaryPart.HingeConstraint.AngularSpeed
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.Servo["Servo speed"] = t
local t = {}
config_1["Servo angle"] = t
t.ValueType = "number+"
t.Name = "Servo angle"
t.Max = 180
t.Min = 0
t.OrderPriority = v30
local v32 = v30 - 1

function t.GetState(p56) --[[ Line: 508 ]]
	return p56.TargetAngle.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.Servo["Servo angle"] = t
local t = {}
config_1["Reverse rotation"] = t
t.ValueType = "boolean"
t.Name = "Reverse rotation"
t.OrderPriority = v32
local v34 = v32 - 1

function t.GetState(p57) --[[ Line: 524 ]]
	return p57.ReverseRotation.Value
end

t.GetPropertyState = config_1["Reverse spin"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.Servo["Reverse rotation"] = t
local t = {}
config_1["Jet force"] = t
t.ValueType = "level"
t.Name = "Jet force"
t.OrderPriority = v34
local v36 = v34 - 1

function t.GetState(p58): number --[[ Line: 540 ]]
	return (math.clamp(string.len(p58.MaxForce.Value / 1000000), 1, 5))
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Wheel torque"].UpdatePropertyButtonFunction
Module.JetTurbine["Jet force"] = t
Module.JetTurbineWinter["Jet force"] = t
Module.SonicJetTurbine["Jet force"] = t
local t = {}
config_1["Jet speed"] = t
t.ValueType = "number+"
t.Name = "Jet speed"
t.Max = 100
t.Min = 0
t.OrderPriority = v36
local v38 = v36 - 1
t.GetState = config_1["Wheel speed"].GetState
t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.JetTurbine["Jet speed"] = t
Module.JetTurbineWinter["Jet speed"] = t
Module.SonicJetTurbine["Jet speed"] = t
local t = {}
config_1["Fuse time"] = t
t.ValueType = "number+"
t.Name = "Fuse time"
t.Max = 60
t.Min = 0
t.OrderPriority = v38
local v40 = v38 - 1

function t.GetState(p59) --[[ Line: 579 ]]
	return p59.FuseTime.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.FireworkA["Fuse time"] = t
Module.FireworkB["Fuse time"] = t
Module.FireworkC["Fuse time"] = t
Module.FireworkD["Fuse time"] = t
local t = {}
config_1["Flight distance"] = t
t.ValueType = "number+"
t.Name = "Flight distance"
t.Max = 200
t.Min = 0
t.OrderPriority = v40
local v42 = v40 - 1

function t.GetState(p60) --[[ Line: 600 ]]
	return p60.FlightDistance.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.FireworkA["Flight distance"] = t
Module.FireworkB["Flight distance"] = t
Module.FireworkC["Flight distance"] = t
Module.FireworkD["Flight distance"] = t
local t = {}
config_1["Delay time"] = t
t.ValueType = "number+"
t.Name = "Delay time"
t.Max = 10
t.Min = 0.05
t.OrderPriority = v42
local v44 = v42 - 1

function t.GetState(p61) --[[ Line: 621 ]]
	return p61.WaitDuration.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.Delay["Delay time"] = t
local Legacy = {}
config_1.Legacy = Legacy
Legacy.ValueType = "boolean"
Legacy.Name = "Legacy"
Legacy.OrderPriority = v44
local v46 = v44 - 1

function Legacy.GetState(p62) --[[ Line: 637 ]]
	return p62:HasTag("Legacy")
end

Legacy.GetPropertyState = config_1["Reverse spin"].GetPropertyState
Legacy.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.Delay.Legacy = Legacy
Module.Switch.Legacy = Legacy
Module.SwitchBig.Legacy = Legacy
Module.Lever.Legacy = Legacy
Module.Button.Legacy = Legacy
local t = {}
config_1["Grow head scale"] = t
t.ValueType = "number+"
t.Name = "Grow head scale"
t.Max = 2
t.Min = 1
t.OrderPriority = v46
local v48 = v46 - 1

function t.GetState(p63) --[[ Line: 659 ]]
	return p63.HeadScale.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.CandyRed["Grow head scale"] = t
local t = {}
config_1["Grow height scale"] = t
t.ValueType = "number+"
t.Name = "Grow height scale"
t.Max = 2
t.Min = 1
t.OrderPriority = v48
local v50 = v48 - 1

function t.GetState(p64) --[[ Line: 677 ]]
	return p64.HeightScale.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.CandyRed["Grow height scale"] = t
local t = {}
config_1["Grow width scale"] = t
t.ValueType = "number+"
t.Name = "Grow width scale"
t.Max = 2
t.Min = 1
t.OrderPriority = v50
local v52 = v50 - 1

function t.GetState(p65) --[[ Line: 695 ]]
	return p65.WidthScale.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.CandyRed["Grow width scale"] = t
local t = {}
config_1["Grow depth scale"] = t
t.ValueType = "number+"
t.Name = "Grow depth scale"
t.Max = 2
t.Min = 1
t.OrderPriority = v52
local v54 = v52 - 1

function t.GetState(p66) --[[ Line: 713 ]]
	return p66.DepthScale.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.CandyRed["Grow depth scale"] = t
local t = {}
config_1["Shrink head scale"] = t
t.ValueType = "number+"
t.Name = "Shrink head scale"
t.Max = 1
t.Min = 0.5
t.OrderPriority = v54
local v56 = v54 - 1

function t.GetState(p67) --[[ Line: 731 ]]
	return p67.HeadScale.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.CandyBlue["Shrink head scale"] = t
local t = {}
config_1["Shrink height scale"] = t
t.ValueType = "number+"
t.Name = "Shrink height scale"
t.Max = 1
t.Min = 0.5
t.OrderPriority = v56
local v58 = v56 - 1

function t.GetState(p68) --[[ Line: 749 ]]
	return p68.HeightScale.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.CandyBlue["Shrink height scale"] = t
local t = {}
config_1["Shrink width scale"] = t
t.ValueType = "number+"
t.Name = "Shrink width scale"
t.Max = 1
t.Min = 0.5
t.OrderPriority = v58
local v60 = v58 - 1

function t.GetState(p69) --[[ Line: 767 ]]
	return p69.WidthScale.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.CandyBlue["Shrink width scale"] = t
local t = {}
config_1["Shrink depth scale"] = t
t.ValueType = "number+"
t.Name = "Shrink depth scale"
t.Max = 1
t.Min = 0.5
t.OrderPriority = v60
local v62 = v60 - 1

function t.GetState(p70) --[[ Line: 785 ]]
	return p70.DepthScale.Value
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.CandyBlue["Shrink depth scale"] = t
local Key = {}
config_1.Key = Key
Key.ValueType = "number"
Key.Name = "Key"
Key.OrderPriority = v62
local v64 = v62 - 1

function Key.GetState(p71) --[[ Line: 801 ]]
	return p71.SemitoneOffset.Value
end

Key.GetPropertyState = config_1["Piston length"].GetPropertyState

function Key.UpdatePropertyButtonFunction(p72, p73, p74, _) --[[ Line: 805 ]]
	local PropertyState: number = p72.GetPropertyState(p72, p74)
	local v136 = PropertyState % 12
	local list = {
		"F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F"
	}
	
	if PropertyState == -1 then
		p73.TextNum.Text = ""
		p73.TextNum.Mixed.Visible = true
		
		return
	else
		p73.TextNum.Text = list[v136 + 1]
		p73.TextNum.Mixed.Visible = false
	end
end

Module.Note.Key = Key
local Crosshairs = {}
config_1.Crosshairs = Crosshairs
Crosshairs.ValueType = "boolean"
Crosshairs.Name = "Crosshairs"
Crosshairs.OrderPriority = v64
local v66 = v64 - 1

function Crosshairs.GetState(p76) --[[ Line: 828 ]]
	return p76.ShowCrosshairs.Value
end

Crosshairs.GetPropertyState = config_1["Reverse spin"].GetPropertyState
Crosshairs.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.Camera.Crosshairs = Crosshairs
Module.CameraDome.Crosshairs = Crosshairs
local Aim = {}
config_1.Aim = Aim
Aim.ValueType = "boolean"
Aim.Name = "Aim"
Aim.OrderPriority = v66
local v68 = v66 - 1

function Aim.GetState(p77) --[[ Line: 845 ]]
	return p77.Aim.Value
end

Aim.GetPropertyState = config_1["Reverse spin"].GetPropertyState
Aim.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.Cannon.Aim = Aim
Module.MiniGun.Aim = Aim
Module.Harpoon.Aim = Aim
Module.HarpoonGold.Aim = Aim
Module.HarpoonDragon.Aim = Aim
Module.DualCaneHarpoon.Aim = Aim
local Length = {}
config_1.Length = Length
Length.ValueType = "number+"
Length.Name = "Length"
Length.Max = 1e999
Length.Min = 2
Length.OrderPriority = v68
local v70 = v68 - 1

function Length.GetState(p78) --[[ Line: 868 ]]
	local PrimaryPart = p78.PrimaryPart
	
	return (PrimaryPart:FindFirstChildOfClass("RodConstraint") or PrimaryPart:FindFirstChildOfClass("RopeConstraint")).Length
end

Length.GetPropertyState = config_1["Piston length"].GetPropertyState
Length.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.Bar.Length = Length
Module.Rope.Length = Length
local t = {}
config_1["Angle limit"] = t
t.ValueType = "number+"
t.Name = "Angle limit"
t.Max = 180
t.Min = 0
t.OrderPriority = v70
local v72 = v70 - 1

function t.GetState(p79) --[[ Line: 889 ]]
	return p79.PrimaryPart.RodConstraint.LimitAngle0
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.Bar["Angle limit"] = t
local t = {}
config_1["Match rotation"] = t
t.ValueType = "boolean"
t.Name = "Match rotation"
t.OrderPriority = v72
local v74 = v72 - 1

function t.GetState(p80) --[[ Line: 905 ]]
	return p80.PrimaryPart.AlignOrientation.Enabled
end

t.GetPropertyState = config_1["Reverse spin"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.Bar["Match rotation"] = t
Module.Rope["Match rotation"] = t
local t = {}
config_1["Target length"] = t
t.ValueType = "number+"
t.Name = "Target length"
t.Max = 1e999
t.Min = 2
t.OrderPriority = v74
local v76 = v74 - 1

function t.GetState(p81) --[[ Line: 924 ]]
	return p81.PrimaryPart.SpringConstraint.FreeLength
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.Spring["Target length"] = t
local t = {}
config_1["Max length"] = t
t.ValueType = "number+"
t.Name = "Max length"
t.Max = 1e999
t.Min = 0.1
t.OrderPriority = v76
local v78 = v76 - 1

function t.GetState(p82) --[[ Line: 942 ]]
	return p82.PrimaryPart.PrismaticConstraint.UpperLimit
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.Spring["Max length"] = t
local t = {}
config_1["Min length"] = t
t.ValueType = "number+"
t.Name = "Min length"
t.Max = 1e999
t.Min = 0
t.OrderPriority = v78
local v80 = v78 - 1

function t.GetState(p83) --[[ Line: 960 ]]
	return p83.PrimaryPart.PrismaticConstraint.LowerLimit
end

t.GetPropertyState = config_1["Piston length"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.Spring["Min length"] = t
local Stiffness = {}
config_1.Stiffness = Stiffness
Stiffness.ValueType = "number+"
Stiffness.Name = "Stiffness"
Stiffness.Max = 250000
Stiffness.Min = 0
Stiffness.OrderPriority = v80
local v82 = v80 - 1

function Stiffness.GetState(p84) --[[ Line: 978 ]]
	return p84.PrimaryPart.SpringConstraint.Stiffness
end

Stiffness.GetPropertyState = config_1["Piston length"].GetPropertyState
Stiffness.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.Spring.Stiffness = Stiffness
local Damping = {}
config_1.Damping = Damping
Damping.ValueType = "number+"
Damping.Name = "Damping"
Damping.Max = 250000
Damping.Min = 0
Damping.OrderPriority = v82
local v84 = v82 - 1

function Damping.GetState(p85) --[[ Line: 996 ]]
	return p85.PrimaryPart.SpringConstraint.Damping
end

Damping.GetPropertyState = config_1["Piston length"].GetPropertyState
Damping.UpdatePropertyButtonFunction = config_1["Piston length"].UpdatePropertyButtonFunction
Module.Spring.Damping = Damping
local Invertible = {}
config_1.Invertible = Invertible
Invertible.ValueType = "boolean"
Invertible.Name = "Invertible"
Invertible.OrderPriority = v84
local v86 = v84 - 1

function Invertible.GetState(p86) --[[ Line: 1012 ]]
	return p86.PrimaryPart.SpringConstraint.LimitsEnabled
end

Invertible.GetPropertyState = config_1["Reverse spin"].GetPropertyState
Invertible.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.Spring.Invertible = Invertible
local And = {}
config_1.And = And
And.ValueType = "boolean"
And.Name = "And"
And.OrderPriority = v86
local v88 = v86 - 1

function And.GetState(p87) --[[ Line: 1029 ]]
	return p87.And.Value
end

And.GetPropertyState = config_1["Reverse spin"].GetPropertyState
And.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.Gate.And = And
local Or = {}
config_1.Or = Or
Or.ValueType = "boolean"
Or.Name = "Or"
Or.OrderPriority = v88
local v90 = v88 - 1

function Or.GetState(p88) --[[ Line: 1045 ]]
	return p88.Or.Value
end

Or.GetPropertyState = config_1["Reverse spin"].GetPropertyState
Or.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.Gate.Or = Or
local Xor = {}
config_1.Xor = Xor
Xor.ValueType = "boolean"
Xor.Name = "Xor"
Xor.OrderPriority = v90
local v92 = v90 - 1

function Xor.GetState(p89) --[[ Line: 1061 ]]
	return p89.Xor.Value
end

Xor.GetPropertyState = config_1["Reverse spin"].GetPropertyState
Xor.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.Gate.Xor = Xor
local Not = {}
config_1.Not = Not
Not.ValueType = "boolean"
Not.Name = "Not"
Not.OrderPriority = v92
local v94 = v92 - 1

function Not.GetState(p90) --[[ Line: 1077 ]]
	return p90.Not.Value
end

Not.GetPropertyState = config_1["Reverse spin"].GetPropertyState
Not.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.Gate.Not = Not

function Module.updateGateImage(p91) --[[ Line: 1086 ]]
	local Value = p91.And.Value
	local Value_1 = p91.Or.Value
	local Value_2 = p91.Xor.Value
	local ImageLabel = p91.Part.SurfaceGui.ImageLabel
	
	if p91.Not.Value then
		if Value then
			ImageLabel.Image = "http://www.roblox.com/asset/?id=125971644713845"
			
			return
		end
		if Value_1 then
			ImageLabel.Image = "http://www.roblox.com/asset/?id=126908268245793"
			
			return
		end
		if Value_2 then
			ImageLabel.Image = "http://www.roblox.com/asset/?id=120464622165119"
		end
	else
		if Value then
			ImageLabel.Image = "http://www.roblox.com/asset/?id=112468754811083"
			
			return
		end
		if Value_1 then
			ImageLabel.Image = "http://www.roblox.com/asset/?id=104151754841179"
			
			return
		end
		if Value_2 then
			ImageLabel.Image = "http://www.roblox.com/asset/?id=106097934141764"
			
			return
		end
	end
end

local t = {}
config_1["Show constraint"] = t
t.ValueType = "boolean"
t.Name = "Show constraint"
t.OrderPriority = v94
local v96 = v94 - 1

function t.GetState(p92) --[[ Line: 1119 ]]
	local BlackPart = p92:FindFirstChild("BlackPart") or p92.PrimaryPart
	
	return (BlackPart:FindFirstChildOfClass("RopeConstraint") or (BlackPart:FindFirstChildOfClass("RodConstraint") or BlackPart:FindFirstChildOfClass("SpringConstraint"))).Visible
end

t.GetPropertyState = config_1["Reverse spin"].GetPropertyState
t.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.Piston["Show constraint"] = t
Module.Rope["Show constraint"] = t
Module.Bar["Show constraint"] = t
Module.Spring["Show constraint"] = t
local Additive = {}
config_1.Additive = Additive
Additive.ValueType = "boolean"
Additive.Name = "Additive"
Additive.OrderPriority = v96
local _ = v96 - 1

function Additive.GetState(p93) --[[ Line: 1140 ]]
	return p93.Additive.Value
end

Additive.GetPropertyState = config_1["Reverse spin"].GetPropertyState
Additive.UpdatePropertyButtonFunction = config_1.Collision.UpdatePropertyButtonFunction
Module.DisplayBlock.Additive = Additive

return Module