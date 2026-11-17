-- Stand UI v1 by @CaptainSkira (https://github.com/solal0)

-- TODO: ADD COMMANDS AND NOTIFICATIONS BUT COMMANDS FIRST !!!!!!!!!!!!!!!!!!!! -- It's done, shush
-- TODO: finish NewKey, fix separator not triggering next option -- done
-- TODO: fix options not being correctly selected when entering a category -- done

-- tables
blocked = {}
commands = {}
connections = {}
ui = {Tabs = {},Keys = {},KeyCalls = {}}


-- dependencies
ui.Utils = require(script.Utils) -- loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/Utils.luau"))())
ui.Blur = require(script.BlurredGui).Init() -- loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/BlurredGui.luau"))())
ui.KeyToKey = require(script.KeyToKey) -- loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/KTK.luau"))())
ui.Icons = {
	Icons = {
		["Search"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(0,0)},
		["User"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(256,0)},
		["Friends"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(512,0)},
		["Users"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(768,0)},
		["Link"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(0,256)},
		["Edit"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(256,256)},
		["Disabled"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(512,256)},
		["Enabled"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(768,256)},
		["Toggle Off List"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(0,512)},
		["Toggle On List"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(256,512)},
		["Toggle Off"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(512,512)},
		["Toggle On"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(768,512)},
		["Toggle Off Auto"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(0,768)},
		["Toggle On Auto"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(256,768)},
		["List Center"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(512,768)},
		["List"] = {"rbxassetid://131150936834233",Vector2.new(256,256),Vector2.new(768,768)},
		["Game"] = {"rbxassetid://114920878321923",Vector2.new(60,60),Vector2.new(0,0)},
		["Online"] = {"rbxassetid://114920878321923",Vector2.new(60,60),Vector2.new(60,0)},
		["Players"] = {"rbxassetid://114920878321923",Vector2.new(60,60),Vector2.new(120,0)},
		["Self"] = {"rbxassetid://114920878321923",Vector2.new(60,60),Vector2.new(180,0)},
		["Stand"] = {"rbxassetid://114920878321923",Vector2.new(60,60),Vector2.new(240,0)},
		["Vehicle"] = {"rbxassetid://114920878321923",Vector2.new(60,60),Vector2.new(300,0)},
		["World"] = {"rbxassetid://114920878321923",Vector2.new(60,60),Vector2.new(360,0)},
		["Header Loading"] = {"rbxassetid://114920878321923",Vector2.new(1020,360),Vector2.new(0,60)},
	},
	setImage = function(i,v)
		local icon = ui.Icons.Icons[v]
		i.ImageRectOffset = icon[3]
		i.ImageRectSize = icon[2]
		i.Image = icon[1]
	end
}


-- vars
MAX_OPTIONS = 11
VERSION = "v1.0"
clipboard = ui.Utils.clipboard()
openurl = ui.Utils.openurl()

ui.TRANSPARENCY = 0.7
ui.TRANSPARENCY_THEME = 0

ui.SIZE_GAP = 3
ui.SIZE_TAB_X = 112
ui.SIZE_OPTION_Y = 32 -- options, tabs and command box text field
ui.SIZE_CONTENT_X = 450
ui.SIZE_CONTENT_Y = MAX_OPTIONS*ui.SIZE_OPTION_Y
ui.SIZE_BAR_X = ui.SIZE_TAB_X+ui.SIZE_GAP+ui.SIZE_CONTENT_X
ui.SIZE_BAR_Y = 24 -- main window and command box
ui.SIZE_INFORMATION_X = 300
ui.SIZE_INFORMATION_Y = 26
ui.SIZE_SCROLLBAR_X = 6

ui.SIZE_NOTIFICATION_GAP_X = 19 -- from left
ui.SIZE_NOTIFICATION_GAP_Y = 19 -- from bottom
ui.SIZE_NOTIFICATION_BAR = 3
ui.SIZE_NOTIFICATION_X = 413
ui.SIZE_NOTIFICATION_Y = 46

ui.SIZE_COMMAND_BOX_X = 547
ui.SIZE_COMMAND_BOX_GAP = 100 -- from top (100 x 0.625 = 62.5)

ui.SIZE_NOTIFICATION2_GAP_X = 29 -- from left
ui.SIZE_NOTIFICATION2_GAP_Y = 17 -- from top
ui.SIZE_NOTIFICATION2_X = 372 -- will be updated to fit the given text
ui.SIZE_NOTIFICATION2_Y = 45

ui.SIZE_TEXT_SMALL = 18
ui.SIZE_TEXT_MEDIUM = 22
ui.SIZE_TEXT_BIG = 26

ui.POSITION_WINDOW_X = -(ui.SIZE_BAR_X+31)
ui.POSITION_WINDOW_Y = -519

--[[ x0.625
ui.SIZE_GAP = 2
ui.SIZE_TAB_X = 70
ui.SIZE_OPTION_Y = 20 -- options, tabs and command box text field
ui.SIZE_CONTENT_X = 281
ui.SIZE_CONTENT_Y = MAX_OPTIONS*ui.SIZE_OPTION_Y
ui.SIZE_BAR_X = ui.SIZE_TAB_X+ui.SIZE_GAP+ui.SIZE_CONTENT_X
ui.SIZE_BAR_Y = 15 -- main window and command box
ui.SIZE_INFORMATION_X = 188
ui.SIZE_INFORMATION_Y = 16
ui.SIZE_SCROLLBAR_X = 4

ui.SIZE_NOTIFICATION_GAP_X = 12 -- from left
ui.SIZE_NOTIFICATION_GAP_Y = 12 -- from bottom
ui.SIZE_NOTIFICATION_BAR = 2
ui.SIZE_NOTIFICATION_X = 258
ui.SIZE_NOTIFICATION_Y = 29

ui.SIZE_COMMAND_BOX_X = 341
ui.SIZE_COMMAND_BOX_GAP = 63 -- from top (100 x 0.625 = 62.5)

ui.SIZE_NOTIFICATION2_GAP_X = 18 -- from top
ui.SIZE_NOTIFICATION2_GAP_Y = 11 -- from left
ui.SIZE_NOTIFICATION2_X = 233 -- will be updated to fit the given text
ui.SIZE_NOTIFICATION2_Y = 28

ui.SIZE_TEXT_SMALL = 14
ui.SIZE_TEXT_MEDIUM = 16
ui.SIZE_TEXT_BIG = 18

ui.POSITION_WINDOW_X = -(ui.SIZE_BAR_X+19)
ui.POSITION_WINDOW_Y = -325
]]--

-- colors
ui.COLOR_TEXT = Color3.new(1,1,1)
ui.COLOR_THEME = Color3.new(1,0,1)
ui.COLOR_BACKGROUND = Color3.new(0,0,0)
ui.COLOR_NOTIFICATION = Color3.new(.5,0,.5)

-- keys
ui.Keys.KEY_UP = Enum.KeyCode.Up
ui.Keys.KEY_DOWN = Enum.KeyCode.Down
ui.Keys.KEY_LEFT = Enum.KeyCode.Left
ui.Keys.KEY_RIGHT = Enum.KeyCode.Right
ui.Keys.KEY_ENTER = Enum.KeyCode.Return
ui.Keys.KEY_BACK = Enum.KeyCode.Backspace
ui.Keys.KEY_TAB_UP = Enum.KeyCode.RightShift
ui.Keys.KEY_TAB_DOWN = Enum.KeyCode.RightControl
ui.Keys.KEY_ESCAPE = Enum.KeyCode.Escape
ui.Keys.KEY_COMMAND_BOX = Enum.KeyCode.U
ui.Keys.KEY_AUTOFILL = Enum.KeyCode.Tab
ui.Keys.KEY_TOGGLE = Enum.KeyCode.F4


-- services
CAS = ui.Utils.services.ContextActionService
UIS = ui.Utils.services.UserInputService


-- functions
function sCall(v,...)
	if v and type(v) == "function" then
		return v(...)
	end
end
function fatal(err)
	Prompt("StandUI - Error",err.."\n\nWould you like to Unload StandUI ?",3,function(v)if v == 1 then ui.unload() end end)
	warn("[StandUI]",err)
	coroutine.yield()
end

function setProperty(a,b,c)
	connections[a] = connections[a] or {}
	if connections[a][c] then connections[a][c]:Disconnect() end
	a[c] = b.Value
	connections[a][c] = b.Changed:Connect(function(d)
		if not a then
			for i,v in pairs(connections[a]) do
				v:Disconnect()
			end
			connections[a] = nil
			return
		end
		a[c] = d
	end)
end

function new(Name,Parent)
	local v = Instance.new(Name,Parent)
	if v:IsA("TextBox") then
		v.Interactable = false
		v.ClearTextOnFocus = false
	end
	if v:IsA("ScrollingFrame") then
		v.CanvasSize = UDim2.new(0,0,0,0)
		v.ScrollBarThickness = 0
	end
	if v:IsA("UIListLayout") then v.SortOrder = Enum.SortOrder.LayoutOrder end
	pcall(function() v.ZIndex = 2147483647 end)
	pcall(function() v.BorderSizePixel = 0 end)
	if Name:sub(1,4) == "Text" then
		setProperty(v,ui.SIZE_TEXT_MEDIUM,"TextSize")
		v.TextXAlignment = Enum.TextXAlignment.Left
		setProperty(v,ui.COLOR_TEXT,"TextColor3")
		v.Font = Enum.Font.SourceSans
		v.TextWrapped = true
		v.RichText = true
	end
	return v
end

function setActive(i,v) -- doesn't use setColor cuz it would create too many connections
	if v then
		setProperty(i,ui.TRANSPARENCY_THEME,"BackgroundTransparency")
		setProperty(i,ui.COLOR_THEME,"BackgroundColor3")
		--i.BackgroundColor3 = ui.COLOR_THEME.Value
		ui.Blur.Remove(i)
	else
		setProperty(i,ui.TRANSPARENCY,"BackgroundTransparency")
		setProperty(i,ui.COLOR_BACKGROUND,"BackgroundColor3")
		--i.BackgroundColor3 = ui.COLOR_BACKGROUND.Value
		ui.Blur.New(i)
	end
end

function setTab(index)
	if ui.CurrentTab then
		local last = ui.Tabs[ui.CurrentTab.Index]
		last.Folder.Visible = false
		setActive(last.Instance)
	end

	local new = ui.Tabs[index]
	setActive(new.Instance,true)
	new.Folder.Visible = true
	ui.CurrentTab = new

	new.DisplayPath = new.DisplayPath or " > "..new.Name
	ui.Bar.Text = ui.Title..new.DisplayPath
end

function setOption(tab,index,fromInteraction) -- any tab, index
	local realTab = tab.Type == "Tab" and tab or tab.Tab
	local option = tab.Options[index]

	if tab.CurrentOption then
		setActive(tab.CurrentOption.Instance)
		sCall(tab.CurrentOption.Unselect)
	end

	if realTab then
		if realTab.ActiveOption then
			--setActive(realTab.ActiveOption.Instance)
			sCall(realTab.ActiveOption.Unselect)
		end
		realTab.ActiveOption = option -- on definie ActiveOption pour que quand la category/tab est entré/sortie, le script sait quel etait la derniere option active
	end

	if not sCall(option.Select) then
		setActive(option.Instance,true)
		tab.CurrentOption = option
	end
end

function setCategory(tab,category) -- real tab, {}
	setTab(tab.Index)

	if tab.CurrentContent then
		tab.CurrentContent.Visible = false
	end

	tab.CurrentContent = category.Content
	category.Content.Visible = true
	tab.CurrentCategory = category.Type ~= "Tab" and category or nil

	if category.CurrentOption then
		setOption(category,category.CurrentOption.Index,true) -- entering a category counts as an interaction
	end
end

function up(tab,index)
	tab.First = nil
	tab.Last = nil

	for i,v in pairs(tab.Options) do
		if v.Instance.Visible then
			if not tab.First then
				tab.First = i
			end
			tab.Last = i
		end
	end

	tab.First = tab.First or 1
	tab.Last = tab.Last or MAX_OPTIONS

	if index < tab.First + 2 then
		tab.First = math.max(index - 2, 1)
		tab.Last = tab.First + MAX_OPTIONS - 1

		if tab.Last > #tab.Options then
			tab.Last = #tab.Options
			tab.First = math.max(tab.Last - MAX_OPTIONS + 1, 1)
		end
	end

	for i, v in pairs(tab.Options) do
		v.Instance.Visible = i >= tab.First and i <= tab.Last
	end

	local dif = tab.First - 1
	if dif > 0 then
		tab.ScrollBar.Position = UDim2.new(0, 0, 0, dif * ui.SIZE_OPTION_Y)
	else
		tab.ScrollBar.Position = UDim2.new(0, 0, 0, 0)
	end
end

function down(tab,index)
	tab.First = nil
	tab.Last = nil

	for i,v in pairs(tab.Options) do
		if v.Instance.Visible then
			if not tab.First then
				tab.First = i
			end
		end
	end

	tab.First = tab.First or 1
	tab.Last = tab.Last or MAX_OPTIONS

	if index > tab.Last - 2 then
		tab.Last = index + 2
		tab.First = tab.Last - MAX_OPTIONS + 1

		if tab.Last > #tab.Options then
			tab.Last = #tab.Options
			tab.First = math.max(tab.Last - MAX_OPTIONS + 1, 1)
		end

		if tab.First < 1 then
			tab.First = 1
		end
	end

	for i, v in pairs(tab.Options) do
		v.Instance.Visible = i >= tab.First and i <= tab.Last
	end

	local dif = tab.First - 1
	if dif > 0 then
		tab.ScrollBar.Position = UDim2.new(0, 0, 1/(#tab.Options-dif), 0)
	else
		tab.ScrollBar.Position = UDim2.new(0, 0, 0, 0)
	end
end

function block(v,nosave)
	for i,v in pairs(v) do
		if not nosave then table.insert(blocked,v) end
		CAS:BindAction("_"..v.Name, function() return Enum.ContextActionResult.Sink end, false, v)
	end
end

function unblock()
	for i,v in pairs(blocked) do
		CAS:UnbindAction("_"..v.Name)
	end
end

function combine(a,b)
	for i,v in pairs(a) do
		if b[i] == nil then
			b[i] = v
		end
	end
	return b
end

function getInfo()
	local source,i,highest = debug.info(1,"s"),2,1
	while debug.info(i,"f") do
		if debug.info(i,"s") ~= source then break end
		highest = i
		i += 1
	end
	local last = 4 < highest and debug.info(3,"n")
	return debug.info(highest,"n"),debug.info(highest+1,"l"),debug.info(highest+1,"s"),last
end

function GetCommandName(Name)
	if type(Name) ~= "string" then fatal(`Expected a string but got {Name} ({typeof(Name)})`) end
	Name = string.lower(Name):gsub(" ", "")
	local count = 1
	for i,v in pairs(commands) do -- see if name is already taken and how many times
		if v.OGName == Name then
			count += 1
		end
	end
	return Name..(count > 1 and count or ""),count
end

function NewCommand(Name,Function,Text,Type)
	CheckArguments({{Name,"string"},{Function,"function"},{Text,"string",0},{Type,"string"}})
	local name,count = GetCommandName(Name)
	table.insert(commands,{OGName = Name, Name = name..(count > 1 and count or ""), Call = Function, Info = Text and " - "..Text or "", Type = Type})
	return table.maxn(commands)
end

function NewOption(obj,Name,Settings)
	local tab = obj.CategoryIndex and obj.Tab.Categories[obj.CategoryIndex] or ui.Tabs[obj.Index]
	local i = table.maxn(tab.Options)+1

	local option = new("TextLabel",tab.Content.Container)
	setProperty(option,ui.TRANSPARENCY,"BackgroundTransparency")
	setProperty(option,ui.COLOR_BACKGROUND,"BackgroundColor3")
	setProperty(option,ui.SIZE_TEXT_BIG,"TextSize")
	option.Size = UDim2.new(1,0,0,ui.SIZE_OPTION_Y)
	option.TextTruncate = Enum.TextTruncate.AtEnd
	option.Name = ui.Utils.toBase26(i)
	option.Text = " "..Name

	local info,cmdInfo,command
	if Settings then
		if Settings.Command then
			local index = NewCommand(Settings.Command[1],Settings.Call,Settings.Command[2],Settings.Type)
			command = commands[index]
		end

		Settings.Select = function(a)
			if command then
				local extra
				if Settings.Type == "Toggle" then
					extra = " [on/off]"
				elseif Settings.Type == "Value" then
					extra = ` [{Settings.Min} to {Settings.Max}]`
				elseif Settings.Type == "Color" then
					extra = " [RRGGBB]"
				elseif Settings.Type == "Text" then
					extra = " [Text]"
				elseif Settings.Type == "Key" then
					extra = " [Key Name]"
				else
					extra = ""
				end
				cmdInfo = Inform("Command: "..command.Name..extra)
			end
			if Settings.Inform then info = Inform(Settings.Inform) end
			if Settings._Select then return Settings._Select() end
		end
		Settings.Unselect = function()
			if info then info:Destroy() end
			if cmdInfo then cmdInfo:Destroy() end
			if Settings._Unselect then return Settings._Unselect() end
		end
		Settings.Path = obj.Path
	end

	return option,tab,i,Settings
end

function CheckArguments(def,sttg)
	local from,at,source,from2 = getInfo()
	if def then
		for i,v in pairs(def) do
			if not v[1] and not v[3] or v[1] and typeof(v[1]) ~= v[2] then
				fatal(`{source}:{at}:[{from}]{from2 and `[{from2}]` or ""} invalid argument #{i} (expected {v[2]}, got {typeof(v[1])})`)
			end
		end
	end
	if sttg then
		for i,v in pairs(sttg) do
			if v[1] ~= nil and typeof(v[1]) ~= v[2] then
				fatal(`{source}:{at}:[{from}] invalid argument #{i} in settings (expected {v[2]}, got {typeof(v[1])})`)
			end
		end
	end
	return true
end


-- main
function del(a)
	for i,v in pairs(a:GetChildren()) do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end
end
function opt(a,v)
	local content = new("Frame",a)
	setProperty(content,ui.TRANSPARENCY,"BackgroundTransparency")
	setProperty(content,ui.COLOR_BACKGROUND,"BackgroundColor3")
	content.Size = UDim2.new(1,0,0,ui.SIZE_OPTION_Y)
	content.Position = UDim2.new(0,0,1,0)

	local text = new("TextBox",content)
	text.Position += UDim2.new(0,4,0,0)
	text.Size = UDim2.new(1,-4,1,0)
	text.BackgroundTransparency = 1
	text.Text = v.Name..v.Info
	text.Interactable = false

	content.Size = UDim2.new(1,0,0,text.TextBounds.Y+ui.SIZE_OPTION_Y/3)
end
function CommandBox(command)
	local function exit()
		if connections.CommandBoxConn3 then
			connections.CommandBoxConn3:Disconnect()
			connections.CommandBoxConn3 = nil
		end
		if connections.CommandBoxConn2 then
			connections.CommandBoxConn2:Disconnect()
			connections.CommandBoxConn2 = nil
		end
		if connections.CommandBoxConn1 then
			connections.CommandBoxConn1:Disconnect()
			connections.CommandBoxConn1 = nil
		end
		if ui.CommandBox then
			ui.CommandBox:Destroy()
			ui.CommandBox = nil
		end
	end
	exit()

	local header = new("TextLabel",ui.Gui)
	header.Position = UDim2.new(.5,-ui.SIZE_BAR_X/2,0,ui.SIZE_COMMAND_BOX_GAP)
	setProperty(header,ui.TRANSPARENCY_THEME,"BackgroundTransparency")
	header.Size = UDim2.new(0,ui.SIZE_COMMAND_BOX_X,0,ui.SIZE_BAR_Y)
	setProperty(header,ui.COLOR_THEME,"BackgroundColor3")
	header.Text = " Stand Command Box"
	header.Name = "CommandBox"

	local container = new("Frame",header)
	container.Position += UDim2.new(0,0,0,ui.SIZE_BAR_Y+ui.SIZE_GAP)
	setProperty(container,ui.TRANSPARENCY,"BackgroundTransparency")
	setProperty(container,ui.COLOR_BACKGROUND,"BackgroundColor3")
	container.Size = UDim2.new(1,0,0,ui.SIZE_OPTION_Y)

	local content = new("TextBox",container)
	content.Position += UDim2.new(0,4,0,0)
	content.Size = UDim2.new(1,-4,1,0)
	content.BackgroundTransparency = 1
	content.Interactable = true
	content.TextWrapped = false
	content:CaptureFocus()

	local suggestions = new("ScrollingFrame",header)
	suggestions.Position += UDim2.new(0,0,0,ui.SIZE_BAR_Y+ui.SIZE_GAP+ui.SIZE_OPTION_Y+ui.SIZE_GAP)
	suggestions.BackgroundTransparency = 1
	suggestions.Size = UDim2.new(1,0,0,0)
	suggestions.ClipsDescendants = false

	new("UIListLayout",suggestions).Padding = UDim.new(0,ui.SIZE_GAP)

	local args,first,selected
	connections.CommandBoxConn3 = content:GetPropertyChangedSignal("Text"):Connect(function()
		--content.Text = string.gsub(string.lower(content.Text), "\t", "")
		local split = string.split(content.Text, " ")
		selected,args,first = nil, nil, nil
		del(suggestions)
		if #split[1] > 2 then
			for i, v in pairs(commands) do
				if v.Name == split[1] then
					table.remove(split, 1)
					args = split
					selected = v
					del(suggestions)
					opt(suggestions, v)
					break
				end

				if string.find(v.Name, split[1], 1, true) and not split[2] then
					if not first then first = v end
					opt(suggestions, v)
				end
			end
		end
	end)

	connections.CommandBoxConn2 = content.FocusLost:Connect(function(v)
		wait()
		content:CaptureFocus()
		content.CursorPosition = #content.Text + 1
	end)

	connections.CommandBoxConn1 = UIS.InputBegan:Connect(function(i)
		if i.KeyCode == ui.Keys.KEY_ENTER and selected then
			local a = args[1]
			if a then
				if selected.Type == "Toggle" then
					if a == "on" or a == "true" then
						a = true
					elseif a == "off" or a == "false" then
						a = false
					end
					selected.Call(a)
				elseif selected.Type == "Value" and tonumber(a) then
					selected.Call(tonumber(a))
				elseif selected.Type == "Text" then
					selected.Call(tostring(a))
				else
					selected.Call(a)
				end
			else
				selected.Call()
			end
			wait()
			exit()
			Notify("Command executed successfully! :)")
		elseif i.KeyCode == ui.Keys.KEY_ESCAPE then
			exit()
		elseif i.KeyCode == ui.Keys.KEY_AUTOFILL then
			if first then
				content.Text = first.Name.." "
				selected = first
			end
		end
	end)

	ui.CommandBox = header
	content.Text = command and command or ""
end

function Inform(Text:string)
	if not CheckArguments({{Text,"string"}}) then return end

	local tabs = ui.Main.Tabs
	local b26 = ui.Utils.toBase26
	local count = #tabs:GetChildren()

	local infoList = tabs:FindFirstChildOfClass("ScrollingFrame")
	if not infoList then
		infoList = new("ScrollingFrame",tabs)
		infoList.Size = UDim2.new(1,0,1,0)
		infoList.ClipsDescendants = false
		infoList.Name = b26(count)
		infoList.Transparency = 1

		local list = new("UIListLayout",infoList)
		list.HorizontalAlignment = Enum.HorizontalAlignment.Right
		list.Padding = UDim.new(0,ui.SIZE_GAP)

		local separator = new("Frame",infoList)
		separator.Size = UDim2.new(1,0,0,0)
		separator.Name = b26(count)

		tabs.ChildAdded:Connect(function()
			count = #tabs:GetChildren()
			infoList.Name = b26(count)
		end)
	end

	local info = new("TextBox",infoList)
	info.Size = UDim2.new(0,ui.SIZE_INFORMATION_X,0,ui.SIZE_INFORMATION_Y)
	info.Position = UDim2.new(0,ui.SIZE_INFORMATION_X-ui.SIZE_TAB_X,0,0)
	setProperty(info,ui.TRANSPARENCY,"BackgroundTransparency")
	setProperty(info,ui.COLOR_BACKGROUND,"BackgroundColor3")
	info.Interactable = false
	info.Name = b26(count-1)
	info.Text = Text

	local fix = new("Frame",info)
	setProperty(fix,ui.TRANSPARENCY,"BackgroundTransparency")
	setProperty(fix,ui.COLOR_BACKGROUND,"BackgroundColor3")
	fix.Position = UDim2.new(0,-3,0,0)
	fix.Size = UDim2.new(0,3,1,0)

	if info.TextBounds.X > ui.SIZE_INFORMATION_X or info.TextBounds.Y > ui.SIZE_INFORMATION_Y then
		info.Size = UDim2.new(0,ui.SIZE_INFORMATION_X,0,info.TextBounds.Y)
	end

	return info
end

function GameNotify(Text:string,Length:number?)
	if not CheckArguments({{Text,"string"},{Length,"number",0}}) then return end
	local notification = ui.Gui:FindFirstChild("Notification")
	if ui.Gui:FindFirstChild("Notification") then ui.Gui.Notification:Destroy() end

	local notification = new("TextBox",ui.Gui)
	notification.Position = UDim2.new(0,ui.SIZE_NOTIFICATION2_GAP_X,0,ui.SIZE_NOTIFICATION2_GAP_Y)
	notification.Size = UDim2.new(0,ui.SIZE_NOTIFICATION2_X,0,ui.SIZE_NOTIFICATION2_Y)
	setProperty(notification,ui.COLOR_BACKGROUND,"BackgroundColor3")
	notification.TextXAlignment = Enum.TextXAlignment.Center
	notification.Font = Enum.Font.BuilderSansMedium
	notification.BackgroundTransparency = .2
	notification.Name = "Notification"
	notification.Interactable = false
	notification.TextWrapped = false
	notification.TextSize = 34
	notification.Text = Text

	notification.Size = UDim2.new(0,notification.TextBounds.X + 20,0,ui.SIZE_NOTIFICATION2_Y)

	if Length then
		task.spawn(function()
			task.wait(Length or 3)
			if notification and notification.Parent then
				notification:Destroy()
			end
		end)
	end

	return notification
end

function Notify(Text:string,Length:number?)
	if not CheckArguments({{Text,"string"},{Length,"number",0}}) then return end
	local container = ui.Gui:FindFirstChild("Notifications")
	if not container then
		container = new("ScrollingFrame",ui.Gui)
		container.Position = UDim2.new(0,ui.SIZE_NOTIFICATION_GAP_X,0,-ui.SIZE_NOTIFICATION_GAP_Y)
		container.Size = UDim2.new(0,ui.SIZE_NOTIFICATION_X,1,0)
		container.BackgroundTransparency = 1
		container.Name = "Notifications"

		local list = new("UIListLayout",container)
		list.VerticalAlignment = Enum.VerticalAlignment.Bottom
		list.Padding = UDim.new(0,ui.SIZE_GAP)
	end

	local notification = new("Frame",container)
	notification.Size = UDim2.new(0,ui.SIZE_NOTIFICATION_X,0,ui.SIZE_NOTIFICATION_Y)
	setProperty(notification,ui.COLOR_NOTIFICATION,"BackgroundColor3")
	notification.Position = UDim2.new(0,0,1,0)

	local b = new("Frame",notification)
	setProperty(b,ui.COLOR_THEME,"BackgroundColor3")
	b.Size = UDim2.new(0,ui.SIZE_NOTIFICATION_BAR,1,0)
	setProperty(b,ui.TRANSPARENCY_THEME,"BackgroundTransparency")

	local content = new("TextBox",notification)
	content.Position += UDim2.new(0,ui.SIZE_NOTIFICATION_BAR+6,0,0)
	content.Size = UDim2.new(1,-ui.SIZE_NOTIFICATION_BAR-6,1,0)
	content.BackgroundTransparency = 1
	content.Interactable = false
	content.Text = Text

	notification.Size = UDim2.new(1,0,0,content.TextBounds.Y+ui.SIZE_NOTIFICATION_Y/2)

	task.spawn(function()
		task.wait(Length or 3)
		notification:Destroy()
	end)

	task.spawn(function()
		task.wait(.5)
		setProperty(notification,ui.TRANSPARENCY,"BackgroundTransparency")
		setProperty(notification,ui.COLOR_BACKGROUND,"BackgroundColor3")
	end)
end

function Prompt(Title:string,Text:string,Type:number?,Function:()->number?)
	if not CheckArguments({{Title,"string"},{Text,"string"},{Type,"number",0},{Function,"function",0}}) then return end

	local header = new("TextLabel",ui.Gui)
	setProperty(header,ui.TRANSPARENCY_THEME,"BackgroundTransparency")
	header.Size = UDim2.new(0,ui.SIZE_BAR_X,0,ui.SIZE_BAR_Y)
	setProperty(header,ui.COLOR_THEME,"BackgroundColor3")
	header.TextWrapped = false
	header.Text = " "..Title
	header.Name = "Prompt"

	local container = new("Frame",header)
	container.Position = UDim2.new(0,0,0,ui.SIZE_BAR_Y+ui.SIZE_GAP)
	setProperty(container,ui.TRANSPARENCY,"BackgroundTransparency")
	setProperty(container,ui.COLOR_BACKGROUND,"BackgroundColor3")

	local content = new("TextLabel",container)
	content.BackgroundTransparency = 1
	content.TextWrapped = true
	content.TextXAlignment = Enum.TextXAlignment.Left
	content.TextYAlignment = Enum.TextYAlignment.Top
	content.Text = Text

	container.Size = UDim2.new(1,0,0,0)
	content.Position = UDim2.new(0,4,0,4)
	content.Size = UDim2.new(1,-8,0,10000)
	local height = content.TextBounds.Y
	container.Size = UDim2.new(1,0,0,height+8)
	content.Size = UDim2.new(1,-8,0,height)

	local clearem = {}
	if Type and Type > 0 then
		Type = ({{"OK"},{"OK","CANCEL"},{"YES","NO"},{"YES","NO","CANCEL"}})[Type]
		for i,v in ipairs(Type) do
			local button = new("TextButton",container)
			setProperty(button,ui.TRANSPARENCY,"BackgroundTransparency")
			setProperty(button,ui.COLOR_BACKGROUND,"BackgroundColor3")
			button.Size = UDim2.new(1/#Type,-ui.SIZE_GAP*(#Type-1)/#Type,0,ui.SIZE_OPTION_Y)
			button.Position = UDim2.new((i-1)/#Type,ui.SIZE_GAP*(i-1)/#Type,1,ui.SIZE_GAP)
			button.TextXAlignment = Enum.TextXAlignment.Center
			button.Text = v
			local index = #connections+1
			connections[index] = button.MouseButton1Click:Connect(function()
				for i,v in pairs(clearem) do connections[v]:Disconnect() end
				if Function then Function(i) end
				header:Destroy()
			end)
			table.insert(clearem,index)
		end
	end

	header.Position = UDim2.new(.5,-ui.SIZE_BAR_X/2,.5,-(ui.SIZE_BAR_Y+ui.SIZE_GAP+height+8)/2)

	return header
end

function NewText(obj,Name:string,Settings:{Default:string?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
	-- default
	Settings = Settings or {}
	if not CheckArguments({{Name,"string"}},{{Settings.Default,"string"},{Settings.Function,"function"},{Settings.Inform,"string"},{Settings.Command,"table"}}) then return end
	local option,tab,i,label

	-- vars
	local text = Settings.Default or ""
	local command = Settings.Command and GetCommandName(Settings.Command[1]) or GetCommandName(Name)

	-- functions
	local function update(v)
		text = v
		label.Text = v.." "
		if Settings.Function then
			Settings.Function(v)
		end
	end

	-- data
	local data = {Inform = Settings.Inform, Command = Settings.Command or {Name}, Type = "Text", Call = function(a)
		if a then
			update(a)
		else
			CommandBox(command.." ")
		end
	end}

	-- ui
	option,tab,i,data = NewOption(obj,Name,data)
	label = new("TextLabel",option)
	label.TextXAlignment = Enum.TextXAlignment.Right
	label.Size = UDim2.new(1,0,0,ui.SIZE_OPTION_Y)
	label.BackgroundTransparency = 1
	label.Text = text.." "

	-- finalize
	data.Index = i
	data.Parent = tab
	data.Instance = option
	table.insert(tab.Options, data)

	if not tab.CurrentOption then
		setOption(tab,i)
	end

	return {setText = update}
end

function NewAction(obj,Name:string,Settings:{Clipboard:string?,Link:string?,Display:string?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
	-- default
	Settings = Settings or {}
	if not CheckArguments({{Name,"string"}},{{Settings.Clipboard,"string"},{Settings.Link,"string"},{Settings.Display,"string"},{Settings.Function,"function"},{Settings.Inform,"string"},{Settings.Command,"table"}}) then return end
	local option,tab,i

	-- vars
	local icon
	local fun = function() end
	if Settings.Clipboard then
		fun = function()
			if Settings.Function then Settings.Function() end
			if clipboard then
				pcall(clipboard,Settings.Clipboard)
			else
				Notify("Could not copy the text. Text: "..Settings.Clipboard)
			end
		end
	elseif Settings.Link then
		fun = function()
			if Settings.Function then Settings.Function() end
			if openurl then
				pcall(openurl,Settings.Link)
			elseif clipboard then
				pcall(clipboard,Settings.Link)
				Notify("Couldn't find a method to open urls. Copied "..Settings.Link.." to clipboard.")
			else
				Notify("Couldn't open nor copy the link. Link: "..Settings.Link)
			end
		end
	elseif Settings.Function then
		fun = Settings.Function
	end

	-- data
	local data = {Inform = Settings.Inform, Command = Settings.Command, Type = "Action", Call = fun}

	-- ui
	option,tab,i,data = NewOption(obj,Name,data)
	if Settings.Link then
		icon = new("ImageLabel",option)
		icon.Size = UDim2.new(0,ui.SIZE_OPTION_Y,0,ui.SIZE_OPTION_Y)
		icon.Position = UDim2.new(1,-ui.SIZE_OPTION_Y,0,0)
		icon.BackgroundTransparency = 1
		ui.Icons.setImage(icon,"Link")
	elseif Settings.Display then
		icon = new("TextLabel",option)
		icon.TextXAlignment = Enum.TextXAlignment.Right
		icon.Position = UDim2.new(0,-4,0,0)
		icon.BackgroundTransparency = 1
		icon.Size = UDim2.new(1,0,1,0)
		icon.Text = Settings.Display
	end

	-- finalize
	data.Index = i
	data.Parent = tab
	data.Instance = option
	table.insert(tab.Options, data)

	if not tab.CurrentOption then
		setOption(tab,i)
	end

	return option,icon
end

function NewToggle(obj,Name:string,Settings:{Default:boolean?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
	-- default
	Settings = Settings or {}
	if not CheckArguments({{Name,"string"}},{{Settings.Default,"boolean"},{Settings.Function,"function"},{Settings.Inform,"string"},{Settings.Command,"table"}}) then return end
	local option,tab,i,icon

	-- vars
	local toggle = Settings.Default or false

	-- functions
	local function update()
		ui.Icons.setImage(icon,toggle and "Toggle On" or "Toggle Off") --Lucide.setImage(icon,toggle and "square-check" or "square")
	end

	-- data
	local data = {Inform = Settings.Inform, Command = Settings.Command, Type = "Toggle", Call = function(a)
		toggle = if a ~= nil then a else not toggle
		update()
		if Settings.Function then
			Settings.Function(toggle)
		end
	end}

	-- ui
	option,tab,i,data = NewOption(obj,Name,data)
	icon = new("ImageLabel",option)
	icon.Size = UDim2.new(0,ui.SIZE_OPTION_Y,0,ui.SIZE_OPTION_Y)
	icon.Position = UDim2.new(1,-ui.SIZE_OPTION_Y,0,0)
	icon.BackgroundTransparency = 1
	update()

	-- finalize
	data.Index = i
	data.Parent = tab
	data.Instance = option
	table.insert(tab.Options, data)

	if not tab.CurrentOption then
		setOption(tab,i)
	end
end

function NewValue(obj,Name:string,Min:number,Max:number,Settings:{Default:number?,Speed:number?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
	-- default
	Settings = Settings or {}
	if not CheckArguments({{Name,"string"},{Min,"number"},{Max,"number"}},{{Settings.Default,"number"},{Settings.Speed,"number"},{Settings.Function,"function"},{Settings.Inform,"string"},{Settings.Command,"table"}}) then return end
	local option,tab,i

	-- vars
	local v = Settings.Default or Min
	local speed = Settings.Speed
	local selected = false
	local val

	if not speed then
		local a = tostring(v):split(".")
		if #a>1 then
			speed = "0."
			if #a[2]-1 > 0 then
				for i = 1, #a[2]-1 do
					speed ..=0
				end
			end
			speed = tonumber(speed.."1")
		else
			speed = 1
		end
	end

	-- functions
	local function update(b)
		val.Text = selected and `< {v} >` or v
		if b and Settings.Function then Settings.Function(v) end
	end

	-- data
	local data = {Inform = Settings.Inform, Command = Settings.Command, Min = Min, Max = Max, Type = "Value", Call = function(a)
		if a then
			if a > Max then a = Max end -- trust the process
			if a < Min then a = Min end -- it's for command box calls
			v = a
		end
		update(true)
	end,
	_Unselect = function()
		selected = false
		update()
	end,
	_Select = function()
		selected = true
		update()
	end,
	Right = function()
		v+=speed
		if v > Max then v = Min end
		update(true)
	end,
	Left = function()
		v-=speed
		if v < Min then v = Max end
		update(true)
	end}

	-- ui
	option,tab,i,data = NewOption(obj,Name,data)
	val = new("TextLabel",option)
	val.TextXAlignment = Enum.TextXAlignment.Right
	val.Position = UDim2.new(0,-4,0,0)
	val.BackgroundTransparency = 1
	val.Size = UDim2.new(1,0,1,0)
	update()

	-- finalize
	data.Index = i
	data.Parent = tab
	data.Instance = option
	table.insert(tab.Options, data)

	if not tab.CurrentOption then
		setOption(tab,i)
	end

	return {
		setValue = function(a)
			v = a
			if v > Max then v = Max end
			if v < Min then v = Min end
			update()
		end,	
	} --return option,tab,i,data
end

function NewColor(obj,Name:string,Settings:{Id:string?,Default:Color3?,Function:((Color3)->())?,Inform:string?,Command:{Name:string,Info:string?}?}?)
	Settings = Settings or {}
	if not CheckArguments({{Name,"string"}},{{Settings.Id,"string"},{Settings.Default,"color3"},{Settings.Function,"function"},{Settings.Inform,"string"},{Settings.Command,"table"}}) then return end

	local command = Settings.Command and GetCommandName(Settings.Command[1]) or GetCommandName(Name)
	local c = Settings.Id and ui[Settings.Id] and ui[Settings.Id].Value or Settings.Default or Color3.new(0,0,0)
	local display,current
	local values = {}

	local function update(color)
		c = color
		if Settings.Id and ui[Settings.Id] then
			ui[Settings.Id].Value = color
		end
		for i,v in ipairs({"R","G","B"}) do
			if values[i] then values[i].SetValue(math.round(c[v]*255)) end
		end
		if display then
			display.Text = string.upper(c:ToHex())
		end
		sCall(Settings.Function,c)
	end

	local function fromHex(hex)
		hex = hex:gsub("^#","")
		if not hex:match("^%x%x%x%x%x%x$") then
			warn(Name..".SetHex.Hex is invalid: expected a hexadecimal color (RRGGBB), got "..tostring(hex)..".")
			return
		end
		update(Color3.fromHex(hex))
	end

	local cat = NewCategory(obj,Name.." Color")
	cat.NewSeparator("RGB Representation")
	for i,v in pairs({"Red","Green","Blue"}) do
		local component = ({"R","G","B"})[i]
		values[i] = cat.NewValue(v,0,255,{
			Default = math.round(c[component]*255),
			Command = {command..component},
			Function = function(value)
				local r,g,b = math.round(c.R*255),math.round(c.G*255),math.round(c.B*255)
				if i == 1 then r = value elseif i == 2 then g = value else b = value end
				update(Color3.fromRGB(r,g,b))
			end
		})
	end
	cat.NewSeparator("Other")
	cat.NewText("Enter Hex Color",{
		Inform = "Enter a six-digit hexadecimal color.",
		Command = {command,"Enter a six-digit hexadecimal color."},
		Function = function(v) if v then fromHex(v) end end
	})
	_,display = cat.NewAction("Current Color (Hex)",{Display = string.upper(c:ToHex()),Clipboard = string.upper(c:ToHex())})

	return {
		setColor = function(v)update(v)end,
		setHex = fromHex,
		getColor = function() return c end,
	}
end

function NewSelector(obj,Name:string,Data:{},Settings:{Default:string,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
	-- default
	Settings = Settings or {}
	if not CheckArguments({{Name,"string"},{Data,"table"}},{{Settings.Default,"string"},{Settings.Function,"function"},{Settings.Inform,"string"},{Settings.Command,"table"}}) then return end
	local option,tab,i,val

	-- vars
	local val,index
	local selected = false
	local v = Settings.Default or Data[1]
	for i2,v2 in pairs(Data) do
		if v2 == v then
			index = i2
			break
		end
	end
	if not tonumber(index) then
		print("yous a fakin dumbah")
		return
	end

	-- functions
	local function update(b)
		val.Text = selected and `< {v} > ` or v.." "
		if b and Settings.Function then Settings.Function(index,v) end
	end

	-- data
	local data = {Inform = Settings.Inform, Command = Settings.Command, Parent = tab, Type = "Selector", Index = i, Instance = option, Call = function()
		update(true)
	end,
	Right = function()
		index+=1
		if not Data[index] then index = 1 end
		v = Data[index]
		update(true)
	end,
	Left = function()
		index-=1
		if index == 0 then index = #Data end
		v = Data[index]
		update(true)
	end,
	_Unselect = function()
		selected = false
		update()
	end,
	_Select = function()
		selected = true
		update()
	end}

	-- ui
	option,tab,i,data = NewOption(obj,Name,data)
	val = new("TextLabel",option)
	val.TextXAlignment = Enum.TextXAlignment.Right
	val.BackgroundTransparency = 1
	val.Size = UDim2.new(1,0,1,0)
	update()

	-- finalize
	data.Index = i
	data.Parent = tab
	data.Instance = option
	table.insert(tab.Options, data)

	if not tab.CurrentOption then
		setOption(tab,i)
	end
end

function NewSeparator(obj,Name:string,Settings:{Alignment:EnumItem}?)
	-- default
	Settings = Settings or {}
	if not CheckArguments({{Name,"string"}},{{Settings.Alignment,"EnumItem"}}) then return end
	local option,tab,i

	-- data
	local data = {Inform = Settings.Inform, Command = Settings.Command, Type = "Separator", _Select = function()
		local c = tab.CurrentOption
		if c then
			local li = c.Index
			if li then -- if li exists, check if he is higher or lower to continue the movement
				local p = tab.Options[i+1] and i+1 or 1
				local m = tab.Options[i-1] and i-1 or #tab.Options
				if p == i and m == i then return false end -- no option to go to, pass

				-- in case li is at the bottom or top and a separator is on the opposite side
				if li == #tab.Options then li = 0 end
				if li == 1 then li = #tab.Options+1 end

				if li < i then -- li is above the separator
					setOption(tab,p)
					return true
				elseif li > i then -- li is below
					setOption(tab,m)
					return true
				end
			end

			-- if we can't find li, search for an option below or above.
			if tab.Options[i+1] then
				setOption(tab,i+1)
				return true
			elseif tab.Options[i-1] then
				setOption(tab,i-1)
				return true
			end

			print("brain not braining cuz no brain for",Name)
		end
	end}

	-- ui
	option,tab,i,data = NewOption(obj,Name,data)
	option.TextXAlignment = Settings.Alignment or Enum.TextXAlignment.Center
	option.Text = Name

	-- finalize
	data.Index = i
	data.Parent = tab
	data.Instance = option
	table.insert(tab.Options, data)

	if not tab.CurrentOption then
		setOption(tab,i)
	end

	return option
end

function NewKey(obj,Name:string,Id:string,Settings:{Key:EnumItem?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
	-- default
	Settings = Settings or {}
	if not CheckArguments({{Name,"string"},{Id,"string"}},{{Settings.Key,"EnumItem"},{Settings.Function,"function"},{Settings.Inform,"string"},{Settings.Command,"table"}}) then return end
	local option,tab,i,label

	-- vars
	local command = Settings.Command and GetCommandName(Settings.Command[1]) or GetCommandName(Name)
	ui.Keys[Id] = Settings.Key or ui.Keys[Id] or Enum.KeyCode.None

	-- functions
	local function update(v)
		local last = ui.Keys[Id]
		ui.Keys[Id] = Enum.KeyCode:FromName(v) or Enum.UserInputType:FromName(v) or ui.Keys[Id]
		if ui.Keys[Id] ~= last then
			label.Text = ui.Keys[Id].Name.." "
		end
	end

	table.insert(ui.KeyCalls,{Id = Id,Call = Settings.Function or function()end})

	-- data
	local data = {Inform = Settings.Inform, Command = Settings.Command or {Name}, Type = "Key", Call = function(a)
		if a then
			update(a)
		else
			CommandBox(command.." ")
		end
	end}

	-- ui
	option,tab,i,data = NewOption(obj,Name,data)
	label = new("TextLabel",option)
	label.TextXAlignment = Enum.TextXAlignment.Right
	label.Size = UDim2.new(1,0,0,ui.SIZE_OPTION_Y)
	label.BackgroundTransparency = 1
	label.Text = ui.Keys[Id].Name.." "

	-- finalize
	data.Index = i
	data.Parent = tab
	data.Instance = option
	table.insert(tab.Options, data)

	if not tab.CurrentOption then
		setOption(tab,i)
	end

	return {setKey = update}
end

function NewCategory(obj,Name:string)
	if not CheckArguments({{Name,"string"}}) then return end
	local option,tab,i = NewOption(obj,Name)
	local tabObj = tab.Tab or obj
	local catI = table.maxn(tabObj.Categories)+1

	local icon = new("ImageLabel",option)
	icon.Size = UDim2.new(0,ui.SIZE_OPTION_Y,0,ui.SIZE_OPTION_Y)
	icon.Position = UDim2.new(1,-ui.SIZE_OPTION_Y,0,0)
	icon.BackgroundTransparency = 1
	ui.Icons.setImage(icon,"List")

	local folder = new("Frame",tabObj.CategoriesContent)
	folder.BackgroundTransparency = 1
	folder.Size = UDim2.new(1,0,1,0)
	folder.Visible = false
	folder.Name = Name

	local content = new("ScrollingFrame",folder)
	content.BackgroundTransparency = 1
	content.Size = UDim2.new(1,0,1,0)
	content.Name = "Container"

	new("UIListLayout",content)

	local sbc = new("Frame",folder)
	setProperty(sbc,ui.TRANSPARENCY,"BackgroundTransparency")
	setProperty(sbc,ui.COLOR_BACKGROUND,"BackgroundColor3")
	sbc.Size = UDim2.new(0,ui.SIZE_SCROLLBAR_X,1,0)
	sbc.Position += UDim2.new(1,ui.SIZE_GAP,0,0)
	sbc.Name = "Scrollbar"
	sbc.Visible = false

	local sb = new("Frame",sbc)
	setProperty(sb,ui.TRANSPARENCY_THEME,"BackgroundTransparency")
	setProperty(sb,ui.COLOR_THEME,"BackgroundColor3")
	sb.Size = UDim2.new(1,0,0,0)
	sb.Name = "Bar"

	local data = {Tab = tabObj, Name = Name, Path = tab.Path.." > "..Name, Parent = tab, Type = "Category", Index = i, CategoryIndex = catI, ScrollBar = sb, Instance = option, Content = folder, Options = {}}
	table.insert(tabObj.Categories, data)

	data.Call = function()
		setCategory(tabObj,tabObj.Categories[catI])
		tabObj.DisplayPath = tabObj.Categories[catI].Path
		ui.Bar.Text = ui.Title..tabObj.DisplayPath
	end
	data.Back = function()
		setCategory(tabObj,tab)
		tabObj.DisplayPath = tab.Path
		ui.Bar.Text = ui.Title..tabObj.DisplayPath
	end

	table.insert(tab.Options, data)

	content.ChildAdded:Connect(function()
		if #data.Options > MAX_OPTIONS then
			data.ScrollBar.Parent.Visible = true
			data.ScrollBar.Size = UDim2.new(1,0,math.clamp(MAX_OPTIONS/#data.Options,0,1),0)
		else
			data.ScrollBar.Parent.Visible = false
		end
	end)

	if not tab.CurrentOption then
		setOption(tab,i)
	end

	return {
		NewCategory = function(Name:string)
			return NewCategory(tabObj.Categories[catI],Name)
		end,
		NewSeparator = function(Name:string,Settings:{}?)
			return NewSeparator(tabObj.Categories[catI],Name,Settings)
		end,
		NewSelector = function(Name:string,Data:{},Settings:{Default:string,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
			return NewSelector(tabObj.Categories[catI],Name,Data,Settings)
		end,
		NewAction = function(Name:string,Settings:{Clipboard:string?,Link:string?,Display:string?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
			return NewAction(tabObj.Categories[catI],Name,Settings)
		end,
		NewToggle = function(Name:string,Settings:{Default:boolean?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
			return NewToggle(tabObj.Categories[catI],Name,Settings)
		end,
		NewValue = function(Name:string,Min:number,Max:number,Settings:{Default:number?,Speed:number?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
			return NewValue(tabObj.Categories[catI],Name,Min,Max,Settings)
		end,
		NewColor = function(Name:string,Settings:{Default:Color3?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
			return NewColor(tabObj.Categories[catI],Name,Settings)
		end,
		NewKey = function(Name:string,Id:string,Settings:{Key:EnumItem?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?})
			return NewKey(tabObj.Categories[catI],Name,Id,Settings)
		end,
		NewText = function(Name:string,Settings:{Default:string?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
			return NewText(tabObj.Categories[catI],Name,Settings)
		end,
	}
end

function NewTab(Name:string)
	if not CheckArguments({{Name,"string"}}) then return end
	local index = table.maxn(ui.Tabs)+1

	local tab = new("TextLabel",ui.Main.Tabs)
	setProperty(tab,ui.TRANSPARENCY,"BackgroundTransparency")
	setProperty(tab,ui.COLOR_BACKGROUND,"BackgroundColor3")
	tab.Size = UDim2.new(1,0,0,ui.SIZE_OPTION_Y)
	setProperty(tab,ui.SIZE_TEXT_BIG,"TextSize")
	tab.TextTruncate = Enum.TextTruncate.AtEnd
	tab.Name = ui.Utils.toBase26(index)
	tab.Text = " "..Name

	local folder = new("Frame",ui.Main.Content)
	folder.BackgroundTransparency = 1
	folder.Size = UDim2.new(1,0,1,0)
	folder.Visible = false
	folder.Name = Name

	local categories = new("Frame",folder)
	categories.BackgroundTransparency = 1
	categories.Size = UDim2.new(1,0,1,0)
	categories.Name = "Categories"

	local content = new("Frame",folder)
	content.BackgroundTransparency = 1
	content.Size = UDim2.new(1,0,1,0)
	content.Name = "Content"

	local container = new("ScrollingFrame",content)
	container.BackgroundTransparency = 1
	container.Size = UDim2.new(1,0,1,0)
	container.Name = "Container"

	new("UIListLayout",container)

	local sbc = new("Frame",content)
	setProperty(sbc,ui.TRANSPARENCY,"BackgroundTransparency")
	setProperty(sbc,ui.COLOR_BACKGROUND,"BackgroundColor3")
	sbc.Size = UDim2.new(0,ui.SIZE_SCROLLBAR_X,1,0)
	sbc.Position += UDim2.new(1,ui.SIZE_GAP,0,0)
	sbc.Name = "Scrollbar"
	sbc.Visible = false

	local sb = new("Frame",sbc)
	setProperty(sb,ui.TRANSPARENCY_THEME,"BackgroundTransparency")
	setProperty(sb,ui.COLOR_THEME,"BackgroundColor3")
	sb.Size = UDim2.new(1,0,0,0)
	sb.Name = "Bar"

	local data = {Instance = tab, Folder = folder, Content = content, CategoriesContent = categories, CurrentContent = content, ScrollBar = sb, Index = index, Type = "Tab", Name = Name, Path = " > "..Name, Options = {}, Categories = {}}
	table.insert(ui.Tabs, data)

	container.ChildAdded:Connect(function()
		if #data.Options > MAX_OPTIONS then
			data.ScrollBar.Parent.Visible = true
			data.ScrollBar.Size = UDim2.new(1,0,math.clamp(MAX_OPTIONS/#data.Options,0,1),0)
		else
			data.ScrollBar.Parent.Visible = false
		end
	end)

	if not ui.CurrentTab then
		setTab(index)
	end

	return {
		NewSeparator = function(Name:string,Settings:{}?)
			return NewSeparator(ui.Tabs[index],Name,Settings)
		end,
		NewCategory = function(Name:string)
			return NewCategory(ui.Tabs[index],Name)
		end,
		NewSelector = function(Name:string,Data:{},Settings:{Default:string,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
			return NewSelector(ui.Tabs[index],Name,Data,Settings)
		end,
		NewAction = function(Name:string,Settings:{Clipboard:string?,Link:string?,Display:string?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
			return NewAction(ui.Tabs[index],Name,Settings)
		end,
		NewToggle = function(Name:string,Settings:{Default:boolean?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
			return NewToggle(ui.Tabs[index],Name,Settings)
		end,
		NewValue = function(Name:string,Min:number,Max:number,Settings:{Default:number?,Speed:number?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
			return NewValue(ui.Tabs[index],Name,Min,Max,Settings)
		end,
		NewColor = function(Name:string,Settings:{Default:Color3?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
			return NewColor(ui.Tabs[index],Name,Settings)
		end,
		NewKey = function(Name:string,Id:string,Settings:{Key:EnumItem?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?})
			return NewKey(ui.Tabs[index],Name,Id,Settings)
		end,
		NewText = function(Name:string,Settings:{Default:string?,Function:()->()?,Inform:string?,Command:{Name:string,Info:string?}?}?)
			return NewText(ui.Tabs[index],Name,Settings)
		end,
	}
end

ui.Gui = ui.Utils.getGui()
ui.Title = ` StandUI ({VERSION})`
ui.StandUI = VERSION

ui.Headers = {
	["Roblox Admin Tools"] = ui.Utils.toImage(require(script.Headers["Roblox Admin Tools"])), -- ui.Utils.toImage(loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Libraries/StandUI/Headers/RAT.lua"))()),
	["Stand Minimalist"] = ui.Utils.toImage(require(script.Headers["Stand Minimalist"])), -- ui.Utils.toImage(loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Libraries/StandUI/Headers/SM.lua"))()),
	["Stand Nature"] = ui.Utils.toImage(require(script.Headers["Stand Nature"])) -- ui.Utils.toImage(loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Libraries/StandUI/Headers/SN.lua"))()),
}

local folder = Instance.new("Folder",ui.Gui)
folder.Name = "Theme"

for i,v in pairs(ui) do
	if typeof(v) == "Color3" then
		local new = Instance.new("Color3Value",folder)
		new.Value = v
		ui[i] = new
	elseif i == "TRANSPARENCY" or i == "TRANSPARENCY_THEME" or i == "SIZE_TEXT_SMALL" or i == "SIZE_TEXT_MEDIUM" or i == "SIZE_TEXT_BIG" then --type(v) == "number"
		local new = Instance.new("NumberValue",folder)
		new.Value = v
		ui[i] = new
	end
end

ui.COLOR_THEME:GetPropertyChangedSignal("Value"):Connect(function()
	local c = ui.COLOR_THEME.Value
	ui.COLOR_TEXT.Value = math.clamp((c.R+c.G+c.B)/3,0,1) > .85 and Color3.new() or Color3.new(1,1,1)
end)

local main = new("Frame",ui.Gui)
main.Size = UDim2.new(0,ui.SIZE_BAR_X,0,ui.SIZE_BAR_Y+ui.SIZE_GAP+ui.SIZE_CONTENT_Y)
main.Position = UDim2.new(1,ui.POSITION_WINDOW_X,1,ui.POSITION_WINDOW_Y)
main.Transparency = 1

local bar = new("TextLabel",main)
setProperty(bar,ui.TRANSPARENCY_THEME,"BackgroundTransparency")
bar.Size = UDim2.new(0,ui.SIZE_BAR_X,0,ui.SIZE_BAR_Y)
setProperty(bar,ui.COLOR_THEME,"BackgroundColor3")
--bar.TextTruncate = Enum.TextTruncate.AtEnd
bar.ClipsDescendants = true
bar.TextWrapped = false
bar.Text = ui.Title
bar.Name = "Bar"

local truncate = new("TextBox",main)
truncate.Text = " ..."
truncate.Visible = false
truncate.Name = "Truncate"
--truncate.TextWrapped = false
setProperty(truncate,ui.COLOR_THEME,"BackgroundColor3")
truncate.Size = UDim2.new(0,truncate.TextBounds.X,0,ui.SIZE_BAR_Y)
setProperty(truncate,ui.TRANSPARENCY_THEME,"BackgroundTransparency")

connections.BarTruncate = bar:GetPropertyChangedSignal("Text"):Connect(function() -- this is really dirty but i'm tired so idc
	if bar.TextBounds.X > bar.Size.X.Offset then
		bar.Text ..= "      "
		truncate.Visible = true
		bar.TextXAlignment = Enum.TextXAlignment.Right
		bar.Size -= UDim2.new(0,truncate.TextBounds.X,0,0)
		bar.Position = UDim2.new(0,truncate.TextBounds.X,0,0)
	else
		bar.Size = UDim2.new(0,ui.SIZE_BAR_X,0,ui.SIZE_BAR_Y)
		bar.TextXAlignment = Enum.TextXAlignment.Left
		bar.Position = UDim2.new(0,0,0,0)
		truncate.Visible = false
	end
	wait()
end)

local header = new("ImageLabel",main)
header.Size = UDim2.new(0,ui.SIZE_BAR_X,0,-(ui.SIZE_BAR_X * 360 / 1020)) -- need to find a way to only convert certain variables from the table. -- Uh ?? Me no understand. -- Now I get it, I said that I wanted to make certain variables from ui values so they can, just like colors, be changed and dynamically updated for everything that uses it. I'm not doing that.
header.Position -= UDim2.new(0,0,0,ui.SIZE_GAP)
header.BackgroundTransparency = 1
header.Name = "Header"

local tabs = new("Frame",main)
tabs.Position += UDim2.new(0,0,0,ui.SIZE_BAR_Y+ui.SIZE_GAP)
tabs.Size = UDim2.new(0,ui.SIZE_TAB_X,0,ui.SIZE_CONTENT_Y)
tabs.BackgroundTransparency = 1
tabs.ClipsDescendants = false
tabs.Name = "Tabs"

new("UIListLayout",tabs).SortOrder = Enum.SortOrder.Name

local content = new("Frame",main)
content.Position += UDim2.new(0,ui.SIZE_TAB_X+ui.SIZE_GAP,0,ui.SIZE_BAR_Y+ui.SIZE_GAP)
content.Size = UDim2.new(0,ui.SIZE_CONTENT_X,0,ui.SIZE_CONTENT_Y)
content.BackgroundTransparency = 1
content.Name = "Content"

ui.Bar = bar
ui.Main = main
ui.Open = true
ui.BackingUpAtRoot = 0
ui.Connections = connections
block({ui.Keys.KEY_ENTER,ui.Keys.KEY_UP,ui.Keys.KEY_DOWN,ui.Keys.KEY_LEFT,ui.Keys.KEY_RIGHT,ui.Keys.KEY_TAB_UP,ui.Keys.KEY_TAB_DOWN,ui.Keys.KEY_TOGGLE})

local LEFT_DOWN = false
local RIGHT_DOWN = false

connections.InputBegan = UIS.InputBegan:Connect(function(i,gp)
	if ui.CommandBox then return end

	gp = gp or UIS:GetFocusedTextBox() and true or false
	local k = i.KeyCode.Name ~= "None" and i.KeyCode or i.UserInputType.Name ~= "None" and i.UserInputType

	for i,v in pairs(ui.KeyCalls) do
		if k == ui.Keys[v.Id] then sCall(v.Call,gp) end
	end

	if ui.Open then
		local cTab = ui.CurrentTab
		if cTab then
			if #ui.Tabs > 1 then
				local index = cTab.Index
				if k == ui.Keys.KEY_TAB_UP then
					index -= 1
					if index < 1 then
						index = #ui.Tabs
					end
				end
				if k == ui.Keys.KEY_TAB_DOWN then
					index += 1
					if index > #ui.Tabs then
						index = 1
					end
				end
				if index ~= cTab.Index then
					setTab(index)
				end
			end

			local cTab = cTab.CurrentCategory or cTab
			local cOption = cTab.CurrentOption
			if cOption then
				if #cTab.Options > 1 then
					local index = cOption.Index
					if k == ui.Keys.KEY_UP then
						index -= 1
						if index < 1 then
							index = #cTab.Options
							down(cTab,index)
						end
						up(cTab,index)
					end
					if k == ui.Keys.KEY_DOWN then
						index += 1
						if index > #cTab.Options then
							index = 1
							up(cTab,index)
						end
						down(cTab,index)
					end
					if index ~= cOption.Index then
						setOption(cTab,index,true) -- tells setOption that this call comes from a user interaction
					end
				end
				if k == ui.Keys.KEY_RIGHT then
					RIGHT_DOWN = true
					sCall(cOption.Right)
					local speed = .2
					task.spawn(function()
						while RIGHT_DOWN do
							wait(speed)
							if RIGHT_DOWN then
								sCall(cOption.Right)
								speed *= .9
							end
						end
					end)
				end
				if k == ui.Keys.KEY_LEFT then
					LEFT_DOWN = true
					sCall(cOption.Left)
					local speed = .2
					task.spawn(function()
						while LEFT_DOWN do
							wait(speed)
							if LEFT_DOWN then
								sCall(cOption.Left)
								speed *= .9
							end
						end
					end)
				end
				if k == ui.Keys.KEY_ENTER then
					sCall(cOption.Call)
				end
			end

			if k == ui.Keys.KEY_BACK then
				if cTab.Back then
					cTab.Back()
				else
					ui.Countdown = 0
					ui.BackingUpAtRoot += 1
					-- play sound beep sound here
					if ui.BackingUpAtRoot >= 3 and not ui.BackingUpAtRootInstance then
						task.spawn(function()
							ui.BackingUpAtRootInstance = GameNotify(`Use [{ui.Keys.KEY_TOGGLE.Name}] to close your Stand again.`)
							while ui.Countdown ~= 10 do
								ui.Countdown += 1
								task.wait(1)
							end
							ui.BackingUpAtRootInstance:Destroy()
							ui.BackingUpAtRoot = 0
							ui.Countdown = 0
						end)
					end
				end
			end
		end
	end

	if k == ui.Keys.KEY_TOGGLE then
		ui.Open = not ui.Open
		ui.Main.Visible = ui.Open
		if ui.Open then
			block({ui.Keys.KEY_ENTER,ui.Keys.KEY_UP,ui.Keys.KEY_DOWN,ui.Keys.KEY_LEFT,ui.Keys.KEY_RIGHT,ui.Keys.KEY_TAB_UP,ui.Keys.KEY_TAB_DOWN,ui.Keys.KEY_TOGGLE})
		else
			unblock()
		end
	end

	if k == ui.Keys.KEY_COMMAND_BOX then
		CommandBox()
	end
end)

connections.InputEnded = UIS.InputEnded:Connect(function(i)
	local k = i.KeyCode
	if k == ui.Keys.KEY_RIGHT then RIGHT_DOWN = false end
	if k == ui.Keys.KEY_LEFT then LEFT_DOWN = false end
end)

ui.NewTab = NewTab
ui.Notify = Notify
ui.Prompt = Prompt
ui.Inform = Inform
ui.GameNotify = GameNotify
ui.setName = function(v)
	ui.Title = " "..v
	local text = ui.Bar.Text
	local title = text:match("^(.-)>") or text
	title = text:gsub(title,"")
	ui.Bar.Text = " "..v.." "..title
end
ui.setHeader = function(v)
	local main = ui.Main
	local image = main.Header
	if v == "Be Gone" then
		image.Image = ""
	elseif ui.Headers[v] then
		ui.Icons.setImage(image,"Header Loading")
		image.Size = UDim2.new(0,main.Size.X.Offset,0,-(main.Size.X.Offset * ui.Headers[v].Y / ui.Headers[v].X))
		image.ImageRectOffset = Vector2.new(0,0)
		image.ImageRectSize = Vector2.new(0,0)
		image.ImageContent = ui.Headers[v].Image or ""
	else
		warn("Could not load header:",v..".")
	end
end
ui.load = function(v)

end
ui.unload = function()
	ui.Gui:Destroy()
	for i,v in pairs(connections) do
		if type(v) == "table" then
			for i,v in pairs(v) do
				v:Disconnect()
			end
		else
			v:Disconnect()
		end
	end
	commands = {}
	ui = {}
end

return ui
