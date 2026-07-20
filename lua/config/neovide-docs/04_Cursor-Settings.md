### Cursor Settings

#### Animation Length

```lua
vim.g.neovide_cursor_animation_length = 0.150
```

Setting `g:neovide_cursor_animation_length` determines the time it takes for the cursor to complete its animation in seconds. 
Set to `0` to disable.

#### Short Animation Length

```lua
vim.g.neovide_cursor_short_animation_length = 0.04
```

Setting `g:neovide_cursor_short_animation_length` determines the time it takes for the cursor to complete its animation in seconds for short horizontal travels of one or two characters, like when typing.

#### Animation Trail Size

```lua
vim.g.neovide_cursor_trail_size = 1.0
```

Range 0.0 to 1.0

Setting `g:neovide_cursor_trail_size` changes how much the back of the cursor trails the front. 
Set to 1.0 to make the front jump to the destination immediately with a maximum trail size. 
A lower value makes a smoother animation, with a shorter trail, but also adds lag.

#### Antialiasing

```lua
vim.g.neovide_cursor_antialiasing = true
```

Enables or disables antialiasing of the cursor quad. 
Disabling may fix some cursor visual issues.

#### Animate in insert mode

```lua
vim.g.neovide_cursor_animate_in_insert_mode = true
```

If disabled, when in insert mode (mostly through `i` or `a`), the cursor will move like in other programs and immediately jump to its new position.

#### Animate switch to command line

```lua
vim.g.neovide_cursor_animate_command_line = true
```

If disabled, the switch from editor window to command line is non-animated, and the cursor jumps between command line and editor window immediately. 
Does **not** influence animation inside of the command line.

#### Unfocused Outline Width

```lua
vim.g.neovide_cursor_unfocused_outline_width = 0.125
```

Specify cursor outline width in `em`s. 
You probably want this to be a positive value less than 0.5.
If the value is \<=0 then the cursor will be invisible. 
This setting takes effect when the editor window is unfocused, at which time a block cursor will be rendered as an outline instead of as a full rectangle.

#### Animate cursor blink

```lua
vim.g.neovide_cursor_smooth_blink = false
```

If enabled, the cursor will smoothly animate the transition between the cursor's on and off state.
The built in `guicursor` neovim option needs to be configured to enable blinking by having a value set for both `blinkoff`, `blinkon` and `blinkwait` for this setting to apply.

#### Use covered cell colors for cursor fallback

```lua
vim.g.neovide_cursor_cell_color_fallback = false
```

If enabled, Neovide will use the resolved colors of the grid cell under the cursor when the `guicursor` highlight does not explicitly define cursor foreground or background colors. 
This makes the block cursor adapt to the text highlighting beneath it. 
Explicit cursor colors still take precedence.

