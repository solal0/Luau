# Stand UI API
StandUI is a Luau UI library for Roblox. It uses the same style and elements as the GTA V mod menu [Stand](https://stand.sh).

## Credits
- Me, solal0/Skira
- Stand's developer team

## API
If anything goes wrong, file an issue or find a way to contact me, ty.

The `stand` and `tab` variables used throughout this documentation come from:
```lua
local stand = loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Libraries/StandUI/stand.luau"))()
local tab = stand.NewTab("Tab")
```

## 1. Structure

### 1.1. Informations
Most elements share these settings:

| Setting | Description | Value |
| --- | --- | --- |
| `Name` | Element's name, passed as the first argument | `string` |
| `Settings.Command` | Adds a command to the Command Box | `{Name = string, Info = string?}` |
| `Settings.Inform` | Displays information below the tabs when selected | `string` |
| `Settings.Function` | Callback used by the element | `function` |

Settings are optional unless specified otherwise. `NewTab`, `NewCategory`, and `NewSeparator` have their own arguments. Callback arguments depend on the element.

### 1.2. Command Box
The Command Box executes commands without navigating through the menu. Press `KEY_COMMAND_BOX` (U by default) to open it.

Commands are created with `Settings.Command`:
```lua
tab.NewAction("Hello",{Command = {Name = "hello",Info = "Prints Hello, World!"},Function = function() print("Hello, World!") end})
```

| Feature | Description |
| --- | --- |
| Search | Type at least 3 characters to display matching commands |
| Autocomplete | Press Tab to complete the first matching command |
| Execute | Press Enter to execute the selected command |
| Close | Press Escape to close the Command Box |
| Arguments | Add arguments after the command name, separated by spaces |

| Element | Argument | Example |
| --- | --- | --- |
| `NewAction` | None | `hello` |
| `NewToggle` | `on`, `off`, `true`, `false` | `godmode on` |
| `NewValue` | `number` | `speed 50` |
| `NewText` | `string` | `username Skira` |
| `NewKey` | Key name | `menukey F4` |
| `NewColor` | Hexadecimal color through its text command | `color FF00FF` |

Command names are converted to lowercase and spaces are removed. When a name is already taken, a numeric suffix is used to distinguish it.

When an element with a command is selected, its command name and expected arguments are displayed below the tabs.

### 1.3. Returned Functions
```lua
stand.unload() -- Destroys the UI and disconnects its connections
stand.load(table) -- Soon to come
stand.setName(string) -- Changes the menu title
stand.setHeader(string) -- Sets a header using a valid header name
stand.NewTab(string) -- Creates a tab, see Elements (2)
stand.Notify(string,number?) -- Creates a notification
stand.GameNotify(string,number?) -- Displays a notification at the top-left
stand.Prompt(string,string,number?,function?) -- Creates a prompt
stand.Inform(string) -- Creates an information label
```

### 1.4. Returned Variables
```lua
stand.Gui -- The UI's ScreenGui
stand.Bar -- The title bar
stand.Main -- Frame containing the menu
stand.Keys -- Created and internal keybinds
stand.Headers -- Available headers
stand.StandUI -- Current version
```

---

## 2. Elements

Elements are created inside tabs or categories using `tab.NewElement(...)` or `category.NewElement(...)`.

### 2.1 NewTab
Creates a tab in the main menu.

| Description | Argument | Required |
| --- | --- | --- |
| Tab's name | `string` | yes |

Return:
```lua
.NewAction(string,table?)
.NewToggle(string,table?)
.NewValue(string,number,number,table?)
.NewColor(string,table?)
.NewSelector(string,table,table?)
.NewText(string,table?)
.NewKey(string,table)
.NewSeparator(string,table?)
.NewCategory(string)
```

Example:
```lua
local player = stand.NewTab("Player")
player.NewAction("Hello",{Function = function() print("Hello, World!") end})
```

### 2.2 NewAction
Creates an element that executes a function, copies text, opens a link, or displays text.

| Description | Argument | Required |
| --- | --- | --- |
| Element's name | `string` | yes |
| Table of settings | `table` | no |

Setting's Table:

| Setting | Description | Value |
| --- | --- | --- |
| `Link` | Attempts to open a URL, copying it if opening is unavailable | `string` |
| `Display` | Displays text on the right | `string` |
| `Clipboard` | Copies text to the clipboard | `string` |
| `Function` | Called when activated, including when `Link` or `Clipboard` is set | `function` |
| `Command` | Adds a command to the Command Box | `{Name = string, Info = string?}` |
| `Inform` | Shows information when selected | `string` |

`Clipboard` takes priority over `Link`. The link icon takes priority over `Display`.

Return:
```lua
[1] -- Element TextLabel
[2] -- Display TextLabel or link ImageLabel, if created
```

Example:
```lua
tab.NewAction("Copy Discord",{Clipboard = "discord.gg/example",Inform = "Copies the invite."})
tab.NewAction("Website",{Link = "https://stand.sh"})
tab.NewAction("Version",{Display = "v1.0",Function = function() print("StandUI") end})
```

### 2.3 NewToggle
Creates a toggleable (on/off) element.

| Description | Argument | Required |
| --- | --- | --- |
| Element's name | `string` | yes |
| Table of settings | `table` | no |

Setting's Table:

| Setting | Description | Value |
| --- | --- | --- |
| `Default` | Initial state, false by default | `boolean` |
| `Function` | Called with the current toggle state | `function` |
| `Command` | Adds a command to the Command Box | `{Name = string, Info = string?}` |
| `Inform` | Shows information when selected | `string` |

The Command Box accepts `on`, `off`, `true`, and `false`.

Return: `nil`

Example:
```lua
tab.NewToggle("Enabled",{Default = false,Command = {Name = "enabled"},Function = function(state) print(state) end})
```

### 2.4 NewValue
Creates a numerical element controlled with the left and right arrow keys.

| Description | Argument | Required |
| --- | --- | --- |
| Element's name | `string` | yes |
| Minimum value | `number` | yes |
| Maximum value | `number` | yes |
| Table of settings | `table` | no |

Setting's Table:

| Setting | Description | Value |
| --- | --- | --- |
| `Default` | Initial value, defaults to the minimum | `number` |
| `Speed` | Amount added or subtracted using arrow keys | `number` |
| `Function` | Called with the current value on interaction | `function` |
| `Command` | Adds a command to the Command Box | `{Name = string, Info = string?}` |
| `Inform` | Shows information when selected | `string` |

If `Speed` is omitted, it is determined from the default value's decimal precision. Arrow-key adjustments wrap around the range.

Return:
```lua
.setValue(number) -- Sets the value, clamped between Min and Max
```

`setValue` updates the value without calling `Settings.Function`.

Example:
```lua
local speed = tab.NewValue("Speed",0,100,{Default = 25,Speed = 5,Command = {Name = "speed"},Function = function(value) print(value) end})
speed.setValue(50)
```

### 2.5 NewColor
Creates a category with RGB values, a hexadecimal input, and a display of the current color.

| Description | Argument | Required |
| --- | --- | --- |
| Element's name | `string` | yes |
| Table of settings | `table` | no |

Setting's Table:

| Setting | Description | Value |
| --- | --- | --- |
| `Id` | References an existing internal UI color property | `string` |
| `Default` | Initial color, defaults to black | `Color3` |
| `Function` | Called with the current color | `function` |
| `Command` | Provides the base name for the RGB commands | `{Name = string, Info = string?}` |
| `Inform` | Optional information setting | `string` |

Initial color priority: Existing `Id` color > `Default` > black. A valid `Id` also updates the corresponding internal UI color.

Return:
```lua
.setColor(color3) -- Sets a Color3
.setHex(string) -- Sets a six-digit hex color, with or without #
.getColor() -- Returns the current Color3
```

Example:
```lua
local color = tab.NewColor("Accent",{Default = Color3.fromRGB(255,0,255),Function = function(value) print(value) end})
color.setHex("00FFAA")
print(color.getColor())
```

### 2.6 NewSelector
Creates an element that cycles through predefined options with the left and right arrow keys.

| Description | Argument | Required |
| --- | --- | --- |
| Element's name | `string` | yes |
| List of options | `table` | yes |
| Table of settings | `table` | no |

Setting's Table:

| Setting | Description | Value |
| --- | --- | --- |
| `Default` | Initially selected option, defaults to the first entry | `string` |
| `Function` | Called with the selected index and value | `function` |
| `Command` | Adds a command to the Command Box | `{Name = string, Info = string?}` |
| `Inform` | Shows information when selected | `string` |

Use a sequential list of strings. `Default` must match an entry in the list. Selection wraps around at either end.

Return: `nil`

Example:
```lua
tab.NewSelector("Mode",{"Normal","Fast","Slow"},{Default = "Normal",Function = function(index,value) print(index,value) end})
```

### 2.7 NewText
Creates an editable text value. Text is entered through the Command Box.

| Description | Argument | Required |
| --- | --- | --- |
| Element's name | `string` | yes |
| Table of settings | `table` | no |

Setting's Table:

| Setting | Description | Value |
| --- | --- | --- |
| `Default` | Initial text, empty by default | `string` |
| `Function` | Called with the updated text | `function` |
| `Command` | Adds a command to the Command Box | `{Name = string, Info = string?}` |
| `Inform` | Shows information when selected | `string` |

Press Enter on the element to open the Command Box with its command filled in. A command is automatically created from the element name if omitted.

Return:
```lua
.setText(string) -- Updates the text and calls Settings.Function
```

Example:
```lua
local username = tab.NewText("Username",{Default = "Player",Function = function(value) print(value) end})
username.setText("Skira")
```

### 2.8 NewKey
Creates a keybind element whose assigned key is displayed on the right and changed through the Command Box.

| Description | Argument | Required |
| --- | --- | --- |
| Element's name | `string` | yes |
| Table of settings | `table` | yes |

Setting's Table:

| Setting | Description | Value |
| --- | --- | --- |
| `Id` | Identifier for the key in `stand.Keys` | `string` |
| `Key` | Initial key, defaults to `Enum.KeyCode.None` | `EnumItem` |
| `Function` | Function associated with the keybind | `function` |
| `Command` | Adds a command to the Command Box | `{Name = string, Info = string?}` |
| `Inform` | Shows information when selected | `string` |

Supports `Enum.KeyCode` and `Enum.UserInputType`. Press Enter to open the Command Box and enter a new key name.

Return:
```lua
.setText(string) -- Attempts to assign a key using its enum name
```

Example:
```lua
local key = tab.NewKey("Menu Key",{Id = "KEY_TOGGLE",Key = Enum.KeyCode.F4,Function = function() print("Pressed") end})
key.setText("F5")
```

### 2.9 NewSeparator
Creates a non-interactive separator between elements.

| Description | Argument | Required |
| --- | --- | --- |
| Separator's name | `string` | yes |
| Table of settings | `table` | no |

Setting's Table:

| Setting | Description | Value |
| --- | --- | --- |
| `Alignment` | Horizontal text alignment, center by default | `Enum.TextXAlignment` |

Separators are skipped during navigation.

Return:
```lua
[1] -- Separator TextLabel
```

Example:
```lua
tab.NewSeparator("Player Settings",{Alignment = Enum.TextXAlignment.Center})
```

### 2.10 NewCategory
Creates a category containing elements and nested categories.

| Description | Argument | Required |
| --- | --- | --- |
| Category's name | `string` | yes |

Return:
```lua
.NewAction(string,table?)
.NewToggle(string,table?)
.NewValue(string,number,number,table?)
.NewColor(string,table?)
.NewSelector(string,table,table?)
.NewText(string,table?)
.NewKey(string,table)
.NewSeparator(string,table?)
.NewCategory(string)
```

Example:
```lua
local settings = tab.NewCategory("Settings")
settings.NewToggle("Enabled",{Default = true})
settings.NewValue("Speed",0,100,{Default = 50,Speed = 5})
settings.NewSeparator("Advanced")
local advanced = settings.NewCategory("Advanced Settings")
advanced.NewAction("Reset",{Function = function() print("Reset") end})
```

---

## 3. Notifications

### 3.1 Notify
Displays a notification near the bottom-left of the screen. Multiple notifications can be displayed.

| Description | Argument | Required |
| --- | --- | --- |
| Notification text | `string` | yes |
| Duration in seconds | `number` | no |

Duration defaults to 3 seconds.

Example:
```lua
stand.Notify("Settings saved!",5)
```

### 3.2 GameNotify
Displays a notification near the top-left of the screen. A new notification replaces the previous one.

| Description | Argument | Required |
| --- | --- | --- |
| Notification text | `string` | yes |
| Duration in seconds | `number` | no |

If no duration is given, the notification remains until replaced or destroyed.

Return: `TextBox`

Example:
```lua
stand.GameNotify("StandUI loaded",3)
```

### 3.3 Prompt
Displays a prompt with optional buttons.

| Description | Argument | Required |
| --- | --- | --- |
| Prompt title | `string` | yes |
| Prompt text | `string` | yes |
| Prompt type | `number` | no |
| Button callback | `function` | no |

| Type | Buttons |
| --- | --- |
| `0` | None |
| `1` | OK |
| `2` | OK, CANCEL |
| `2` | YES, NO |
| `4` | YES, NO, CANCEL |

The callback receives the selected button's index, starting at 1.

Return: `TextLabel`

Example:
```lua
stand.Prompt("Confirmation","Reset settings?",3,function(index) print(index) end)
```

---

## 4. Notes

- I added a openurl function to utils but there's really little chances that it will resolve to anything. ~~I am not aware of a direct link opening function, meaning setting Link will only make the user copy the text.~~
- To add a new header, you must do the following:
1. Convert your image using [I2B64](https://github.com/solal0/I2B64)
2. Upload the generated lua file/it's content online or anywhere where you can access it.**
3. Using [Utils](https://github.com/solal0/Luau/blob/main/Tools/Utils.luau).toImage() or I2B64 lua script directly, convert the generated lua script
4. finally, add the converted image as a new header entry, e.g. stand.Headers["MyHeader"] = RESULT_OF_TOIMAGE

** If you're using StandUI in Roblox Studio, simply save the generated lua file in a modulescript and use require instead of loadstring.

---

## 5. Examples

### 5.1 Default Element
```lua
tab.NewAction("I'm a name",{Function = function() print("Hello, World!") end,Inform = "This option will print 'Hello, World!'",Command = {Name = "print",Info = "Prints Hello, World!"}})
```

### 5.2 Multiple Tabs
```lua
local player = stand.NewTab("Player")
local settings = stand.NewTab("Settings")
player.NewToggle("Enabled",{Default = true,Function = function(state) print(state) end})
settings.NewAction("About",{Display = stand.StandUI})
```

### 5.3 Categories
```lua
local movement = tab.NewCategory("Movement")
movement.NewValue("Walk Speed",0,100,{Default = 16,Speed = 1,Function = function(value) print(value) end})
local advanced = movement.NewCategory("Advanced")
advanced.NewSelector("Mode",{"Normal","Fast","Slow"},{Function = function(index,value) print(index,value) end})
```

### 5.4 Commands
```lua
tab.NewToggle("Godmode",{Command = {Name = "godmode",Info = "Toggle godmode"},Function = function(state) print(state) end})
tab.NewValue("Speed",0,100,{Default = 25,Command = {Name = "speed"},Function = function(value) print(value) end})
```

Command Box usage:
```
godmode on
speed 50
```

### 5.5 Changing Values
```lua
local value = tab.NewValue("Amount",0,100,{Default = 10})
local text = tab.NewText("Message",{Default = "Hello"})
local color = tab.NewColor("Theme",{Default = Color3.fromRGB(255,0,255)})
value.setValue(75)
text.setText("Hello, World!")
color.setHex("00FF00")
```

### 5.6 Keybinds
```lua
local key = tab.NewKey("Toggle Key",{Id = "KEY_TOGGLE",Key = Enum.KeyCode.F4})
key.setText("F5")
print(stand.Keys.KEY_TOGGLE)
```

### 5.7 Notifications and Prompts
```lua
tab.NewAction("Notify",{Function = function() stand.Notify("Hello, World!",3) end})
tab.NewAction("Confirm",{Function = function() stand.Prompt("Confirm","Continue?",2,function(index) print(index) end) end})
```

### 5.8 Menu Settings
```lua
stand.setName("My Menu")
stand.setHeader("Stand Minimalist")
stand.Notify("Menu ready",3)
```
