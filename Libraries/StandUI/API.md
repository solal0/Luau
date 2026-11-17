I'm writing rn...

# Stand UI API
StandUI is a luau ui library for roblox. It uses the same style and elements as the GTAV Mod Menu [Stand](https://stand.sh).

## Credits
- Me, solal0/Skira
- Stand's developer team

## API
If anything goes wrong, file an issue or find a way to contact me, ty.
<br>The usage of `stand` and `tab` comes from:
```lua
local stand = loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Libraries/StandUI/stand.luau"))()
local tab = stand.NewTab("Tab")
```

## 1. Structure

### 1.1. Informations
Every element (except separator) have 4 settings in common:
| Setting | Description | Arguments | Return |
| --- | --- | --- | --- |
| `Name` | The option's name, the first argument of all elements | `string` | `nil` |
| `Settings.Command` | Adds a command to the Command Box | `{Name = string, Info = string?}` | `nil` |
| `Settings.Inform` | Shows a label below tabs when the option is selected | `string` | `nil` |
| `Settings.Function` | The function called when the set command is called or when the option receives KEY_ENTER | `function` | Depends |

See Examples (5) to view the exact syntax.

Anything set within the setting's table is optional.

### 1.2. Command Box

### 1.3. Returned Functions
```lua
stand.unload() -- Destroy the ui and disconnect all connections
stand.load(table) -- Soon to come
stand.setName(string) -- Changes the title to whatever you want
stand.setHeader(string) -- string must be a valid header name
stand.NewTab(string) -- Creates a tab, see Elements (2) for more informations
```

### 1.4. Returned Variables
```lua
stand.Gui -- The ui's ScreenGui
stand.Bar -- The title bar
stand.Main -- Frame containing the menu
stand.Keys -- A table containing created and stand's internal keys.
stand.Headers -- A table containing headers, see Notes (4) to add/create one
stand.StandUI -- Current version
```

---

## 2. Elements

### 2.1 NewAction
Creates a multifunction element who can copy text to clipboard, open links or display text.

| Description | Argument | Required |
| --- | --- | --- |
| Element's name | `string` | yes |
| Table of settings | `table` | no |

Setting's Table:
| Setting | Description | Value
| --- | --- | --- |
| `Link` | Will try to open the given url in a browser and copy the url to clipboard as a fallback | `string` |
| `Display` | Display text on the right while the name is on the right. | `string` |
| `Clipboard` | Copies the set text to the user's clipboard. | `string` |
| `Function` | If clipboard or link is set, the given function won't be called. | `function` |
| `Command` | Adds a command to the Command Box | `{Name = string, Info = string?}` |
| `Inform` | Shows a label below tabs when the option is selected | `string` |

### 2.2 NewToggle
Creates a toggleable (on/off) element.

| Description | Argument | Required |
| --- | --- | --- |
| Element's name | `string` | yes |
| Table of settings | `table` | no |

Setting's Table:
| Setting | Description | Value
| --- | --- | --- |
| `Default` | Default toggle state when created | `boolean` |
| `Function` | Will be called with the current toggle state | `function` |
| `Command` | Adds a command to the Command Box | `{Name = string, Info = string?}` |
| `Inform` | Shows a label below tabs when the option is selected | `string` |

### 2.3 NewValue
Creates a toggleable (on/off) element.

| Description | Argument | Required |
| --- | --- | --- |
| Element's name | `string` | yes |
| Minimum value | `number` | yes |
| Maximum value | `number` | yes |
| Table of settings | `table` | no |

Setting's Table:
| Setting | Description | Value
| --- | --- | --- |
| `Default` | Default toggle state when created | `boolean` |
| `Function` | Will be called with the current toggle state | `function` |
| `Command` | Adds a command to the Command Box | `{Name = string, Info = string?}` |
| `Inform` | Shows a label below tabs when the option is selected | `string` |

---

## 3. Notifications

---

## 4. Notes

- I am not aware of a direct link opening function, meaning setting Link will only make the user copy the text.

---

## 5. Examples

5.1 Default Element
```lua
tab.NewAction("I'm a name",{Function = function() print("Hello, World!") end, Inform = "This option will print 'Hello, World!'", Command = {Name = "print", Info = }})
```
