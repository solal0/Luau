-- SST v1.3 - Subtitles for Roblox
-- Made by @CaptainSkira

-- Changelog:
-- v1.0 - Initial release
-- v1.1 - Added client only messages (client to client communication)
-- v1.2 - Added per channel Alphabet
-- v1.3 - Browsed channels will keep getting updated as messages are sent in them

-- I'll do the in game testing later
-- Edit my script however you want as long as you credit my github in your project.

local P = game:GetService("Players")

-- Generated with Codify
local gui = Instance.new("ScreenGui",P.LocalPlayer.PlayerGui)
gui.Name = "SubtleSubtitles"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local elements = Instance.new("Folder")
elements.Name = "Elements"
elements.Parent = gui

local message = Instance.new("TextBox")
message.Name = "Message"
message.Visible = false
message.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
message.Active = false
message.BorderSizePixel = 0
message.TextEditable = false
message.RichText = true
message.TextColor3 = Color3.new(1, 1, 1)
message.BorderColor3 = Color3.new()
message.Text = "[CaptainSkira]: I wish you the best"
message.TextWrapped = true
message.BackgroundTransparency = 1
message.TextXAlignment = Enum.TextXAlignment.Left
message.Size = UDim2.new(1, 0, 0, 16)
message.ClearTextOnFocus = false
message.TextSize = 14
message.BackgroundColor3 = Color3.new(1, 1, 1)
message.Parent = elements

local message_2 = Instance.new("TextBox")
message_2.Name = "Message"
message_2.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
message_2.Active = false
message_2.BorderSizePixel = 0
message_2.TextEditable = false
message_2.RichText = true
message_2.TextColor3 = Color3.new(1, 1, 1)
message_2.BorderColor3 = Color3.new()
message_2.Text = "[CaptainSkira]: I wish you the best"
message_2.TextWrapped = true
message_2.Size = UDim2.new(1, 0, 1, 0)
message_2.BackgroundTransparency = 1
message_2.TextXAlignment = Enum.TextXAlignment.Left
message_2.Selectable = false
message_2.ClearTextOnFocus = false
message_2.TextSize = 14
message_2.BackgroundColor3 = Color3.new(1, 1, 1)
message_2.Parent = message

local uIStroke = Instance.new("UIStroke")
uIStroke.Name = "UIStroke"
uIStroke.Color = Color3.new(0.196, 0.196, 0.196)
uIStroke.Transparency = 1
uIStroke.Parent = message

local user = Instance.new("TextLabel")
user.Name = "User"
user.Visible = false
user.TextWrapped = true
user.TextColor3 = Color3.new(1, 1, 1)
user.BorderColor3 = Color3.new()
user.Text = "CaptainSkira"
user.BackgroundColor3 = Color3.new(1, 1, 1)
user.BorderSizePixel = 0
user.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
user.BackgroundTransparency = 1
user.TextXAlignment = Enum.TextXAlignment.Left
user.RichText = true
user.TextSize = 14
user.Size = UDim2.new(1, 0, 0, 16)
user.Parent = elements

local interact = Instance.new("TextButton")
interact.Name = "Interact"
interact.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
interact.TextColor3 = Color3.new(1, 1, 1)
interact.BorderColor3 = Color3.new()
interact.Text = "mute"
interact.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
interact.BorderSizePixel = 0
interact.BackgroundTransparency = 0.5
interact.Position = UDim2.new(1, -30, 0, 2)
interact.TextWrapped = true
interact.TextSize = 12
interact.Size = UDim2.new(0, 28, 0, 12)
interact.Parent = user

local header = Instance.new("TextLabel")
header.Name = "Header"
header.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
header.TextColor3 = Color3.new(1, 1, 1)
header.BorderColor3 = Color3.new()
header.Text = " Subtle Subtitles"
header.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
header.BorderSizePixel = 0
header.BackgroundTransparency = 0.5
header.TextXAlignment = Enum.TextXAlignment.Left
header.Position = UDim2.new(0, 20, 1, -193)
header.TextSize = 14
header.Size = UDim2.new(0, 259, 0, 20)
header.Parent = gui

local settingsGui = Instance.new("TextLabel")
settingsGui.Name = "Settings"
settingsGui.Visible = false
settingsGui.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
settingsGui.TextColor3 = Color3.new(1, 1, 1)
settingsGui.BorderColor3 = Color3.new()
settingsGui.Text = " Settings"
settingsGui.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
settingsGui.BorderSizePixel = 0
settingsGui.BackgroundTransparency = 0.5
settingsGui.TextXAlignment = Enum.TextXAlignment.Left
settingsGui.Position = UDim2.new(0, 302, 0, 0)
settingsGui.TextSize = 14
settingsGui.Size = UDim2.new(0, 201, 0, 20)
settingsGui.Parent = header

local fix = Instance.new("Frame")
fix.Name = "Fix"
fix.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
fix.BackgroundTransparency = 0.5
fix.Position = UDim2.new(0, 0, 0, 21)
fix.BorderColor3 = Color3.new()
fix.BorderSizePixel = 0
fix.Size = UDim2.new(0, 4, 0, 150)
fix.Parent = settingsGui

local close = Instance.new("ImageButton")
close.Name = "Close"
close.Visible = false
close.ImageTransparency = 0.5
close.BorderColor3 = Color3.new()
close.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
close.Image = "rbxassetid://93943101117275"
close.BackgroundTransparency = 1
close.Position = UDim2.new(1, 1, 0, 0)
close.ImageColor3 = Color3.new(0.392, 0.392, 0.392)
close.BorderSizePixel = 0
close.Size = UDim2.new(0, 20, 0, 20)
close.Parent = settingsGui

local credits = Instance.new("TextLabel")
credits.Name = "Credits"
credits.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
credits.TextColor3 = Color3.new(1, 1, 1)
credits.BorderColor3 = Color3.new()
credits.Text = " v1.3 by @CaptainSkira / github.com/solal0 "
credits.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
credits.BorderSizePixel = 0
credits.BackgroundTransparency = 0.5
credits.TextXAlignment = Enum.TextXAlignment.Right
credits.Position = UDim2.new(0, 0, 0, 172)
credits.TextSize = 10
credits.Size = UDim2.new(1, 0, 0, 14)
credits.Parent = settingsGui

local settingsContent = Instance.new("ScrollingFrame")
settingsContent.Name = "Content"
settingsContent.ScrollBarThickness = 0
settingsContent.CanvasSize = UDim2.new(0, 0, 0, 180)
settingsContent.Selectable = false
settingsContent.BackgroundTransparency = 0.5
settingsContent.Position = UDim2.new(0, 4, 0, 21)
settingsContent.BorderColor3 = Color3.new()
settingsContent.Size = UDim2.new(0, 197, 0, 150)
settingsContent.BorderSizePixel = 0
settingsContent.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
settingsContent.Parent = settingsGui

local uIListLayout_2 = Instance.new("UIListLayout")
uIListLayout_2.Name = "UIListLayout"
uIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
uIListLayout_2.Parent = settingsContent

local notificationSetting = Instance.new("TextLabel")
notificationSetting.Name = "Notification"
notificationSetting.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
notificationSetting.TextColor3 = Color3.new(1, 1, 1)
notificationSetting.Text = "Notification Indicator"
notificationSetting.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
notificationSetting.BackgroundTransparency = 1
notificationSetting.TextXAlignment = Enum.TextXAlignment.Left
notificationSetting.BorderSizePixel = 0
notificationSetting.BorderColor3 = Color3.new()
notificationSetting.TextSize = 14
notificationSetting.Size = UDim2.new(1, 0, 0, 20)
notificationSetting.Parent = settingsContent

local interact_3 = Instance.new("TextButton")
interact_3.Name = "Interact"
interact_3.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
interact_3.TextColor3 = Color3.new(1, 1, 1)
interact_3.BorderColor3 = Color3.new()
interact_3.Text = "✓"
interact_3.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
interact_3.BorderSizePixel = 0
interact_3.BackgroundTransparency = 0.5
interact_3.Position = UDim2.new(1, -18, 0, 2)
interact_3.TextWrapped = true
interact_3.TextScaled = true
interact_3.Size = UDim2.new(0, 16, 0, 16)
interact_3.Parent = notificationSetting

local fullMuteSetting = Instance.new("TextButton")
fullMuteSetting.Name = "Mute"
fullMuteSetting.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
fullMuteSetting.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
fullMuteSetting.Active = false
fullMuteSetting.BorderColor3 = Color3.new()
fullMuteSetting.Text = "Full Mute (click to show info)"
fullMuteSetting.BorderSizePixel = 0
fullMuteSetting.AutoButtonColor = false
fullMuteSetting.TextColor3 = Color3.new(1, 1, 1)
fullMuteSetting.Selectable = false
fullMuteSetting.BackgroundTransparency = 1
fullMuteSetting.TextXAlignment = Enum.TextXAlignment.Left
fullMuteSetting.Position = UDim2.new(0, 0, 0, 21)
fullMuteSetting.TextSize = 14
fullMuteSetting.Size = UDim2.new(1, 0, 0, 20)
fullMuteSetting.Parent = settingsContent

local infoLabel = Instance.new("TextLabel")
infoLabel.Name = "InfoLabel"
infoLabel.Visible = false
infoLabel.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.BorderColor3 = Color3.new()
infoLabel.Text = "If checked, muted player's messages won't appear at all instead of showing up as dots"
infoLabel.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
infoLabel.BorderSizePixel = 0
infoLabel.BackgroundTransparency = 0.5
infoLabel.Position = UDim2.new(1, 1, 0, 0)
infoLabel.TextWrapped = true
infoLabel.TextSize = 14
infoLabel.Size = UDim2.new(0, 140, 0, 70)
infoLabel.Parent = fullMuteSetting

local interact_2 = Instance.new("TextButton")
interact_2.Name = "Interact"
interact_2.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
interact_2.TextColor3 = Color3.new(1, 1, 1)
interact_2.BorderColor3 = Color3.new()
interact_2.Text = ""
interact_2.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
interact_2.BorderSizePixel = 0
interact_2.BackgroundTransparency = 0.5
interact_2.Position = UDim2.new(1, -18, 0, 2)
interact_2.TextWrapped = true
interact_2.TextScaled = true
interact_2.Size = UDim2.new(0, 16, 0, 16)
interact_2.Parent = fullMuteSetting

local mutedscrollingframe = Instance.new("ScrollingFrame")
mutedscrollingframe.Name = "Muted"
mutedscrollingframe.ScrollBarThickness = 0
mutedscrollingframe.CanvasSize = UDim2.new()
mutedscrollingframe.Selectable = false
mutedscrollingframe.BackgroundTransparency = 1
mutedscrollingframe.Position = UDim2.new(0, 5, 0, 42)
mutedscrollingframe.BorderColor3 = Color3.new()
mutedscrollingframe.Size = UDim2.new(1, 0, 0, 100)
mutedscrollingframe.BorderSizePixel = 0
mutedscrollingframe.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
mutedscrollingframe.Parent = settingsContent

local uIListLayout = Instance.new("UIListLayout")
uIListLayout.Name = "UIListLayout"
uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uIListLayout.Parent = mutedscrollingframe

local letLooseSetting = Instance.new("TextLabel")
letLooseSetting.Name = "LetLoose"
letLooseSetting.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
letLooseSetting.TextColor3 = Color3.new(1, 1, 1)
letLooseSetting.Text = "Listen to close enough calls"
letLooseSetting.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
letLooseSetting.BackgroundTransparency = 1
letLooseSetting.TextXAlignment = Enum.TextXAlignment.Left
letLooseSetting.BorderSizePixel = 0
letLooseSetting.BorderColor3 = Color3.new()
letLooseSetting.TextSize = 14
letLooseSetting.Size = UDim2.new(1, 0, 0, 20)
letLooseSetting.Parent = settingsContent

local interact_4 = Instance.new("TextButton")
interact_4.Name = "Interact"
interact_4.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
interact_4.TextColor3 = Color3.new(1, 1, 1)
interact_4.BorderColor3 = Color3.new()
interact_4.Text = ""
interact_4.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
interact_4.BorderSizePixel = 0
interact_4.BackgroundTransparency = 0.5
interact_4.Position = UDim2.new(1, -18, 0, 2)
interact_4.TextWrapped = true
interact_4.TextScaled = true
interact_4.Size = UDim2.new(0, 16, 0, 16)
interact_4.Parent = letLooseSetting

local channelSeedSetting = Instance.new("TextLabel")
channelSeedSetting.Name = "ChannelSeed"
channelSeedSetting.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
channelSeedSetting.TextColor3 = Color3.new(1, 1, 1)
channelSeedSetting.Text = "Channel Seed"
channelSeedSetting.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
channelSeedSetting.BackgroundTransparency = 1
channelSeedSetting.TextXAlignment = Enum.TextXAlignment.Left
channelSeedSetting.BorderSizePixel = 0
channelSeedSetting.BorderColor3 = Color3.new()
channelSeedSetting.TextSize = 14
channelSeedSetting.Size = UDim2.new(1, 0, 0, 20)
channelSeedSetting.Parent = settingsContent

local channelSeed = Instance.new("TextBox")
channelSeed.Name = "TextBox"
channelSeed.TextWrapped = true
channelSeed.PlaceholderColor3 = Color3.new(0.608, 0.608, 0.608)
channelSeed.PlaceholderText = "123..."
channelSeed.BorderSizePixel = 0
channelSeed.Size = UDim2.new(0, 97, 0, 16)
channelSeed.TextColor3 = Color3.new(1, 1, 1)
channelSeed.BorderColor3 = Color3.new()
channelSeed.Text = ""
channelSeed.TextSize = 14
channelSeed.Position = UDim2.new(1, -99, 0, 2)
channelSeed.BackgroundTransparency = 0.5
channelSeed.TextXAlignment = Enum.TextXAlignment.Left
channelSeed.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
channelSeed.ClearTextOnFocus = false
channelSeed.TextScaled = true
channelSeed.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
channelSeed.Parent = channelSeedSetting

local fix_2 = Instance.new("Frame")
fix_2.Name = "Fix"
fix_2.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
fix_2.BackgroundTransparency = 0.5
fix_2.Position = UDim2.new(0, -4, 0, 0)
fix_2.BorderColor3 = Color3.new()
fix_2.BorderSizePixel = 0
fix_2.Size = UDim2.new(0, 4, 1, 0)
fix_2.Parent = channelSeed

local circle = Instance.new("ImageLabel")
circle.Name = "Circle"
circle.Visible = false
circle.Active = true
circle.BorderColor3 = Color3.new()
circle.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
circle.Selectable = true
circle.ImageTransparency = 0.5
circle.Image = "rbxassetid://127552109929760"
circle.BackgroundTransparency = 1
circle.Position = UDim2.new(1, 1, 0, 0)
circle.ImageColor3 = Color3.new(0.392, 0.392, 0.392)
circle.ZIndex = 0
circle.BorderSizePixel = 0
circle.Size = UDim2.new(0, 20, 0, 20)
circle.Parent = settingsContent

local interactButton = Instance.new("ImageButton")
interactButton.Name = "InteractB"
interactButton.ImageColor3 = Color3.new(0.392, 0.392, 0.392)
interactButton.ImageTransparency = 0.5
interactButton.BorderColor3 = Color3.new()
interactButton.Image = "rbxassetid://125011932198898"
interactButton.BackgroundTransparency = 1
interactButton.Position = UDim2.new(0, 281, 0, 0)
interactButton.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
interactButton.BorderSizePixel = 0
interactButton.Size = UDim2.new(0, 20, 0, 20)
interactButton.Parent = header

local notification = Instance.new("TextLabel")
notification.Name = "Notification"
notification.Visible = false
notification.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
notification.TextColor3 = Color3.new(1, 1, 1)
notification.BorderColor3 = Color3.new()
notification.Text = ""
notification.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
notification.BackgroundTransparency = 0.5
notification.Position = UDim2.new(0, -8, 0, -8)
notification.BorderSizePixel = 0
notification.TextSize = 12
notification.Size = UDim2.new(0, 16, 0, 16)
notification.Parent = header

local uICorner = Instance.new("UICorner")
uICorner.Name = "UICorner"
uICorner.CornerRadius = UDim.new(1, 0)
uICorner.Parent = notification

local settingsCircle = Instance.new("ImageLabel")
settingsCircle.Name = "SettingsCircle"
settingsCircle.ImageColor3 = Color3.new(0.392, 0.392, 0.392)
settingsCircle.Active = true
settingsCircle.BorderColor3 = Color3.new()
settingsCircle.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
settingsCircle.Selectable = true
settingsCircle.Image = "rbxassetid://127552109929760"
settingsCircle.BackgroundTransparency = 1
settingsCircle.Position = UDim2.new(0, 260, 0, 0)
settingsCircle.ImageTransparency = 0.5
settingsCircle.ZIndex = 0
settingsCircle.BorderSizePixel = 0
settingsCircle.Size = UDim2.new(0, 20, 0, 20)
settingsCircle.Parent = header

local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.ScrollBarThickness = 0
content.CanvasSize = UDim2.new()
content.Selectable = false
content.BackgroundTransparency = 0.5
content.Position = UDim2.new(0, 4, 0, 21)
content.BorderColor3 = Color3.new()
content.Size = UDim2.new(0, 297, 0, 150)
content.BorderSizePixel = 0
content.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
content.Parent = header

local list = Instance.new("UIListLayout")
list.Name = "UIListLayout"
list.Parent = content

local settingsButton = Instance.new("ImageButton")
settingsButton.Name = "SettingsB"
settingsButton.ImageColor3 = Color3.new(0.392, 0.392, 0.392)
settingsButton.ImageTransparency = 0.5
settingsButton.BorderColor3 = Color3.new()
settingsButton.Image = "rbxassetid://128359940634831"
settingsButton.BackgroundTransparency = 1
settingsButton.Position = UDim2.new(0, 260, 0, 0)
settingsButton.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
settingsButton.BorderSizePixel = 0
settingsButton.Size = UDim2.new(0, 20, 0, 20)
settingsButton.Parent = header

local fix_3 = Instance.new("Frame")
fix_3.Name = "Fix"
fix_3.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
fix_3.BackgroundTransparency = 0.5
fix_3.Position = UDim2.new(0, 0, 0, 21)
fix_3.BorderColor3 = Color3.new()
fix_3.BorderSizePixel = 0
fix_3.Size = UDim2.new(0, 4, 0, 150)
fix_3.Parent = header

local interactCircle = Instance.new("ImageLabel")
interactCircle.Name = "InteractCircle"
interactCircle.ImageColor3 = Color3.new(0.392, 0.392, 0.392)
interactCircle.Active = true
interactCircle.BorderColor3 = Color3.new()
interactCircle.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
interactCircle.Selectable = true
interactCircle.Image = "rbxassetid://127552109929760"
interactCircle.BackgroundTransparency = 1
interactCircle.Position = UDim2.new(0, 281, 0, 0)
interactCircle.ImageTransparency = 0.5
interactCircle.ZIndex = 0
interactCircle.BorderSizePixel = 0
interactCircle.Size = UDim2.new(0, 20, 0, 20)
interactCircle.Parent = header

local chatbox = Instance.new("TextBox")
chatbox.Name = "ChatBox"
chatbox.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
chatbox.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
chatbox.TextColor3 = Color3.new(1, 1, 1)
chatbox.Text = ""
chatbox.BorderSizePixel = 0
chatbox.ClearTextOnFocus = false
chatbox.BorderColor3 = Color3.new()
chatbox.PlaceholderColor3 = Color3.new(0.608, 0.608, 0.608)
chatbox.BackgroundTransparency = 0.5
chatbox.TextXAlignment = Enum.TextXAlignment.Left
chatbox.Position = UDim2.new(0, 4, 0, 172)
chatbox.PlaceholderText = "Say something nice..."
chatbox.TextSize = 14
chatbox.Size = UDim2.new(0, 246, 0, 20)
chatbox.Parent = header

local fix_4 = Instance.new("Frame")
fix_4.Name = "Fix"
fix_4.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
fix_4.BackgroundTransparency = 0.5
fix_4.Position = UDim2.new(0, -4, 0, 0)
fix_4.BorderColor3 = Color3.new()
fix_4.BorderSizePixel = 0
fix_4.Size = UDim2.new(0, 4, 0, 20)
fix_4.Parent = chatbox

local send = Instance.new("TextButton")
send.Name = "Send"
send.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json")
send.TextColor3 = Color3.new(1, 1, 1)
send.Text = "Send"
send.BackgroundColor3 = Color3.new(0.392, 0.392, 0.392)
send.BackgroundTransparency = 0.5
send.Position = UDim2.new(1, 1, 0, 0)
send.BorderSizePixel = 0
send.BorderColor3 = Color3.new()
send.TextSize = 14
send.Size = UDim2.new(0, 50, 0, 20)
send.Parent = chatbox

local notificationsEnabled = true
local newNotifications = 0
local settingsOpen = false
local fullMute = false
local open = true
local muted = {}

-- // Settings // --
local nameUseTeamColor = true -- if player's name should be it's team color
local teamUseTeamColor = true -- if player's team name should be it's team color
local settingsExist = true -- wether or not settings should be available
local keyToFocus = Enum.KeyCode.Slash -- if pressed, ui will force open and chatbox will be focused. Set to Enum.KeyCode.None to disable
local useBubbles = true -- if a chat bubble should show up above player's head (only works if useCustomChat is true)
local showTeam = true -- if player has a team it will add [teamName] before their username
local maxChars = 500 -- max characters allowed in chatbox

-- v1.1
local alphabet = {
	[" "]="000",

	["a"]="001",["b"]="002",["c"]="003",["d"]="004",["e"]="005",["f"]="006",
	["g"]="007",["h"]="008",["i"]="009",["j"]="010",["k"]="011",["l"]="012",
	["m"]="013",["n"]="014",["o"]="015",["p"]="016",["q"]="017",["r"]="018",
	["s"]="019",["t"]="020",["u"]="021",["v"]="022",["w"]="023",["x"]="024",
	["y"]="025",["z"]="026",["A"]="027",["B"]="028",["C"]="029",["D"]="030",
	["E"]="031",["F"]="032",["G"]="033",["H"]="034",["I"]="035",["J"]="036",
	["K"]="037",["L"]="038",["M"]="039",["N"]="040",["O"]="041",["P"]="042",
	["Q"]="043",["R"]="044",["S"]="045",["T"]="046",["U"]="047",["V"]="048",
	["W"]="049",["X"]="050",["Y"]="051",["Z"]="052",

	-- Latin Extended
	["À"]="053",["Á"]="054",["Â"]="055",["Ã"]="056",["Ä"]="057",["Å"]="058",["Æ"]="059",["Ç"]="060",
	["È"]="061",["É"]="062",["Ê"]="063",["Ë"]="064",["Ì"]="065",["Í"]="066",["Î"]="067",["Ï"]="068",
	["Ð"]="069",["Ñ"]="070",["Ò"]="071",["Ó"]="072",["Ô"]="073",["Õ"]="074",["Ö"]="075",["Ø"]="076",
	["Ù"]="077",["Ú"]="078",["Û"]="079",["Ü"]="080",["Ý"]="081",["Þ"]="082",["ß"]="083",["à"]="084",
	["á"]="085",["â"]="086",["ã"]="087",["ä"]="088",["å"]="089",["æ"]="090",["ç"]="091",["è"]="092",
	["é"]="093",["ê"]="094",["ë"]="095",["ì"]="096",["í"]="097",["î"]="098",["ï"]="099",["ð"]="100",
	["ñ"]="101",["ò"]="102",["ó"]="103",["ô"]="104",["õ"]="105",["ö"]="106",["ø"]="107",["ù"]="108",
	["ú"]="109",["û"]="110",["ü"]="111",["ý"]="112",["þ"]="113",["ÿ"]="114",

	-- Cyrillic
	["А"]="115",["Б"]="116",["В"]="117",["Г"]="118",["Д"]="119",["Е"]="120",["Ё"]="121",["Ж"]="122",
	["З"]="123",["И"]="124",["Й"]="125",["К"]="126",["Л"]="127",["М"]="128",["Н"]="129",["О"]="130",
	["П"]="131",["Р"]="132",["С"]="133",["Т"]="134",["У"]="135",["Ф"]="136",["Х"]="137",["Ц"]="138",
	["Ч"]="139",["Ш"]="140",["Щ"]="141",["Ъ"]="142",["Ы"]="143",["Ь"]="144",["Э"]="145",["Ю"]="146",
	["Я"]="147",["а"]="148",["б"]="149",["в"]="150",["г"]="151",["д"]="152",["е"]="153",["ё"]="154",
	["ж"]="155",["з"]="156",["и"]="157",["й"]="158",["к"]="159",["л"]="160",["м"]="161",["н"]="162",
	["о"]="163",["п"]="164",["р"]="165",["с"]="166",["т"]="167",["у"]="168",["ф"]="169",["х"]="170",
	["ц"]="171",["ч"]="172",["ш"]="173",["щ"]="174",["ъ"]="175",["ы"]="176",["ь"]="177",["э"]="178",
	["ю"]="179",["я"]="180",

	-- Greek
	["Α"]="181",["Β"]="182",["Γ"]="183",["Δ"]="184",["Ε"]="185",["Ζ"]="186",["Η"]="187",["Θ"]="188",
	["Ι"]="189",["Κ"]="190",["Λ"]="191",["Μ"]="192",["Ν"]="193",["Ξ"]="194",["Ο"]="195",["Π"]="196",
	["Ρ"]="197",["Σ"]="198",["Τ"]="199",["Υ"]="200",["Φ"]="201",["Χ"]="202",["Ψ"]="203",["Ω"]="204",
	["α"]="205",["β"]="206",["γ"]="207",["δ"]="208",["ε"]="209",["ζ"]="210",["η"]="211",["θ"]="212",
	["ι"]="213",["κ"]="214",["λ"]="215",["μ"]="216",["ν"]="217",["ξ"]="218",["ο"]="219",["π"]="220",
	["ρ"]="221",["σ"]="222",["ς"]="223",["τ"]="224",["υ"]="225",["φ"]="226",["χ"]="227",["ψ"]="228",
	["ω"]="229",

	["Ā"]="230",["Ă"]="231",["Ą"]="232",["Ć"]="233",["Ĉ"]="234",["Ċ"]="235",["Č"]="236",["Ď"]="237",
	["Đ"]="238",["Ē"]="239",["Ĕ"]="240",["Ė"]="241",["Ę"]="242",["Ě"]="243",["Ĝ"]="244",["Ğ"]="245",
	["Ġ"]="246",["Ģ"]="247",["Ĥ"]="248",["Ħ"]="249",["Ĩ"]="250",["Ī"]="251",["Ĭ"]="252",["Į"]="253",
	["İ"]="254",["Ĵ"]="255",["Ķ"]="256",["Ĺ"]="257",["Ļ"]="258",["Ľ"]="259",["Ŀ"]="260",["Ł"]="261",
	["Ń"]="262",["Ņ"]="263",["Ň"]="264",["Ŋ"]="265",["Ō"]="266",["Ŏ"]="267",["Ő"]="268",["Ŕ"]="269",
	["Ŗ"]="270",["Ř"]="271",["Ś"]="272",["Ŝ"]="273",["Ş"]="274",["Š"]="275",["Ţ"]="276",["Ť"]="277",
	["Ŧ"]="278",["Ũ"]="279",["Ū"]="280",["Ŭ"]="281",["Ů"]="282",["Ű"]="283",["Ų"]="284",["Ŵ"]="285",
	["Ŷ"]="286",["Ÿ"]="287",["Ź"]="288",["Ż"]="289",["Ž"]="290",

	["ā"]="291",["ă"]="292",["ą"]="293",["ć"]="294",["ĉ"]="295",["ċ"]="296",["č"]="297",["ď"]="298",
	["đ"]="299",["ē"]="300",["ĕ"]="301",["ė"]="302",["ę"]="303",["ě"]="304",["ĝ"]="305",["ğ"]="306",
	["ġ"]="307",["ģ"]="308",["ĥ"]="309",["ħ"]="310",["ĩ"]="311",["ī"]="312",["ĭ"]="313",["į"]="314",
	["ĵ"]="315",["ķ"]="316",["ĺ"]="317",["ļ"]="318",["ľ"]="319",["ŀ"]="320",["ł"]="321",["ń"]="322",
	["ņ"]="323",["ň"]="324",["ŋ"]="325",["ō"]="326",["ŏ"]="327",["ő"]="328",["ŕ"]="329",["ŗ"]="330",
	["ř"]="331",["ś"]="332",["ŝ"]="333",["ş"]="334",["š"]="335",["ţ"]="336",["ť"]="337",["ŧ"]="338",
	["ũ"]="339",["ū"]="340",["ŭ"]="341",["ů"]="342",["ű"]="343",["ų"]="344",["ŵ"]="345",["ŷ"]="346",
	["ƶ"]="347",["ź"]="348",["ż"]="349",["ž"]="350",

	["Ə"]="351",["Ɓ"]="352",["Ƃ"]="353",["Ɔ"]="354",["Ƈ"]="355",["Ɖ"]="356",["Ɗ"]="357",["Ƌ"]="358",
	["Ǝ"]="359",["Ɛ"]="360",["Ƒ"]="361",["Ɠ"]="362",["Ƙ"]="363",["Ɯ"]="364",["Ɲ"]="365",["Ƥ"]="366",
	["Ʀ"]="367",["Ƨ"]="368",["Ƭ"]="369",["Ʈ"]="370",["Ʋ"]="371",["Ƶ"]="372",["Ǆ"]="373",["ǅ"]="374",
	["ǆ"]="375",["Ǉ"]="376",["ǈ"]="377",["ǉ"]="378",["Ǌ"]="379",["ǋ"]="380",["Ǎ"]="381",["ǎ"]="382",
	["Ǐ"]="383",["ǐ"]="384",["Ǒ"]="385",["ǒ"]="386",["Ǔ"]="387",["ǔ"]="388",["Ǖ"]="389",["ǖ"]="390",
	["Ǘ"]="391",["ǘ"]="392",["Ǚ"]="393",["ǚ"]="394",["Ǜ"]="395",["ǜ"]="396",["Ǟ"]="397",["ǟ"]="398",
	["Ǡ"]="399",["ǡ"]="400",["Ǣ"]="401",["ǣ"]="402",["Ǥ"]="403",["ǥ"]="404",["Ǧ"]="405",["ǧ"]="406",
	["Ǩ"]="407",["ǩ"]="408",["Ǫ"]="409",["ǫ"]="410",["Ǭ"]="411",["ǭ"]="412",["Ǯ"]="413",["ǯ"]="414",

	-- TEXT / SYMBOLS
	["!"]="415",["\""]="416",["#"]="417",["$"]="418",["%"]="419",["&"]="420",["'"]="421",["("]="422",
	[")"]="423",["*"]="424",["+"]="425",[","]="426",["-"]="427",["."]="428",["/"]="429",[":"]="430",
	[";"]="431",["<"]="432",["="]="433",[">"]="434",["?"]="435",["@"]="436",["["]="437",["\\"]="438",
	["]"]="439",["^"]="440",["_"]="441",["`"]="442",["{"]="443",["|"]="444",["}"]="445",["~"]="446",
	["€"]="447",["£"]="448",["¥"]="449",["₹"]="450",["©"]="451",["®"]="452",["™"]="453",["°"]="454",
	["•"]="455",["…"]="456",["±"]="457",["×"]="458",["÷"]="459",["«"]="460",["»"]="461",["‹"]="462",
	["›"]="463",["“"]="464",["”"]="465",["‘"]="466",["’"]="467",["–"]="468",["—"]="469",["0"]="470",
	["1"]="471",["2"]="472",["3"]="473",["4"]="474",["5"]="475",["6"]="476",["7"]="477",["8"]="478",
	["9"]="479",

	["♥"]="480",["♦"]="481",["♣"]="482",["♠"]="483",["★"]="484",["☆"]="485",["♪"]="486",["♫"]="487",
	["✓"]="488",["✔"]="489",["✕"]="490",["✖"]="491",["▲"]="492",["▼"]="493",["◆"]="494",["◇"]="495",
	["◀"]="496",["▶"]="497",["⚠"]="498",["⚡"]="499",["☀"]="500",["☁"]="501",["☂"]="502",["☎"]="503",
	["☑"]="504",["☒"]="505",["☕"]="506",["☘"]="507",["☠"]="508",["☮"]="509",["☯"]="510",["☹"]="511",
	["☺"]="512",["☻"]="513",["♀"]="514",["♂"]="515",["♻"]="516",["⚫"]="517",["⚪"]="518",["🔺"]="519",
	["🔻"]="520",["⬆"]="521",["⬇"]="522",["⬅"]="523",["➡"]="524",["↩"]="525",["↪"]="526",["✉"]="527",
	["✏"]="528",["✂"]="529",["✈"]="530",["🦖"]="531",["🦕"]="532",["🧏"]="533",

	["🍎"]="534",["🍕"]="535",["🍔"]="536",["🍟"]="537",["🌭"]="538",["🍿"]="539",["🍩"]="540",["🍪"]="541",
	["🍫"]="542",["🍬"]="543",["🍭"]="544",["🍓"]="545",["🍒"]="546",["🍉"]="547",["🍇"]="548",["🍌"]="549",
	["🍍"]="550",["🥭"]="551",["🍑"]="552",["🥝"]="553",["🥑"]="554",["🌽"]="555",["🥕"]="556",["🥔"]="557",
	["🍅"]="558",["🥒"]="559",["🥦"]="560",["🌹"]="561",["🌷"]="562",["🌻"]="563",["🌸"]="564",["🌺"]="565",
	["🌼"]="566",["🌈"]="567",["⭐"]="568",["🌙"]="569",["🌍"]="570",["🌎"]="571",["🌏"]="572",["🐶"]="573",
	["🐱"]="574",["🐭"]="575",["🐹"]="576",["🐰"]="577",["🦊"]="578",["🐻"]="579",["🐼"]="580",["🐨"]="581",
	["🐯"]="582",["🦁"]="583",["🐮"]="584",["🐷"]="585",["🐸"]="586",["🐵"]="587",["🐔"]="588",["🐧"]="589",
	["🐦"]="590",["🐤"]="591",["🦆"]="592",["🦅"]="593",["🦉"]="594",["🐺"]="595",["🐗"]="596",["🐴"]="597",
	["🦄"]="598",["🐝"]="599",["🐛"]="600",["🦋"]="601",["🐌"]="602",["🐞"]="603",["🐜"]="604",["🕷️"]="605",
	["🦂"]="606",["🐢"]="607",["🐍"]="608",["🦎"]="609",["🐙"]="610",["🦑"]="611",["🦀"]="612",["🐠"]="613",
	["🐟"]="614",["🐡"]="615",["🐬"]="616",["🐳"]="617",["🐋"]="618",["🐊"]="619",["🐅"]="620",["🐆"]="621",
	["🦓"]="622",["🦍"]="623",["🐘"]="624",["🦈"]="625",["🍀"]="626",["🍁"]="627",["🍃"]="628",["🌴"]="629",
	["🌵"]="630",["🌲"]="631",["🌳"]="632",["🌿"]="633",["☘️"]="634",["🌱"]="635",["🌾"]="636",["🌊"]="637",
	["💧"]="638",["❄️"]="639",["☃️"]="640",["🌋"]="641",

	["🎈"]="642",["🎵"]="643",["🎶"]="644",["🎸"]="645",["🎹"]="646",["🥁"]="647",["🎺"]="648",["🎻"]="649",
	["🎮"]="650",["🕹️"]="651",["🎯"]="652",["🎲"]="653",["🧩"]="654",["🚗"]="655",["🚕"]="656",["🚌"]="657",
	["🚓"]="658",["🚑"]="659",["🚒"]="660",["🚜"]="661",["✈️"]="662",["🚀"]="663",["🚁"]="664",["🚢"]="665",
	["🚲"]="666",["🏠"]="667",["🏡"]="668",["🏢"]="669",["🏥"]="670",["🏫"]="671",["🏦"]="672",["🏨"]="673",
	["🏪"]="674",["⛪"]="675",["🗽"]="676",["🗼"]="677",["🗿"]="678",["🎄"]="679",["🎃"]="680",["🎆"]="681",
	["🎇"]="682",["🧨"]="683",["🎐"]="684",["🎀"]="685",["🎖️"]="686",["🎂"]="687",["🍰"]="688",["🧁"]="689",
	["🍦"]="690",["🍨"]="691",["🍧"]="692",["🥨"]="693",["🧀"]="694",["🥖"]="695",["🍞"]="696",["🥐"]="697",
	["🍳"]="698",["🥚"]="699",["🥓"]="700",["🌮"]="701",["🌯"]="702",["🍜"]="703",["🍣"]="704",["🍤"]="705",
	["🍱"]="706",["🍚"]="707",["🍙"]="708",["🍛"]="709",["🍝"]="710",["🍲"]="711",["🥗"]="712",["🍹"]="713",
	["🍸"]="714",["🍺"]="715",["🍻"]="716",["☕️"]="717",["🧃"]="718",["🍵"]="719",["🥤"]="720",["🧋"]="721",
	["🍯"]="722",["🥞"]="723",

	["😀"]="724",["😃"]="725",["😄"]="726",["😁"]="727",["😆"]="728",["😅"]="729",["😂"]="730",["🤣"]="731",
	["😊"]="732",["😇"]="733",["🙂"]="734",["🙃"]="735",["😉"]="736",["😌"]="737",["😍"]="738",["🥰"]="739",
	["😘"]="740",["😗"]="741",["😙"]="742",["😚"]="743",["😋"]="744",["😛"]="745",["😝"]="746",["😜"]="747",
	["🤪"]="748",["🤨"]="749",["🧐"]="750",["🤓"]="751",["😎"]="752",["🤩"]="753",["🥳"]="754",["😏"]="755",
	["😒"]="756",["😞"]="757",["😔"]="758",["😟"]="759",["😕"]="760",["🙁"]="761",["☹️"]="762",["😣"]="763",
	["😖"]="764",["😫"]="765",["😩"]="766",["🥺"]="767",["😢"]="768",["😭"]="769",["😤"]="770",["😠"]="771",
	["😡"]="772",["🤬"]="773",["🤯"]="774",["😳"]="775",["🥵"]="776",["🥶"]="777",["😱"]="778",["😨"]="779",
	["😰"]="780",["😥"]="781",["😓"]="782",["🤗"]="783",["🤔"]="784",["🤭"]="785",["🤫"]="786",["🤥"]="787",
	["😶"]="788",["😐"]="789",["😑"]="790",["😬"]="791",["🙄"]="792",["😯"]="793",["😦"]="794",["😧"]="795",
	["😮"]="796",["😲"]="797",["🥱"]="798",["😴"]="799",["🤤"]="800",["😪"]="801",["😵"]="802",["🤐"]="803",
	["🤢"]="804",["🤮"]="805",["🤧"]="806",["😷"]="807",["🤒"]="808",["🤕"]="809",["🤑"]="810",["🤠"]="811",
	["😈"]="812",["👿"]="813",["👹"]="814",["👺"]="815",["🤡"]="816",["💩"]="817",["👻"]="818",["💀"]="819",
	["☠️"]="820",["👽"]="821",["👾"]="822",["🤖"]="823",

	["😺"]="824",["😸"]="825",["😹"]="826",["😻"]="827",["😼"]="828",["😽"]="829",["🙀"]="830",["😿"]="831",
	["😾"]="832",["🙈"]="833",["🙉"]="834",["🙊"]="835",["💋"]="836",["💌"]="837",["💘"]="838",["💝"]="839",
	["💖"]="840",["💗"]="841",["💓"]="842",["💞"]="843",["💕"]="844",["💟"]="845",["❣️"]="846",["💔"]="847",
	["❤️"]="848",["🧡"]="849",["💛"]="850",["💚"]="851",["💙"]="852",["💜"]="853",["🖤"]="854",["🤍"]="855",
	["🤎"]="856",["💯"]="857",["💢"]="858",["💥"]="859",["💫"]="860",["💦"]="861",["💨"]="862",["💣"]="863",
	["💬"]="864",["👋"]="865",["🤚"]="866",["🖐️"]="867",["✋"]="868",["🖖"]="869",["👌"]="870",["🤏"]="871",
	["✌️"]="872",["🤞"]="873",["🤟"]="874",["🤘"]="875",["🤙"]="876",["👈"]="877",["👉"]="878",["👆"]="879",
	["👇"]="880",["☝️"]="881",["✊"]="882",["👊"]="883",["🤛"]="884",["🤜"]="885",["👏"]="886",["🙌"]="887",
	["👐"]="888",["🤲"]="889",["🤝"]="890",["🙏"]="891",["✍️"]="892",["💅"]="893",["🤳"]="894",["💪"]="895",
	["🦾"]="896",["🦿"]="897",["🦵"]="898",["🦶"]="899",["👂"]="900",["👃"]="901",["🧠"]="902",["🫀"]="903",
	["🦷"]="904",["🦴"]="905",["👀"]="906",["👁️"]="907",["👅"]="908",["👄"]="909",["🫦"]="910",["🫶"]="911",
	["👶"]="912",["🧒"]="913",["👦"]="914",["👧"]="915",["🧑"]="916",["👱"]="917",["👨"]="918",["👩"]="919",
	["🧔"]="920",["👴"]="921",

	["‼"]="922",["⁉"]="923",["❓"]="924",["❔"]="925",["❕"]="926",["❗"]="927",["⭕"]="928",["❌"]="929",
	["❎"]="930",["➕"]="931",["➖"]="932",["➗"]="933",["🔴"]="934",["🟠"]="935",["🟡"]="936",["🟢"]="937",
	["🔵"]="938",["🟣"]="939",["🟤"]="940",["🟥"]="941",["🟧"]="942",["🟨"]="943",["🟩"]="944",["🟦"]="945",
	["🟪"]="946",["🟫"]="947",["💎"]="948",["🔥"]="949",["💡"]="950",["🎉"]="951",["🎊"]="952",["🎁"]="953",
	["🏆"]="954",["🥇"]="955",["🥈"]="956",["🥉"]="957",["❤️‍🔥"]="958",["🫡"]="959",["🫠"]="960",["🫣"]="961",
	["🫢"]="962",["🤦"]="963",["🤷"]="964",["🙅"]="965",["🙆"]="966",["💁"]="967",["🙋"]="968",["🙇"]="969",
	["💇"]="970",["💆"]="971",["🗣️"]="972",["👤"]="973",["👥"]="974",["🫵"]="975",["🫰"]="976",["🤌"]="977",
	["🖕"]="978",["🩷"]="979",["🩵"]="980",["🩶"]="981",["📝"]="982",["🗨"]="983",["🗯"]="984",["💭"]="985",
	["📢"]="986",["📣"]="987",["🔊"]="988",["🔇"]="989",["🔕"]="990",["📎"]="991",["🔗"]="992",["✔️"]="993",
	["☑️"]="994",["✖️"]="995",["🔄"]="996",["➰"]="997",

	-- utility
	[utf8.char(0x200B)]="998",["�​"]="999"
}

local lp = P.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local ani = hum:WaitForChild("Animator")
local begin = "TMOIITATC" -- The measure of intelligence is the ability to change. - Albert Einstein
local typeSpeed = .07 -- After many testing, it was the best candidate to be fast enough and have as little key loss as possible when receiving messages
local readSpeed = .01
local tooLate = (maxChars + #begin) * typeSpeed * 2 -- you should not change this
local seed = "Default"
local id = "rbxassetid://135876612109535"
local players = {}
local c = alphabet
local anim = Instance.new("Animation")
anim.AnimationId = id
local track = ani:LoadAnimation(anim)
local b1 = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","!","\"","#","$","%","&","'","(",")","*","+",",","-",".","/",":",";","<","=" ,">","?","@","[","\\","]","^","_","`","{","|","}","~"}
local seeds = {[seed] = {Alphabet = c, Begin = begin, Seed = seed}}
local letLoose = true
-- v1.1

function setSettings(v)
	if v ~= nil then
		settingsOpen = v
		settingsGui.Visible = v
		settingsButton.Rotation = v and 90 or 0
	else
		if settingsOpen and not settingsGui.Visible or not settingsOpen and settingsGui.Visible then
			settingsOpen = not settingsOpen
		end
		settingsOpen = not settingsOpen
		settingsGui.Visible = settingsOpen
		settingsButton.Rotation = settingsOpen and 90 or 0
	end
end

function show(who,said)
	local msg
	local name
	local nocolor
	if type(who) == "table" then
		msg = message:Clone()
		msg.Name = who.Date -- DateTime.now

		local isMuted = muted[who.Name] and muted[who.Name].muted
		if isMuted and fullMute then return end

		said = who.Said
		if isMuted then said = string.rep("•", #said) end

		name = "["..who.Name.."]: "
		nocolor = name

		local c = who.TeamColor
		if nameUseTeamColor then
			name = '<font color="rgb('..string.format("%d,%d,%d",c.R*255,c.G*255,c.B*255)..')">'..name..'</font>'
		end

		if showTeam and who.TeamName then
			nocolor = "["..who.Team.Name.."]"..nocolor
			if teamUseTeamColor then
				name = '<font color="rgb('..string.format("%d,%d,%d",c.R*255,c.G*255,c.B*255)..')">['..who.TeamName..']</font>'..name
			else
				name = "["..who.TeamName.."]"..name
			end
		end
	elseif who and who.Parent and who.Parent == P and said then
		local isMuted = muted[who.Name] and muted[who.Name].muted
		if isMuted and fullMute then return end
		if isMuted then said = string.rep("•", #said) end

		name = "["..who.Name.."]: "
		nocolor = name

		local c = who.TeamColor and who.TeamColor.Color
		if nameUseTeamColor and c then
			name = '<font color="rgb('..string.format("%d,%d,%d",c.R*255,c.G*255,c.B*255)..')">'..name..'</font>'
		end

		if showTeam and c and who.Team then
			nocolor = "["..who.Team.Name.."]"..nocolor
			if teamUseTeamColor then
				name = '<font color="rgb('..string.format("%d,%d,%d",c.R*255,c.G*255,c.B*255)..')">['..who.Team.Name..']</font>'..name
			else
				name = "["..who.Team.Name.."]"..name
			end
		end

		local head = who.Character and who.Character:FindFirstChild("Head")
		if head and useBubbles then game:GetService("Chat"):Chat(head,said) end
	else
		return
	end

	msg = msg or message:Clone()
	msg.Message.Text = name..said
	msg.Text = nocolor..said
	msg.Parent = content
	msg.Visible = true

	local X,Y = msg.TextBounds.X / msg.Parent.AbsoluteSize.X, msg.TextBounds.Y
	msg.Size = UDim2.new(X+.014,0,1,0)

	if not open and notificationsEnabled then
		newNotifications += 1
		notification.Visible = true
		notification.Text = newNotifications > 99 and "99+" or newNotifications
	end
end

function player(who,v)
	if v == "added" then
		local new = user:Clone()
		new.Text = who.Name
		new.Visible = true
		new.Parent = mutedscrollingframe
		local int = new.Interact

		if muted[who.Name] == nil then
			muted[who.Name] = {muted = false,entry = new,conn = nil}
		else
			int.Text = muted[who.Name].muted and "unmute" or "mute"
			int.Size += muted[who.Name].muted and UDim2.new(0,12,0,0) or UDim2.new(0,0,0,0)
			int.Position += muted[who.Name].muted and UDim2.new(0,-12,0,0) or UDim2.new(0,0,0,0)
			muted[who.Name].entry = new
		end

		muted[who.Name].conn = int.MouseButton1Click:Connect(function()
			player(who,not muted[who.Name].muted)
			int.Text = muted[who.Name].muted and "unmute" or "mute"
			int.Size += muted[who.Name].muted and UDim2.new(0,12,0,0) or UDim2.new(0,-12,0,0)
			int.Position += muted[who.Name].muted and UDim2.new(0,-12,0,0) or UDim2.new(0,12,0,0)
		end)
	elseif v == "removed" and muted[who.Name] ~= nil then
		muted[who.Name].conn:Disconnect()
		muted[who.Name].entry:Destroy()
	elseif muted[who.Name] ~= nil then
		muted[who.Name].muted = v
	end
end

-- v1.1
getAlphabet = function(v)
	if not v then
		c = alphabet
		return alphabet
	end

	local rng = Random.new(v)
	local new = {}

	local values = {}
	for key, value in pairs(alphabet) do
		if value ~= "000" and value ~= "998" and value ~= "999" then
			table.insert(values, value)
		end
	end

	for i = #values, 2, -1 do
		local j = rng:NextInteger(1, i)
		values[i], values[j] = values[j], values[i]
	end

	local index = 1
	for key, value in pairs(alphabet) do
		if value == "000" or value == "998" or value == "999" then
			new[key] = value
		else
			new[key] = values[index]
			index += 1
		end
	end

	c = new
	return new
end
getIndex = function(str,a)
	c = a or c or alphabet

	for i,v in pairs(c) do
		if i == str then return v end
	end
	return nil
end
getChars = function(str,a)
	c = a or c or alphabet

	local t = {}
	for _, codepoint in utf8.codes(str) do
		local char = utf8.char(codepoint)

		if c[char] then
			table.insert(t, c[char])
		else
			table.insert(t, "999")
		end

		table.insert(t, "998")
	end

	table.remove(t)
	return t
end
getChar = function(id,a)
	c = a or c or alphabet

	if type(id) ~= "string" then id = tostring(id) end -- handle mistakes
	if id == "" or id == "0" then return " " end -- handle spaces

	if string.sub(id,6,8) == "999" then
		local tid = tonumber(id) + 0.001
		tid = string.sub(tid,3,5)
		id = tid
	end

	local passed = true
	if #id < 3 then
		passed = false
	elseif #id ~= 3 then -- handle the rest
		if string.sub(id,2,2) == "." then
			id = string.sub(id,3,5)
		elseif string.sub(id,1,1) == "." then
			id = string.sub(id,2,4)
		end
	end

	if passed then
		for i,v in pairs(c) do
			if v == id then
				if v == "998" then return "" end
				return i
			end
		end
	end

	warn("unknown char: '"..id.."'", debug.traceback())
	return "�"
end

function load()
	for _,v in pairs(content:GetChildren()) do
		if v:IsA("TextBox") then
			v:Destroy()
		end
	end
	if players[seed] then
		for name,data in pairs(players[seed]) do
			for i,v in pairs(data) do
				show(data[i])
			end
		end
	end
end

function setChannel(v) -- now uses only 1 byte keys because using all the ones from the alphabet made begin go up to 50 keys in size and kept breaking
	local rng = Random.new(v)

	begin = ""
	for i = 1, 20 do
		begin..= b1[rng:NextInteger(1, #b1)]
	end
	
	tooLate = (maxChars + #begin) * typeSpeed * 2
	players[v] = players[v] or {}
	c = getAlphabet(v)
	seed = v
	if not seeds[v] then
		seeds[v] = {Alphabet = c, Begin = begin, Seed = v}
	end
	load()
end

function say(str)
	track:Play()
	track:AdjustSpeed(0)

	local start = getChars(begin)
	local idx = 0
	while #start > 0 do
		task.wait(typeSpeed)
		idx += 1
		if start[idx] then
			track.TimePosition = tonumber("0."..start[idx])
			start[idx] = nil
		end
	end

	local chars = getChars(str)
	local idx = 0
	while #chars > 0 do
		task.wait(typeSpeed)
		idx += 1
		if chars[idx] then
			track.TimePosition = tonumber("0."..chars[idx])
			chars[idx] = nil
		end
	end

	task.wait(typeSpeed)
	track:Stop()
end

function similarity(a, b)
	local a = string.split(a, "")
	local b = string.split(b, "")
	local dp = {}

	for i = 0,#a do
		dp[i] = {}
		for j = 0,#b do
			if i == 0 or j == 0 then
				dp[i][j] = 0
			elseif a[i] == b[j] then
				dp[i][j] = dp[i - 1][j - 1] + 1
			else
				dp[i][j] = math.max(dp[i - 1][j], dp[i][j - 1])
			end
		end
	end

	return dp[#a][#b] / math.max(#a, #b)
end

function setup(plr)
	if plr == lp then
		track:Play()
		track:Stop()
	end

	local char2 = plr.Character or plr.CharacterAdded:Wait()
	local hum2 = char2:WaitForChild("Humanoid")
	local ani2 = hum2:WaitForChild("Animator")

	local now = nil
	local conn = nil
	local beginSize = 0
	players[seed] = players[seed] or {}

	local function init(track)
		if not track.Animation or track.Animation.AnimationId ~= id then return end -- making sure it's the anim expected
		
		local Running = true
		
		for _,data in pairs(seeds) do
			task.spawn(function()
				local conn = nil
				local saying = ""
				local running = true
				local success = false
				local seed = data.Seed
				local beginD = data.Begin
				local alphabet = data.Alphabet
				local curr = track.TimePosition
				local last = track.TimePosition

				task.spawn(function()
					task.wait(tooLate)
					if running or Running then
						saying = ""
						running = false
						Running = false
					end
				end)

				task.spawn(function()
					while running and Running do -- check if what is said is var begin and if not ignore
						task.wait(readSpeed)
						curr = track.TimePosition
						if curr ~= last then
							last = curr
							if string.sub(curr,3,5) ~= "998" then
								saying ..=getChar(curr,alphabet)
							end
						end
					end
				end)

				while running and Running do -- check if what is said is var begin and if not ignore
					task.wait(readSpeed)
					if letLoose and similarity(saying,beginD) >= 0.888 or saying == beginD then
						beginSize = #saying
						success = true
						break
					elseif #saying > #beginD then
						break
					end
				end

				if success then
					running = false
					task.spawn(function()
						while track.IsPlaying and Running do
							wait(readSpeed)
							curr = track.TimePosition
							if curr ~= last then
								last = curr
								saying ..=getChar(curr,alphabet)
							end
						end
					end)

					now = tick()

					local function run()
						running = false
						Running = false
						conn:Disconnect()
						local msg = string.sub(saying,(string.find(saying,beginD) and #beginD or beginSize)+1,#saying)

						local tbl = players[seed][plr.Name] or {}
						players[seed][plr.Name] = tbl
						tbl[#tbl + 1] = {Date = tostring(DateTime.now()),Name = plr.Name,TeamName = plr.Team and plr.Team.Name,TeamColor = plr.TeamColor and plr.TeamColor.Color,Said = msg,UserId = plr.UserId}

						if letLoose and similarity(string.sub(saying,1,#begin),begin) >= 0.888 or string.find(saying,begin) then show(plr,tbl[#tbl].Said) end
						saying = ""
					end

					conn = track.Ended:Connect(function()
						run()
					end)
				elseif running then
					running = false
				end
			end)
		end
	end

	conn = ani2.AnimationPlayed:Connect(init)

	plr.CharacterAdded:Connect(function(c)
		char2 = c
		hum2 = c:WaitForChild("Humanoid")
		ani2 = hum2:WaitForChild("Animator")
		if plr == lp then
			char = c
			hum = char:WaitForChild("Humanoid")
			ani = hum:WaitForChild("Animator")
			track = ani:LoadAnimation(anim)
			track:Play()
			track:Stop()
		end
		conn:Disconnect()
		conn = ani2.AnimationPlayed:Connect(init)
	end)
end
-- v1.1

local icons = {
	settings = "rbxassetid://90643972560249",
	minus = "rbxassetid://125011932198898",
	plus = "rbxassetid://133913812573720",
}

for _,plr in pairs(P:GetPlayers()) do
	if plr ~= P.LocalPlayer then
		player(plr,"added")
	end
	setup(plr)
end
P.PlayerAdded:Connect(function(plr)
	player(plr,"added")
	setup(plr)
end)
P.PlayerRemoving:Connect(function(plr)
	player(plr,"removed")
end)

-- I am not removing players from muted table so muted players cannot rejoin and have their mute reset

list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	content.CanvasSize = UDim2.new(0,0,0,list.AbsoluteContentSize.Y)
end)

uIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	content.CanvasSize = UDim2.new(0,0,0,uIListLayout.AbsoluteContentSize.Y)
end)

chatbox.FocusLost:Connect(function(bool)
	local msg = chatbox.Text
	if msg ~= "" and bool then
		chatbox.Text = ""
		say(msg)
	end
end)

chatbox.Changed:Connect(function()
	chatbox.Text = chatbox.Text:sub(1,maxChars)
end)

send.MouseButton1Click:Connect(function()
	local msg = chatbox.Text
	if msg ~= "" then
		chatbox.Text = ""
		say(msg)
	end
end)

interactButton.MouseButton1Click:Connect(function()
	open = not open
	interactButton.Image = icons[open and "minus" or "plus"]

	header.Position += open and UDim2.new(0,0,0,-172) or UDim2.new(0,0,0,172)

	newNotifications = 0
	notification.Text = "0"
	notification.Visible = false
end)

settingsButton.MouseButton1Click:Connect(setSettings)

interact_3.Text = notificationsEnabled and "✓" or ""
interact_3.MouseButton1Click:Connect(function()
	notificationsEnabled = not notificationsEnabled
	interact_3.Text = notificationsEnabled and "✓" or ""
	if not notificationsEnabled then
		newNotifications = 0
		notification.Text = "0"
		notification.Visible = false
	end
end)

interact_2.Text = fullMute and "✓" or ""
interact_2.MouseButton1Click:Connect(function()
	fullMute = not fullMute
	interact_2.Text = fullMute and "✓" or ""
end)

fullMuteSetting.MouseButton1Click:Connect(function()
	infoLabel.Visible = not infoLabel.Visible
	fullMuteSetting.Text = infoLabel.Visible and "Full Mute (click to hide info)" or "Full Mute (click to show info)"
end)

interact_4.Text = letLoose and "✓" or ""
interact_4.MouseButton1Click:Connect(function()
	letLoose = not letLoose
	interact_4.Text = letLoose and "✓" or ""
end)

channelSeed.FocusLost:Connect(function()
	if channelSeed.Text ~= "" then
		if tonumber(channelSeed.Text) then
			setChannel(tonumber(channelSeed.Text))
		else
			channelSeed.TextColor3 = Color3.fromRGB(255,0,0)
			channelSeed.Text = "Invalid Number"
			wait(1)
			channelSeed.Text = ""
			channelSeed.TextColor3 = Color3.fromRGB(255,255,255)
		end
	else
		tooLate = (maxChars + 9) * typeSpeed * 2
		c = getAlphabet()
		begin = "TMOIITATC"
		seed = "Default"
		load()
	end
end)
channelSeed.Changed:Connect(function()
	channelSeed.Text = channelSeed.Text:sub(1,100)
end)

game:GetService("UserInputService").InputBegan:Connect(function(i)
	if i.KeyCode == keyToFocus then
		if not open then
			open = not open
			interactButton.Image = icons[open and "minus" or "plus"]

			header.Position += open and UDim2.new(0,0,0,-172) or UDim2.new(0,0,0,172)

			newNotifications = 0
			notification.Text = "0"
			notification.Visible = false
		end
		chatbox:CaptureFocus()
	end
end)

if not settingsExist then
	header.Size += UDim2.new(0,21,0,0)
	settingsCircle:Destroy()
	settingsButton:Destroy()
	settingsGui:Destroy()
end

setSettings(false)

msg = msg or message:Clone()
msg.Message:Destroy()
msg.TextColor3 = Color3.fromRGB(155,155,155)
msg.Text = "[System]: Subtle Subtitles v1.3 by @CaptainSkira https://github.com/solal0/Luau (click to dismiss)"
msg.Parent = content
msg.Visible = true
msg.Focused:Connect(function()
	msg.Visible = false
end)

local X,Y = msg.TextBounds.X / msg.AbsoluteSize.X, msg.TextBounds.Y
msg.Size = UDim2.new(1,0,0,Y)

print("[SST]: Subtle Subtitles 1.3 loaded.")
