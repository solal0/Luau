# Luau
tools and libraries I made for Roblox development.

## Tools

### I2B64
I2B64 (Image to Base64) is a python tool that converts images into a custom base64<br>and using luau allows you to recreate that image in Roblox using EditableImages

[Github](https://github.com/solal0/I2B64) [Latest](https://github.com/solal0/I2B64/releases/latest)

### Utils
Utils is a ModuleScript containing a bunch of usefull functions.

Features:
1. Base64 encoder and decoder by @xDeltaXen (on roblox)
   - utils.encode(string) / return string
   - utils.decode(string) / return string
3. I2B64 lua side (listed above)
   - utils.base64toImage(string) / return Content.fromObject(image), image, number (X), number (Y)
5. InfiniteYield's secure services table
   - utils.services.ServiceName
7. InfiniteYield's random string generator
   - utils.randomString() / return string
8. InfiniteYield's safe gui finder
   - utils.getSafeGui() / return ScreenGui
9. A function to get the first available clipboard function
   - utils.getClipboardFunction() / return function, name
10. A function to find a function from a word
   - utils.findFunction(string) / return table (i = name, v = function)

`loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/Utils.luau"))()`

### ByteCode Inspector
ByteCode Inspector is a luau script decompiler who turns script's bytecode into readable luau using decompilers such as Luacid and LunaUX.

`loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/bc_inspector.luau"))()`

### Subtle Subtitles
I started this project as a custom chatbox/chat display and for the v1.1 decided to turn it into a P2P chatbox who can receive and send messages from his client to another client without cummunicating with the server as long as the other client has the same tool running.

Features:
- A way to mute certain users by either replacing their chats with dots or by hiding their messages entirely
<br>(users will remain muted if they leave and rejoin as long as you don't)
- A default chat channel and the ability to change the channel id (seed).
<br>Changing the seed will generate a unique alphabet and communication seed.
- A notification count when minimized

`loadstring(game:HttpGet("soon"))()`

## Libraries

### Skira Library
Skira Library is a fully free and open source UI library for Roblox.<br>It has it's very own documentation and allows anyone to create simple uis in no time.

Official: [Website](https://skira.me/lua/SkiraLibrary/) [Documentation](https://skira.me/lua/SkiraLibrary/)

Github: [Website](https://skira.me/lua/SkiraLibrary/) [Documentation](https://skira.me/lua/SkiraLibrary/)
