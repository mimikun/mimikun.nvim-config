This page is for changes to the look and feel of the plugin. Things like colors, dynamic sizing or positioning, etc.

## Hide Cursor in Neo-tree window

From: https://github.com/nvim-neo-tree/neo-tree.nvim/issues/155#issuecomment-1081338852
```lua
  require('neo-tree').setup({
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          -- This effectively hides the cursor
          vim.cmd 'highlight! Cursor blend=100'
        end
      },
      {
        event = "neo_tree_buffer_leave",
        handler = function()
          -- Make this whatever your current Cursor highlight group is.
          vim.cmd 'highlight! Cursor guibg=#5f87af blend=0'
        end
      }
    },
  })
```

## Floating Window Settings

### Float Right

This is a nice look where the sidebar will float to the right, positioned like a right hand sidebar but floating. One side effect of this layout is that it will automatically close the tree after you open a file.

![NeoTreeFloat on right](https://github.com/nvim-neo-tree/resources/raw/main/images/Neo-tree-float-right.png)

```lua
      require("neo-tree").setup({
        filesystem = {
          window = {
            popup = {
              position = { col = "100%", row = "2" },
              size = function(state)
                local root_name = vim.fn.fnamemodify(state.path, ":~")
                local root_len = string.len(root_name) + 4
                return {
                  width = math.max(root_len, 50),
                  height = vim.o.lines - 6
                }
              end
            },
          }
        }
      })
```
The above configuration uses a function to return the size so the height can be adjusted. It will also dynamically change the width to show the entire root path if it is long.

## Colour Scheme

If a colour scheme supports nvim-tree but not neo-tree (e.g gruvbox-material) some of the highlights can be linked with the following:

```lua
vim.cmd([[
highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
highlight! link NeoTreeDirectoryName NvimTreeFolderName
highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
highlight! link NeoTreeRootName NvimTreeRootFolder
highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile
]])
```