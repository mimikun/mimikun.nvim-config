### Input Settings

#### macOS Option Key is Meta

Possible values are `both`, `only_left`, `only_right`, `none`. 
Set to `none` by default.

```lua
vim.g.neovide_input_macos_option_key_is_meta = 'only_left'
```

**Available since 0.13.0.**

Interprets <kbd>Alt</kbd> + <kbd>whatever</kbd> actually as `<M-whatever>`, instead of sending the actual special character to Neovim.

#### IME

```lua
vim.g.neovide_input_ime = true
```

**Available since 0.11.0.**

This lets you disable the IME input. 
For example, to only enables IME in input mode and when searching, so that you can navigate normally, when typing some East Asian languages, you can add a few auto commands:

```lua
local function set_ime(args)
    if args.event:match("Enter$") then
        vim.g.neovide_input_ime = true
    else
        vim.g.neovide_input_ime = false
    end
end

local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime
})

vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime
})
```

#### macOS Multi-window (Editors)

**Available since 0.16.0.**

Neovide can show multiple windows on macOS either as separate OS windows or as native tabs inside a single host window.

Set `system-native-tabs = true` to merge windows into a tab group. 
The native tab bar stays hidden until more than one tab exists to keep a clean single-window look.

Use Window > New Window (default: `cmd+n`) or the Dock menu to open another Neovide window. 
If native tabs are enabled, new windows become tabs in the host window.

If you have native tabs enabled, the Window menu shows an Editors entry and the Editors hotkey becomes available. 
You can also remap the in-app tab cycling shortcuts.

#### macOS Global Activation Shortcuts

Neovide registers system-wide shortcuts on macOS:

- **Pinned** <kbd>⌘</kbd> + <kbd>⌃</kbd> + <kbd>Z</kbd> toggles the most recently used Neovide window. 
If that window is already active, the shortcut hides it; otherwise it brings the window to the front.
- **Editors** <kbd>⌘</kbd> + <kbd>⌃</kbd> + <kbd>N</kbd> opens the Editors (tab overview) view so you can pick another Neovide window. 
This shortcut is only available when `system-native-tabs = true` and if only one window exists, it behaves the same as the pinned shortcut.

Customize them by setting the environment variables:

```bash
launchctl setenv NEOVIDE_SYSTEM_PINNED_HOTKEY "ctrl+shift+z"
launchctl setenv NEOVIDE_SYSTEM_SWITCHER_HOTKEY "ctrl+shift+n"
```

Use `cmd`, `ctrl`, `alt`, and `shift` for modifiers and a single character for the key.

To disable a shortcut entirely, set the corresponding variable to `false` or leave it empty.

If a shortcut does not work, it may conflict with another global shortcut or be rejected by the system. 
Check the Neovide log for warnings.

You can also configure them inside `config.toml`:

```toml
system-pinned-hotkey = "ctrl+shift+z"
system-switcher-hotkey = "ctrl+shift+n"
```

You can also remap the macOS application and Window menu shortcuts:

```toml
system-hide-hotkey = "cmd+h"
system-hide-others-hotkey = "cmd+alt+h"
system-quit-hotkey = "cmd+q"
system-new-window-hotkey = "cmd+n"
system-minimize-hotkey = "cmd+m"
system-fullscreen-hotkey = "cmd+ctrl+f"
system-show-all-tabs-hotkey = "cmd+shift+e"
```

Set any of them to `false` (or an empty value) to remove the menu shortcut while keeping the menu item.

When `system-native-tabs` is enabled, you can also customize the in-app tab navigation shortcuts:

```toml
system-tab-prev-hotkey = "cmd+shift+["
system-tab-next-hotkey = "cmd+shift+]"
```

These work only while Neovide is focused so the keypress never reaches Neovim, mirroring the native macOS tab cycling workflow.

Set either value to `false` (or an empty value) to disable that shortcut and pass the keypress through to Neovim.

macOS may prompt you to grant Neovide Accessibility/Input Monitoring permissions the first time you use this feature so the shortcut can be detected outside the app.

#### Touch Deadzone

```lua
vim.g.neovide_touch_deadzone = 6.0
```

Setting `g:neovide_touch_deadzone` to a value equal or higher than 0.0 will set how many pixels the finger must move away from the start position when tapping on the screen for the touch to be interpreted as a scroll gesture.

If the finger stayed in that area once lifted or the drag timeout happened, however, the touch will be interpreted as tap gesture and the cursor will move there.

A value lower than 0.0 will cause this feature to be disabled and _all_ touch events will be interpreted as scroll gesture.

#### Touch Drag Timeout

```lua
vim.g.neovide_touch_drag_timeout = 0.17
```

Setting `g:neovide_touch_drag_timeout` will affect how many seconds the cursor has to stay inside `g:neovide_touch_deadzone` in order to begin "dragging"

Once started, the finger can be moved to another position in order to form a visual selection. 
If this happens too often accidentally to you, set this to a higher value like `0.3` or `0.7`.

