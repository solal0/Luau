-- Edited version of @ImSnox's Blur Controller by @CaptainSkira
-- The script was weirdly done, it was a module script slightly changed so it could work as a LocalScript
-- I changed it back to a ModuleScript, removed any script.Parent mention and fixed the part size to fit frames correctly

local Lighting          = game:GetService("Lighting")
local camera            = workspace.CurrentCamera

local BLUR_SIZE, PART_SIZE, PART_TRANSPARENCY, BLUR_OBJ, EXTRA

local PartsList         = {}
local BlursList         = {}
local BlurObjects       = {}
local BlurredGui        = {}

local init = false

BlurredGui.__index      = BlurredGui

function rayPlaneIntersect(planePos, planeNormal, rayOrigin, rayDirection)
	local n = planeNormal
	local d = rayDirection
	local v = rayOrigin - planePos

	local num = n.x*v.x + n.y*v.y + n.z*v.z
	local den = n.x*d.x + n.y*d.y + n.z*d.z
	local a = -num / den

	return rayOrigin + a * rayDirection, a
end

function rebuildPartsList()
	PartsList = {}
	BlursList = {}
	for blurObj, part in pairs(BlurObjects) do
		table.insert(PartsList, part)
		table.insert(BlursList, blurObj)
	end
end

function BlurredGui.Remove(frame:Frame)
	local found = false
	for i,v in pairs(BlurObjects) do
		if i.Frame == frame then
			i.Part:Destroy()
			BlurObjects[i] = nil
			rebuildPartsList()
			found = true -- handles frames who were applied multiple blur
		end
	end
	return found
end

function BlurredGui.New(frame:Frame, shape:string?)
	if not init then
		--warn("init() has not been called yet.")
		BlurredGui.Init()
	end
	
	local blurPart        = Instance.new("Part")
	blurPart.Size         = Vector3.new(1, 1, 1) * 0.01 -- was 0.01 but it didn't fill frames perfectly
	blurPart.Anchored     = true
	blurPart.CanCollide   = false
	blurPart.CanTouch     = false
	blurPart.Material     = Enum.Material.Glass
	blurPart.Transparency = PART_TRANSPARENCY
	blurPart.Parent       = workspace.CurrentCamera

	local mesh
	shape = shape or "Rectangle"
	if (shape == "Rectangle") then
		mesh        = Instance.new("BlockMesh")
		mesh.Parent = blurPart
	elseif (shape == "Oval") then
		mesh          = Instance.new("SpecialMesh")
		mesh.MeshType = Enum.MeshType.Sphere
		mesh.Parent   = blurPart
	end

	local ignoreInset = false
	local currentObj  = frame

	while true do
		currentObj = currentObj.Parent

		if (currentObj and currentObj:IsA("ScreenGui")) then
			ignoreInset = currentObj.IgnoreGuiInset
			break
		elseif (currentObj == nil) then
			break
		end
	end

	local new = setmetatable({
		Frame          = frame;
		Part           = blurPart;
		Mesh           = mesh;
		IgnoreGuiInset = ignoreInset;
	}, BlurredGui)

	BlurObjects[new] = blurPart
	rebuildPartsList()

	game:GetService("RunService"):BindToRenderStep("...", Enum.RenderPriority.Camera.Value + 1, function()
		if not frame or not frame.Parent then
			BlurredGui.Remove() -- removes all nil frames
		else
			blurPart.CFrame = camera.CFrame * CFrame.new(0,0,0)
			BlurredGui.UpdateAll()
		end
	end)
	return new
end

function updateGui(blurObj)
	if (not blurObj.Frame.Visible) then
		blurObj.Part.Transparency = 1
		return
	end

	local camera = workspace.CurrentCamera
	local frame  = blurObj.Frame
	local part   = blurObj.Part
	local mesh   = blurObj.Mesh

	part.Transparency = PART_TRANSPARENCY

	local corner0 = frame.AbsolutePosition + BLUR_SIZE
	local corner1 = corner0 + frame.AbsoluteSize - BLUR_SIZE*2
	local ray0, ray1

	if (blurObj.IgnoreGuiInset) then
		ray0 = camera:ViewportPointToRay(corner0.X, corner0.Y, 1)
		ray1 = camera:ViewportPointToRay(corner1.X, corner1.Y, 1)
	else
		ray0 = camera:ScreenPointToRay(corner0.X, corner0.Y, 1)
		ray1 = camera:ScreenPointToRay(corner1.X, corner1.Y, 1)
	end

	local planeOrigin = camera.CFrame.Position + camera.CFrame.LookVector * (0.05 - camera.NearPlaneZ)
	local planeNormal = camera.CFrame.LookVector
	local pos0 = rayPlaneIntersect(planeOrigin, planeNormal, ray0.Origin, ray0.Direction)
	local pos1 = rayPlaneIntersect(planeOrigin, planeNormal, ray1.Origin, ray1.Direction)

	local pos0 = camera.CFrame:PointToObjectSpace(pos0)
	local pos1 = camera.CFrame:PointToObjectSpace(pos1)

	local size   = pos1 - pos0
	local center = (pos0 + pos1)/2

	mesh.Offset = center + EXTRA
	mesh.Scale  = (size / PART_SIZE) + Vector3.new(0.7,-.7,0)
end

function BlurredGui.UpdateAll()
	for i = 1, #BlursList do
		updateGui(BlursList[i])
	end
	
	for i,v in pairs(Lighting:GetChildren()) do
		if v:IsA("DepthOfFieldEffect") and v ~= BLUR_OBJ then
			v.Enabled = false
		end
	end

	local cframes = table.create(#BlursList, workspace.CurrentCamera.CFrame)
	workspace:BulkMoveTo(PartsList, cframes, Enum.BulkMoveMode.FireCFrameChanged)

	BLUR_OBJ.FocusDistance = 0.25 - camera.NearPlaneZ
end

function BlurredGui.Init(data)
	if init then return end
	EXTRA = data.Extra or Vector3.new(0,0,0)
	BLUR_SIZE = data.BlurSize or Vector2.new(10, 10)
	PART_SIZE = data.PartSize or 0.01
	PART_TRANSPARENCY = data.PartTransparency or 1 - 1e-7
	BLUR_OBJ = Instance.new("DepthOfFieldEffect",Lighting)
	BLUR_OBJ.FarIntensity = data.FarIntensity or 0
	BLUR_OBJ.NearIntensity = data.NearIntensity or 0.25
	BLUR_OBJ.FocusDistance = data.FocusDistance or 0.25
	BLUR_OBJ.InFocusRadius = data.InFocusRadius or 0
	init = true
	return BlurredGui
end

return BlurredGui
