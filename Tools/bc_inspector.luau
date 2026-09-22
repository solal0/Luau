-- ByteCode Inspector v1.3
-- https://github.com/solal0/Luau/
-- I made this in case decompiling with dex doesn't work.

-- Changelog
-- fixed Skira's Library codebox text being off in some cases
-- now handles workspace, game and :GetService
-- now handles .LocalPlayer
-- better save directory and better saveFile
-- added setting tab, autosave bytecode, autosave decompiled and config save/load

local httpRequest = request or http_request or (syn and syn.request)
assert(httpRequest, "Your executor does not support http requests.")
assert(getscriptbytecode, "Your executor does not support getscriptbytecode.")
local cansave = type(makefolder) == "function" and type(writefile) == "function"

local utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/Utils.luau"))()
local lib = loadstring(game:HttpGet("https://skira.me/lua/SkiraLibrary/source"))()
local g = utils.services

local folder = "ByteCodeInspector/Games/"..game.GameId
local gameName = g.MarketplaceService:GetProductInfo(game.GameId).Name
if cansave then
	makefolder("ByteCodeInspector")
	makefolder("ByteCodeInspector/Games")
	makefolder(folder)
	makefolder(folder.."/Extra")
	makefolder(folder.."/Bytecode")
	makefolder(folder.."/Decompiled")
else
	print("Your executor does not support makefolder and/or writefile. Scripts won't be saved")
end

-- config stuff
local cConfig = {autosaveBC = true,autosaveDC = false,decompiler = "luacid"}
function load()
	if not cansave then return end
	local success,config = pcall(readfile,"ByteCodeInspector/config.json")
	if success and config then
		config = g.HttpService:JSONDecode(config)
		for i,v in pairs(config) do
			cConfig[i] = v
		end
	end
end
function save()
	if not cansave then return end
	local config = g.HttpService:JSONEncode(cConfig)
	local success = pcall(function() writefile("ByteCodeInspector/config.json",config) end)
	if not success then
		notify("Failed to save config")
		return
	end
end
load()

local instance,bytecode,decompiled = nil,nil,nil
local decompileTime = ""

local gui = utils.getSafeGui()
local window, content, api = lib:Window(gui,"ByteCode Inspector",UDim2.new(0,600,0,400),{noscroll = true,position = UDim2.new(1,-660,0,60),symbol = "rbxassetid://94911923878147",collapsable = true,closable = true,Xresizable = true,Yresizable = true,draggable = true})

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
	local id = parts[1]
	local c = id == "game" and game or id:find("GetService", 1, true) and game:GetService(id:match('"([^"]+)"')) or workspace

	for i = 2, #parts do
		c = parts[i] == "LocalPlayer" and c.LocalPlayer or c:FindFirstChild(parts[i])
		if not c then
			--print("Failed at",parts[i])
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

function saveFile(content)
	if not cansave then
		notify("Your executor does not support makefolder and/or writefile")
		return
	end

	local name = instance and instance.Name.."_"..instance.ClassName
	local path = content == bytecode and folder.."/Bytecode/"..name.."_bc.lua" or folder.."/Decompiled/"..name.."_dc.lua"

	local success = pcall(function() writefile(path, content) end)
	if success then
		return true
	else
		notify("Failed to save "..name)
		return false
	end
end

function decompile(v)
	local response = httpRequest({
		Url = "https://skira.me/lua/decompile.php?service="..cConfig.decompiler,
		Method = "POST",
		Headers = {["Content-Type"] = "text/plain"},
		Body = utils.encode(bytecode)
	})

	return response.Body
end

local tab,content = lib:Tab(window,"Main",{noscroll = true})

local codebox = lib:CodeBox(content,"",{text = [[
-- ByteCode Inspector by Skira (https://github.com/solal0)
-- Nothing to show
]],style = "studio",display = true,spacing = 60,size = UDim2.new(1,0,1,-26)})
local holder = lib:Holder(content,{padding = UDim.new(0.002,0)})
local column1 = lib:Column(holder,.535,Enum.HorizontalAlignment.Left)
local column2 = lib:Column(holder,.21,Enum.HorizontalAlignment.Center)
local column3 = lib:Column(holder,.13,Enum.HorizontalAlignment.Center)
local column4 = lib:Column(holder,.12,Enum.HorizontalAlignment.Center)

local path = lib:TextBox(column1,"",{text = "path.to.script"})
lib:Button(column2,"Decompile",{alignmentX = Enum.TextXAlignment.Center,callback = function()
	if path.Text ~= "" then
		codebox.Text = "Looking for the instance..."
		local obj = getInstance(path.Text)
		if obj then
			codebox.Text = codebox.Text.."\nGetting script bytecode..."
			instance,bytecode,decompiled = obj,getByteCode(obj),nil
			if bytecode and type(bytecode) == "string" then
				codebox.Text = codebox.Text.."\nDecompiling with "..cConfig.decompiler.."..."
				local now = os.time()
				if cConfig.autosaveBC then saveFile(bytecode) end
				decompiled = decompile(bytecode)
				if decompiled then
					now = os.time() - now
					local h,m,s=math.floor(now/3600),math.floor(now%3600/60),now%60
					local p={}
					if h>0 then table.insert(p,h.."h") end
					if m>0 or h>0 then table.insert(p,m.."m") end
					if s>0 or #p==0 then table.insert(p,s.."s") end
					decompileTime = table.concat(p," ")
					decompiled = "-- File created using ByteCode Inspector (https://github.com/solal0/Luau/)\n\n-- Decompiled in "..decompileTime.." by "..cConfig.decompiler.."\n-- Path: "..instance:GetFullName().."\n-- Class: "..instance.ClassName.."\n\n-- If the script cuts off, click Save below to have the full script as a file.\n\n"..decompiled
					codebox.Text = decompiled
					if cConfig.autosaveDC then saveFile(decompiled) end
				else
					codebox.Text = codebox.Text.."\nFailed to decompile bytecode using "..cConfig.decompiler
				end
			else
				codebox.Text = codebox.Text.."\nFailed to get bytecode from "..obj.Name
			end
		else
			codebox.Text = "Invalid path: "..path.Text
		end
	end
end})
lib:Button(column3,"Clear",{alignmentX = Enum.TextXAlignment.Center,callback = function()
	bytecode,decompiled = nil,nil
	codebox.Text = ""
end})
lib:Button(column4,"Save",{alignmentX = Enum.TextXAlignment.Center,callback = function()
	if codebox.Text ~= "" then
		local success = saveFile(decompiled) -- codebox.Text
		if success then
			notify("Saved content to "..folder.."/Decompiled")
		else
			notify("Failed to save content")
		end
	else
		notify("Nothing to save (it's empty)")
	end
end})

local tab,content = lib:Tab(window,"Settings",{noscroll = true,autoselect = false})

lib:Separator(content,{text = "Config"})
lib:Dropdown(content,"Decompiler",{"Luacid", "LunaUX"},{default = cConfig.decompiler == "luacid" and "Luacid" or "LunaUX",callback = function(v)
	cConfig.decompiler = string.lower(v)
	save()
end})
lib:Toggle(content,"AutoSave Bytecode",{state = cConfig.autosaveBC,callback = function(v)
	cConfig.autosaveBC = v
	save()
end})
lib:Toggle(content,"AutoSave Decompiled",{state = cConfig.autosaveDC,callback = function(v)
	cConfig.autosaveDC = v
	save()
end})
lib:Separator(content,{text = "Usefull Tools"})
lib:Button(content,"Dex Explorer",{callback = function()
	pcall(function() loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))() end)
end})
lib:Button(content,"Infinite Yield",{callback = function()
	pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
end})

print("ByteCode Inspector v1.2 loaded")
