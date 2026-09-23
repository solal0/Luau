local utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/Utils.luau"))()
local R = utils.services.ReplicatedStorage
local W = utils.services.Workspace
local P = utils.services.Players

local lp = P.LocalPlayer
local lpg = lp.PlayerGui
local m = lp:GetMouse()

local buildtool
local deletetool
local painttool
local scaletool
local troweltool
local bindtool
local propertiestool

local result

local Blocks = W.Blocks
local blocks = Blocks[lp.Name]
local holder = lpg.BuildGui.InventoryFrame.ScrollingFrame.BlocksFrame -- BuildGui does not reset on spawn so not security checks are required

local names = {}
local owned = {}
local builder = {}

local cooldown = 0.1
local loopFor = 12

-- properties protection
local booleans = {
	["Anchored"] = true, ["Collision"] = true, ["CastShadow"] = true, -- Defaults
	["Aim"] = true, ["Crosshairs"] = true, ["Legacy"] = true, -- buttons, lever, ...
	["Additive"] = true, -- Display Block
	["And"] = true, ["Or"] = true, ["Xor"] = true, ["Not"] = true, -- Gate
	["Reverse rotation"] = true,
	["Show constraint"] = true,
	["Invertible"] = true,
	["Match rotation"] = true,
	["Reverse spin"] = true,
}

-- populate names
for i,v in pairs(holder:GetChildren()) do
    if v:IsA("ImageButton") and v:FindFirstChild("AmountText") then
        names[v.Name] = true
    end
end

-- utility
function getTool(tool) -- tool name, variable
	tool = lp.Backpack:FindFirstChild(tool) or lp.Character and lp.Character:FindFirstChild(tool)
	if tool then return tool end
end

function getAvailable()
    for i,v in pairs(holder:GetChildren()) do
        if v:IsA("ImageButton") and names[v.Name] then
            owned[v.Name] = tonumber(v.AmountText.Text)
        end
    end
end

function isAvailable(name)
	if next(owned) == nil then getAvailable() end
	if owned[name] and owned[name] > 0 then
		return true, owned[name]
	end
	return false, 0
end

function bait(tool,equip)
	local s = tool:FindFirstChildOfClass("LocalScript")
	if equip then
		if s then s.Enabled = false end
		lp.Character.Humanoid:EquipTool(tool)
	else
		if s then s.Enabled = true end
		lp.Character.Humanoid:UnequipTools(tool)
	end
end
-- utility

function create(...) -- name,inventoryValue,TargetPart,cf1,anchor,pcf,cf2,binds
	local args = {...}
	if #args > 8 then
		return false, "Too many arguments"
	elseif #args < 8 then
		return false, "Not enough arguments"
	end

	local part
	local conn = blocks.ChildAdded:Connect(function(child)
		if child.Name == args[1] then part = child end
	end)
	buildtool.RF:InvokeServer(...)

	for i = 1, loopFor do
		wait(cooldown)
		if part then
			conn:Disconnect()
			return true, part
		end
	end
	conn:Disconnect()
	return false, "The server did not create the result."
end

-- only name and cf1 are required
builder.new = function(name,cf1,invV,tp,tpcf,anchor,cf2,binds) -- string,cframe,value,instance,cframe,boolean,cframe,boolean
	if not name or not cf1 then return false, "Missing name or cframe" end
    
    local available, count = isAvailable(name)
	if not available then return false, "You don't have enough "..name..". ("..count..")" end

	local Preview = R.BuildingParts[name]:Clone()
	Preview:SetPrimaryPartCFrame(cf1)
	Preview.Parent = workspace
	Preview.PrimaryPart.Anchored = true

	invV = invV or lp.Data:FindFirstChild(name).Value
	tp = tp or workspace.WhiteZone
	tpcf = tpcf or tp.CFrame:ToObjectSpace(Preview.PrimaryPart.CFrame)
	anchor = anchor ~= false
	cf2 = cf2 or (name == "Spring" or name == "Bar" or name == "Rope") and Preview.SecondaryPart.PrimaryPart.CFrame
	binds = binds or false

	bait(buildtool,true)

	local success, result = create(
		name, -- placedBlock.Name
		invV,
		tp, -- previousTarget
		tpcf, -- relativeCFrame
		anchor, -- anchorValue
		cf1,
		nil, -- secondaryCFrame
		binds -- makeBindsValue
	)

	bait(buildtool,false)
	Preview:Destroy()

	if success then
		getAvailable()

        local function delete()
            if not deletetool then return end

            if not result:IsDescendantOf(blocks) then return false, "Block is not valid" end
            if result.Parent ~= blocks then
                for i,v in pairs(blocks:GetChildren()) do
                    if result:IsDescendantOf(v) then
                        result = v
                        break
                    end
                end
                if result.Parent ~= blocks then return false, "wtf?" end
            end

            local name = result.Name

            bait(deletetool,true)
            deletetool.RF:InvokeServer(result)
            bait(deletetool,false)

            for i = 1, loopFor do
                wait(cooldown)
                if not result.Parent or result.Parent ~= blocks then return true, "The server deleted "..name.."." end
            end
            return false, "The server did not delete "..name.."."
        end

        local function setColor(result,color) -- instance, Color3.fromRGB()
            if not painttool then return end

            --bait(painttool,true) -- no need for bait, painting tool doesn't check for equipped tool
            local tbl1 = {{result,color}}
            painttool.RF:InvokeServer(tbl1)
            for i = 1, loopFor do
                wait(cooldown)
                if result.PrimaryPart.Color == color then
                    --bait(painttool,false)
                    return true, "The server changed the color of "..result.Name.." to "..color.R..","..color.G..","..color.B.."."
                end
            end
            --bait(painttool,false)

            return false, "The server did not change the color of "..result.Name.." to "..color.R..","..color.G..","..color.B.."."
        end

        local function setProperty(result,property,value,protect) -- instance,string,custom,boolean
            if not propertiestool then return end
            
            protect = protect ~= false
            if not protect or protect and ((property == "Transparency" and value >= 0 and value <= 100)
                or (property == "Density" and value >= 0.0001 and value <= 100)
                or (property == "Jet speed" and value >= 0)
                -- Jet force property exists but doing a call just increases it by 1 and goes back to 1 after reaching 5
                or (property == "Fuse time" and value >= 0 and value <= 60)
                or (property == "Jet speed" and value >= 0 and value <= 200)
                or (property == "Delay time" and value >= 0.05 and value <= 10)
                -- Servo torque property exists and is the same as Jet force
                or (property == "Servo speed" and value >= 0 and value <= 50)
                or (property == "Servo angle" and value >= 0 and value <= 180)
                or (property == "Piston length" and value >= 0.3 and value <= 10.5)
                or (property == "Piston speed" and value >= 1 and value <= 600)

                or (property == "Length" and value >= 2)
                or (property == "Angle limit" and value >= 0 and value <= 180)
                or (property == "Target length" and value >= 2)
                or (property == "Max length" and value >= 0.1)
                or (property == "Min length" and value >= 0)
                or (property == "Stiffness" and value >= 0 and value <= 250000)
                or (property == "Damping" and value >= 0 and value <= 250000)

                -- Wheel torque property exists and is the same as Jet force
                or (property == "Wheel speed" and value >= 0 and value <= 50)

                or (property == "Shrink head scale" and value >= 0.5 and value <= 1)
                or (property == "Shrink height scale" and value >= 0.5 and value <= 1)
                or (property == "Shrink width scale" and value >= 0.5 and value <= 1)
                or (property == "Shrink depth scale" and value >= 0.5 and value <= 1)

                or (booleans[property] and type(value) == "boolean")) then
                    bait(propertiestool,true)
                    propertiestool.SetPropertieRF:InvokeServer(property,{result},value)
                    -- no check because most properties cannot be checked
                    bait(propertiestool,false)
                end
        end

        local function setSize(result,size) -- instance,vector3
            if not scaletool then return end

            local pp = result.PrimaryPart or result:FindFirstChild("PPart")
            if not pp then return end

            local res1, res2 = scaletool.RF:InvokeServer(result, size, pp.CFrame)
            if res1 or res2 then return false, "Something went wrong after requesting a size change (i'm not sure): First: "..res1.." / Second: "..res2 end
            
            for i = 1, loopFor do
                wait(cooldown)
                if pp.Size == size then
                    return true, "The server changed the size of "..result.Name.." to "..tostring(size).."."
                end
            end
            return false, "The server did not change the size of "..result.Name.." to "..tostring(size).."."
        end

        local function setPosition(result,position) -- instance,vector3
            if not scaletool then return end

            local pp = result.PrimaryPart or result:FindFirstChild("PPart")
            if not pp then return end

            local cf = CFrame.new(position.X, position.Y, position.Z)

            local res1, res2 = scaletool.RF:InvokeServer(result, pp.Size, cf)
            if res1 or res2 then return false, "Something went wrong after requesting a position change (i'm not sure): First: "..res1.." / Second: "..res2 end
            
            for i = 1, loopFor do
                wait(cooldown)
                if pp.CFrame == cf then
                    return true, "The server changed the position of "..result.Name.." to "..tostring(position).."."
                end
            end
            return false, "The server did not change the position of "..result.Name.." to "..tostring(position).."."
        end

        local function setRotation(result,rotation) -- instance,vector3
            if not scaletool then return end

            local pp = result.PrimaryPart or result:FindFirstChild("PPart")
            if not pp then return end

            local cf = CFrame.new(pp.Position) * CFrame.Angles(rotation.X, rotation.Y, rotation.Z)

            local res1, res2 = scaletool.RF:InvokeServer(result, pp.Size, cf)
            if res1 or res2 then return false, "Something went wrong after requesting a rotation change (i'm not sure): First: "..res1.." / Second: "..res2 end
            
            for i = 1, loopFor do
                wait(cooldown)
                if pp.CFrame == cf then
                    return true, "The server changed the rotation of "..result.Name.." to "..tostring(rotation).."."
                end
            end
            return false, "The server did not change the rotation of "..result.Name.." to "..tostring(rotation).."."
        end


		return true, {
            instance = result,
            setPosition = setPosition,
            setPos = setPosition,
            setOrientation = setRotation,
            setRotation = setRotation,
            setRot = setRotation,
            setScale = setSize,
            setSize = setSize,
            setColor = setColor,
            setCol = setColor,
            setProperty = setProperty,
            setPro = setProperty,
            delete = delete,
            del = del,
        }
	end
    return false, result
end

buildtool = getTool("BuildingTool")
if not buildtool then print("Couldn't find BuildingTool. Exiting.") return end
deletetool = getTool("DeleteTool")
if not deletetool then print("Couldn't find DeleteTool. Cannot delete blocks.") end
painttool = getTool("PaintingTool")
if not painttool then print("Couldn't find PaintingTool. Cannot paint blocks.") end
scaletool = getTool("ScalingTool")
if not scaletool then print("Couldn't find ScalingTool. Cannot scale blocks.") end
propertiestool = getTool("PropertiesTool")
if not propertiestool then print("Couldn't find PropertiesTool. Cannot change result's properties.") end

return builder
