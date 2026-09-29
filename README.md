# Luau
tools and libraries I made for Roblox development.

## Tools

### I2B64
I2B64 (Image to Base64) is a python tool that converts images into a custom base64<br>and using luau allows you to recreate that image in Roblox using EditableImages

[Github](https://github.com/solal0/I2B64) [Latest](https://github.com/solal0/I2B64/releases/latest)

### Utils
Utils is a ModuleScript containing a bunch of usefull functions.<br>As of now it only contains I2B64 and a base64 encoder/decoder but i'll add more over time.

`loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/Utils.luau"))()`

### ByteCode Inspector
ByteCode Inspector is a luau script decompiler who turns script's bytecode into readable luau using decompilers such as Luacid and LunaUX.

`loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/bc_inspector.luau"))()`

### Subtle Subtitles
I started this project as a custom chatbox/chat display and for the v1.1 decided to turn it into a P2P chatbox who can receive and send messages from his client to another client without cummunicating with the server as long as the other client has the same tool running.
<br>Features:
- A way to mute certain users by either replacing their chats with dots or by hiding their messages entirely
- A default chat channel and the ability to change the channel id (seed).
<br>Changing the seed will generate a unique alphabet and communication seed.
- A notification count when minimized

`loadstring(game:HttpGet("soon"))()`

## Libraries

### Skira Library
Skira Library is a fully free and open source UI library for Roblox.<br>It has it's very own documentation and allows anyone to create simple uis in no time.

Official: [Website](https://skira.me/lua/SkiraLibrary/) [Documentation](https://skira.me/lua/SkiraLibrary/)

Github: [Website](https://skira.me/lua/SkiraLibrary/) [Documentation](https://skira.me/lua/SkiraLibrary/)
