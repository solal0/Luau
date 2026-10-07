Skira's Luau
======
A bunch of tools and libraries I made for Roblox development.

------

<br>

Tools
======

### Lucide
Lucide is a module that serves [lucide.dev](https://lucide.dev) icons in 64x64.
<br>Icon package used: [1.52.0](https://github.com/lucide-icons/lucide/releases/tag/1.52.0)

```lua
-- Format:
GetIcon (
    Name:string -- icon's name from lucide.dev
) : {
    Url:string, -- icon's sheet rbxassetid string
    Vector:Vector2 -- icon's coordinates on the sheet
}
-- Usage:
Lucide.GetIcon("user") -- will return { "rbxassetid://84945752309065", Vector2.new(448, 832) }

-- Format:
SetImage(
    Image:Instance,
    Name:string -- icon's name from lucide.dev
)
-- Usage:
Lucide.SetIcon(Image,"user")
```

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/Lucide.luau"))()
```

------

### KeyToKey
KeyToKey is a module that serves [kenney.nl](https://www.kenney.nl) icons in 64x64.
<br>Icon package used: [1.5](https://kenney.nl/assets/input-prompts)
<br><br>As well as the functions below, KeyToKey also returns a AllUseOutline boolean who's by default set to false
<br>If set to true, all key icons will be their outline version.

```lua
-- Format:
GetKey (
    Name:string -- can be a UserInputType/KeyCode name or a specific key name from kenney.nl
    Oultine:boolean? -- optional, will fallback to KTK.AllUseOutline if not defined
) : {
    Url:string, -- key's sheet rbxassetid string
    Vector:Vector2 -- key's coordinates on the sheet
}
-- Usage:
KTK.GetKey("MouseButton1",true) -- will return { "rbxassetid://116958231932199", Vector2.new(640, 320) }

-- Format:
SetImage(
    Image:Instance,
    Name:string -- can be a UserInputType/KeyCode name or a specific key name from kenney.nl
    Oultine:boolean? -- optional, will fallback to KTK.AllUseOutline if not defined
)
-- Usage:
KTK.SetIcon(Image,"MouseButton1",true)
```

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/KTK.luau"))()
```

------

### Utils
A module containing a bunch of usefull functions.

Features:
```lua
-- 1. Base64 encoder and decoder by @xDeltaXen (on roblox)
utils.encode(string)
return string

utils.decode(string)
return string

-- 2. I2B64 lua side (listed above)
utils.base64toImage(string)
return Content.fromObject(image), image, width (number), height (number)

-- 3. InfiniteYield's secure services table
utils.services.ServiceName

-- 4. InfiniteYield's random string generator
utils.randomString()
return string

-- 5. InfiniteYield's safe gui finder
utils.getSafeGui()
return ScreenGui

-- 6. A function to get the first available clipboard function
utils.getClipboardFunction()
return function, name

-- 7. A function to find a function from a word
utils.findFunction(string)
return table (name, function)

-- 8. A function to convert numbers into letters with 1 being A, 26 being Z and 27 being AA
utils.toBase26(number)
return string
```

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/Utils.luau"))()
```

------

### ByteCode Inspector
ByteCode Inspector is a luau script decompiler who turns script's bytecode into readable luau using decompilers such as Luacid and LunaUX.

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/bc_inspector.luau"))()
```

------

### Subtle Subtitles
I started this project as a custom chatbox/chat display and for the v1.1 decided to turn it into a P2P chatbox who can receive and send messages from his client to another client without communicating with the server as long as the other client has the same tool running.

Features:
- A way to mute certain users by either replacing their chats with dots or by hiding their messages entirely
<br>(users will remain muted if they leave and rejoin as long as you don't)
- A default chat channel and the ability to change the channel id (seed).
<br>Changing the seed will generate a unique alphabet and communication seed.
- A notification count when minimized

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/subtle_subtitles.luau"))()
```

------

### I2B64
I2B64 (Image to Base64) is a python tool that converts images into a custom base64<br>and using luau allows you to recreate that image in Roblox using EditableImages

[Github](https://github.com/solal0/I2B64) [Latest](https://github.com/solal0/I2B64/releases/latest)

------

<br>

Libraries
======

### Skira Library
Skira Library is a fully free and open source UI library for Roblox.
<br>It has it's very own documentation and allows anyone to create simple uis in no time.

Official: [Website](https://skira.me/lua/SkiraLibrary/) [Documentation](https://skira.me/lua/SkiraLibrary/)

Github: [Website](https://skira.me/lua/SkiraLibrary/) [Documentation](https://skira.me/lua/SkiraLibrary/)

------

### Stand UI
Based off Stand's ui, a GTAV mod menu, Stand UI is a UI library where simplicity is key.
I like Skira Library but there's a lot of settings to remember, too many actually. That's part of why I decided to make this one.
Since it's simpler, every element only requires a function and a string at max and the doc can fit just below this text.

Note: Stand UI only supports PC because of the navigation controls and no, i'm not gonna change that. At least I didn't plan to.<br>

```lua
-- Config (all these can be overwritten if set in the settings table of the Window call)

{
	-- colors
	header = Color3.new(1,0,1),
	selected = Color3.new(1,0,1),
	scrollbar = Color3.new(1,0,1),
	background = Color3.new(0,0,0),
	selectedTab = Color3.new(1,0,1),
	selectedOption = Color3.new(1,0,1),
	
	notificationBar = Color3.new(1,0,1),
	notificationFull = Color3.fromRGB(157,0,157),
	
	textColor = Color3.new(1,1,1),
	hoveredTextColor = Color3.new(1,1,1),
	
	-- keys
	exit = Enum.KeyCode.Escape,
	contentUp = Enum.KeyCode.Up,
	enter = Enum.KeyCode.Return,
	commandBar = Enum.KeyCode.U,
	toggle = Enum.KeyCode.Insert,
	back = Enum.KeyCode.Backspace,
	tabUp = Enum.KeyCode.RightShift,
	contentDown = Enum.KeyCode.Down,
	tabDown = Enum.KeyCode.RightControl,
}
```

```lua
-- Example

local gui = Instance.new("ScreenGui",game.Players.LocalPlayer.PlayerGui)
local window = ui.Window(gui,"Stand UI 0.0.1")

-- (Name:string, Settings:{CommandBar:true?}?)
local s = window.NewTab("Self")
local v = window.NewTab("Vehicle")
return {Tab:Frame, Content:Frame, Select:Function, Unselect:Function, Remove:Function, Back:Function and all NewInstance functions}

-- (Name:string, Settings:{OnSelect:Function?, OnUnselect:Function?, OnRemove:Function?}?)
local action = s.NewAction("Example Action")
return {Select:Function, Unselect:Function, Remove:Function}

-- (Name:string, Settings:{OnSelect:Function?, OnUnselect:Function?, OnRemove:Function?}?)
local toggle = s.NewAction("Example Toggle")
return {Select:Function, Unselect:Function, Remove:Function}

-- (Name:string, Settings:{OnSelect:Function?, OnUnselect:Function?, OnRemove:Function?}?)
local category = s.NewCategory("Example Category")
return {Tab:Frame, Content:Frame, Select:Function, Unselect:Function, Remove:Function, Back:Function and all NewInstance functions}

-- (Parent:ScreenGui, Title:string, Text:string)
ui.Prompt(gui,"Stand UI",`Hey, thanks for trying out Stand UI ! A ui library for roblox based off the famous Grand Theft Auto V mod menu Stand.\n\nCredits\n- Developped by CaptainSkira (https://github.com/solal0)\n- Inspired by Stand's ui (https://stand.sh)`)
return Prompt:Frame

-- (Parent:ScreenGui, Text:string, Seconds:number?)
ui.Notify(gui,"Command executed successfully ! :D",3)
return nil,nada,nothing,rien,none
```

```lua
-- Loadstring

loadstring(game:HttpGet("soon..."))()
```

------
