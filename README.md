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
    string -- icon's name from lucide.dev
) : {
    string, -- spritesheet's rbxassetid
    Vector2 -- coordinates
}
-- Usage:
Lucide.GetIcon("user") -- will return { "rbxassetid://84945752309065", Vector2.new(448, 832) }

-- Format:
SetImage(
    Instance,
    string -- icon's name from lucide.dev
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
    string -- can be a UserInputType/KeyCode name or a specific key name from kenney.nl
    boolean? -- optional, will fallback to KTK.AllUseOutline if not defined
) : {
    string, -- spritesheet's rbxassetid
    Vector2 -- key's coordinates on the sheet
}
-- Usage:
KTK.GetKey("MouseButton1",true) -- will return { "rbxassetid://116958231932199", Vector2.new(640, 320) }

-- Format:
SetImage(
    Instance,
    string -- can be a UserInputType/KeyCode name or a specific key name from kenney.nl
    boolean? -- optional, will fallback to KTK.AllUseOutline if not defined
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

-- 2. I2B64 lua side (listed near the bottom)
utils.toImage(string)
return Content.fromObject(image), image, width (number), height (number)

-- 3. InfiniteYield's secure services table
utils.services.ServiceName

-- 4. InfiniteYield's random string generator
utils.randomString()
return string

-- 5. InfiniteYield's safe gui finder
utils.getGui()
return ScreenGui

-- 6. Get the first available clipboard function
utils.clipboard()
return function, name

-- 7. Find a function using a word
utils.find(string)
return table (name, function)

-- 8. Convert numbers into letters with 1 being A, 26 being Z and 27 being AA
utils.toBase26(number)
return string

-- 9. Get http function
utils.request()
return function

-- 10. Tries to get a working url opener function.
utils.openurl()
return function

-- 10. Get object from string path
utils.getInstance(string) -- e.g. "game.Workspace.Baseplate"
return Instance
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

### Blurred Gui
A module to give ui elements a blur effect
Blurred Gui is a modified version of @ImSnox's Blur Controller, adapted into a ModuleScript


```lua
-- Change settings if needed, calling this function is optional
BlurredGui.Init({
    PartSize -- default to 0.01
    Extra -- default to Vector3.new(0,0,0)
    BlurSize -- default to Vector2.new(10, 10)
    PartTransparency -- default to 1 - 1e-7
    FarIntensity -- default to 0
    NearIntensity -- default to 0.25
    FocusDistance -- default to 0.25
    InFocusRadius -- default to 0
})

-- Create a blur
BlurredGui.New(
    Instance, -- UI element to apply the blur onto
    string? -- optional, defaults to "Rectangle" but can be set to "Oval"
)

-- Remove a blur
BlurredGui.Remove(Instance) -- if you delete an instance who has a blur, the blur will automatically be removed.
```

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/BlurredGui.luau"))()
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
I2B64 (Image to Base64) is a python tool that converts images into a custom base64<br>and using luau allows you to recreate that image in Roblox with EditableImages

[Github](https://github.com/solal0/I2B64) [Latest](https://github.com/solal0/I2B64/releases/latest)

------

<br>

Libraries
======

### Skira Library
Skira Library is a fully free and open source UI library for Roblox.
<br>It has it's very own documentation and allows anyone to create simple uis in no time.

[Website](https://skira.me/lua/SkiraLibrary/) [Documentation](https://skira.me/lua/SkiraLibrary/)

------

### Stand UI
Based off Stand's ui, a GTAV mod menu, Stand UI is a UI library where simplicity is key.
I like Skira Library but there's a lot of settings to remember, too many actually. That's part of why I decided to make this one.

Note: Stand UI only has PC support and I am not planning on adding mobile support. At least not for now.

[API](https://github.com/solal0/Luau/blob/main/Libraries/StandUI/API.luau)

```lua
-- Loadstring

loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Libraries/StandUI/stand.luau"))()
```

------
