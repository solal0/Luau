-- ByteCode Inspector v1
-- I made this in case decompiling with dex doesn't work.

-- TODO:
-- DONE. Fix Skira's Library codebox text being off in some cases
-- handle workspace... and not just game...

local httpRequest = request or http_request or (syn and syn.request)
assert(httpRequest, "Your executor does not support http requests.")
assert(getscriptbytecode, "Your executor does not support getscriptbytecode.")

local utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/Utils.luau"))()
local lib = loadstring(game:HttpGet("https://skira.me/lua/SkiraLibrary/source"))()
local g = utils.services

local instance,bytecode,decoded = nil,nil,nil
local service = "luacid"

local gui = utils.getSafeGui()
local window, content, api = lib:Window(gui,"ByteCode Inspector",UDim2.new(0,400,0,300),{noscroll = true,position = UDim2.new(1,-410,0,48),symbol = "rbxassetid://94911923878147",collapsable = true,closable = true,Xresizable = true,Yresizable = true,draggable = true})

api.symbol.Image = "rbxassetid://94911923878147"
api.symbol.ScaleType = Enum.ScaleType.Crop
api.symbol.ImageRectSize = Vector2.new(128, 128)
api.symbol.ImageRectOffset = Vector2.new(0, 0)
task.spawn(function()
	local CX = 0
	local CY = 0
	while true do
		if CX == 5 - 1 then
			CX = 0
			CY = CY + 1
			if CY == 5 then CY = 0 end
		else CX = CX + 1 end
		api.symbol.ImageRectOffset = Vector2.new(CX == 0 and 0 or 128 * CX, CY == 0 and 0 or 128 * CY)
		task.wait(0.8 / 9)
	end
end)

function notify(v)
	print(v)
	lib:Notify(gui,3,{text = v})
end

function getInstance(path)
	local parts = string.split(path, ".")
	local c = parts[1] == "game" and game or workspace
	for i = 2, #parts do
		c = c:FindFirstChild(parts[i])
		if not c then
			return nil
		end
	end
	if c:IsA("ModuleScript") or c:IsA("Script") then
		if c.ClassName == "Script" then
			print("Scripts are impossible to save, said saveinstance. But i'll try.") -- nvm, they ARE impossible to save
		end
		return c
	else
		notify(c.." is not a valid instance")
		return nil
	end
end

function getByteCode(v)
	local success, bytecode = pcall(getscriptbytecode, v)
	if success and type(bytecode) == "string" then
		return bytecode
	else
		notify("Failed to get bytecode for "..v)
		return false
	end
end

function saveFile(name,content)
	if not writefile then
		notify("Your executor does not support writefile")
		return
	end
	local success = pcall(function() writefile(name, content) end)
	if success then
		return true
	else
		notify("Failed to save "..name)
		return false
	end
end

function decompile(v)
	local response = httpRequest({
		Url = "https://skira.me/lua/decompile.php?service="..service,
		Method = "POST",
		Headers = {["Content-Type"] = "text/plain"},
		Body = utils.encode(bytecode)
	})

	return response.Body
end

function getName()
	local result = ""
	if instance then
		result = instance.Name.."_"..instance.ClassName.."_"..game.PlaceId
	else
		result = "Unknown_Unknown_"..game.PlaceId
	end
	if decoded then
		result = result.."_decompiled.lua"
	elseif bytecode then
		result = result.."_bytecode.lua"
	else
		result = result.."_raw.lua"
	end
	return result
end

local codebox = lib:CodeBox(content,"",{text = [[
-- ByteCode Inspector by Skira (https://github.com/solal0)
-- Nothing to show
]],style = "studio",display = true,spacing = 60,size = UDim2.new(1,0,1,-78)})
local holder = lib:Holder(content,{padding = UDim.new(0.002,0)})
local column1 = lib:Column(holder,.535,Enum.HorizontalAlignment.Left)
local column2 = lib:Column(holder,.21,Enum.HorizontalAlignment.Center)
local column3 = lib:Column(holder,.13,Enum.HorizontalAlignment.Center)
local column4 = lib:Column(holder,.12,Enum.HorizontalAlignment.Center)

local path = lib:TextBox(column1,"",{text = "path.to.script"})
lib:Button(column2,"Decompile",{alignmentX = Enum.TextXAlignment.Center,callback = function()
	if path.Text ~= "" then
		local obj = getInstance(path.Text)
		if obj then
			instance,bytecode,decoded = obj,getByteCode(obj),nil
			if bytecode and type(bytecode) == "string" then
				--saveFile(getName(),bytecode)
				decoded = decompile(bytecode)
				if decoded then
					--saveFile(getName(),decoded)
					codebox.Text = decoded
				else
					notify("Failed to decompile bytecode")
				end
			else
				notify("Failed to get bytecode from "..obj.Name)
			end
		else
			notify("Invalid path: "..path.Text)
		end
	end
end})
lib:Button(column3,"Clear",{alignmentX = Enum.TextXAlignment.Center,callback = function()
	bytecode,decoded = nil,nil
	codebox.Text = ""
end})
lib:Button(column4,"Save",{alignmentX = Enum.TextXAlignment.Center,callback = function()
	if codebox.Text ~= "" then
		local name = instance and instance.Name or "Unknown"
		local class = instance and instance.ClassName or "Unknown"

		local success = saveFile(getName(),codebox.Text)
		if success then
			notify("Saved codebox content as "..getName())
		else
			notify("Failed to save codebox content")
		end
	else
		notify("Nothing to save from the codebox (it's empty)")
	end
end})
lib:Dropdown(content,"Decompiler",{"Luacid", "LunaUX"},{default = "Luacid",callback = function(v) service = string.lower(v) end})
lib:Button(content,"Dex Explorer",{callback = function() pcall(function() loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))() end) end})
