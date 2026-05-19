## Sources
### Source Selector

![Neo-tree source
selector](https://github.com/nvim-neo-tree/resources/raw/main/images/Neo-tree-source-selector.png)

You can enable a clickable source selector in either the winbar (requires neovim
0.8+) or the statusline. To do so, set one of these options to `true`:

```lua
    require("neo-tree").setup({
        source_selector = {
            winbar = false,
            statusline = false
        }
    })
```

There are many configuration options to change the style of these tabs.
See [lua/neo-tree/defaults.lua](lua/neo-tree/defaults.lua) for details.

### Preview Mode

`:h neo-tree-preview-mode`

Preview mode will temporarily show whatever file the cursor is on without
switching focus from the Neo-tree window. By default, files will be previewed
in a new floating window. This can also be configured to automatically choose
an existing split by configuring the command like this:

```lua
require("neo-tree").setup({
  window = {
    mappings = {
      ["P"] = {
        "toggle_preview",
        config = {
          use_float = false,
          -- use_image_nvim = true,
          -- use_snacks_image = true,
          -- title = 'Neo-tree Preview',
        },
      },
    }
  }
})
```

Anything that causes Neo-tree to lose focus will end preview mode. When
`use_float = false`, the window that was taken over by preview mode will revert
back to whatever was shown in that window before preview mode began.

You can choose a custom title for the floating window by setting the `title`
option in its config.

If you want to work with the floating preview mode window in autocmds or other
custom code, the window will have the `neo-tree-preview` filetype.

When preview mode is not using floats, the window will have the window local
variable `neo_tree_preview` set to `1` to indicate that it is being used as a
preview window. You can refer to this in statusline and winbar configs to mark a
window as being used as a preview.





Neo-tree is built on the idea of supporting various sources. Sources are
basically interface implementations whose job it is to provide a list of
hierarchical items to be rendered, along with commands that are appropriate to
those items.

