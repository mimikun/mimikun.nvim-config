### Cursor Particles

There are a number of vfx modes you can enable which produce particles behind the cursor.
These are enabled by setting `g:neovide_cursor_vfx_mode` to one `string` or an `array` of the following constants.

```lua
vim.g.neovide_cursor_vfx_mode = {
-- None at all
    "",
-- Railgun
"railgun",
-- Torpedo
"torpedo",
-- Pixiedust
"pixiedust",
-- Sonic Boom
"sonicboom",
-- Ripple
"ripple",
-- Wireframe
"wireframe",
}
```

