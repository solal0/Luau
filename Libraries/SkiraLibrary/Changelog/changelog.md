DD/MM/2026 - 0.1: Created the library as well as Begin and Menu.

DD/MM/2026 - 0.2: Added Button, Toggle and Label. Added element tracking.

DD/MM/2026 - 0.3: Added Separator, Slider, ??? and Column. Renamed Menu to Window

DD/MM/2026 - 0.4: Updated Separator. Renamed ??? to Holder. Added Notify and syntaxes check.

DD/MM/2026 - 0.5: Added ColorPicker, Dropdown and Theme.

DD/MM/2026 - 0.6: Fixed ZIndex fight between ColorPicker and Dropdown.

DD/MM/2026 - 1.0: Initial release of the library and creation of the documentation.

DD/MM/2026 - 1.1: Added close callback to window.

11/06/2026 - 1.2: Added KeyPicker. Made all api's set function run the given callback.

11/06/2026 - 1.3: Added maxScale setting and a api to Dropdown as well as changing it's syntax and layout. Index was removed from every dropdown interaction.

11/06/2026 - 1.4: Added TextBox. Made Sliders label a textbox.

15/06/2026 - 1.5:
+ - made the set functions run the callback, added api to dropdown, added max height to dropdown
+ - added wrapped setting to label, added textbox, working on making sliders label textboxes
+ - fixed Windows being resizable when collapsed, changed notifications movement direction, added hover label setting on all options (setting is called hoverLabel), added information icon to the default config
+ - made slider callback a value instead of a string, made slider value show a decimal only if being one

01/07/2026 - 1.5.1: Fixed Window set function returning nil

02/07/2026 - 1.5.2: Added close function to Window and removed settings.size from Label since most, if not all elements use objectS and/or elementS setting for their height.

01/09/2026 - 1.5.3: Added brightness variable to lib:Theme() and fixed notification's text size

06/09/2026 - 1.5.4:
+ - Added Tab function and tabS to the config
+ - Added animated icon to the Demo
+ - Updated Theme function to no longer have a hardcoded table of each element's color
+ - Added Inactive attribute handling to buttons (setting a button to Inactive blocks the set button controls, e.g. hover color change, tween when clicked, callback, etc...)

06/09/2026 - 1.5.4.1: Changed tab's Content attribute to a value because some "environments" can't set an attribute to an instance.

08/09/2026 - 1.5.5:
+ - Added settings setting to Toggles.
+ - Created Utils to load icons (it only has a gear icon for now).
+ - KeyPicker button size is now as small as possible, just enough to fit MouseMiddleButton.
+ - Columns can now handle Scale number and UDim2 (only the X axis will be used)

08/09/2026 - 1.5.5.1:
+ - Removed Utils because it was useless.
+ - Added Floating attribute to ColorPickers and Toggle's setting window so when changing tab they get destroyed.
+ - Fixed ColorPicker element tracking, in clear, OK button is finally at the bottom.

09/09/2026 - 1.5.6:
+ - Updated the check function to check argument's classes and typeof instead of counting the number of arguments.
+ - Added nocheck setting to every element except Begin so elements like Dropdown and hoverLabel don't trigger errors when creating a Window.

10/09/2026 - 1.5.6.1:
+ - Fixed Toggle settings setting window collapsing when opened.
+ - Fixed ColorPicker color preview changing to red when clicked.
+ - Added a warn if Slider speed setting is set to 0 or lower.

11/09/2026 - 1.5.7:
+ - Added return if check function gives an error.
+ - Inverted Slider's min and max arguments (updated Demo).
+ - Updated Slider's textbox to look like ColorPicker textboxes and moved them slightly.

11/09/2026 - 1.5.8:
+ - Rewrote Dropdown entirely so it's list can go outside of the gui.
+ - Added exitkey and deletekey settings to KeyPicker, exitkey does the same thing as Escape (no key change) and deletekey sets the KeyPicker to None.
+ - Added a nil argument check to the check function.
