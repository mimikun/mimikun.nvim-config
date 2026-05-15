# Integrations

Plugins that complement nvim-tree functionality.

## [nvim-drawer](https://github.com/mikew/nvim-drawer)

nvim-drawer works with nvim-tree, and you can use it in place of nvim-tree's `view.side` / `view.width` / `tab.sync.open` / `tab.sync.close` options. This will get you a consistently sized nvim-tree across all your tabs that keeps itself in sync.

Example using lazy.nvim:

```lua
{
  'mikew/nvim-drawer',
  opts = {},
  config = function(_, opts)
    local drawer = require('nvim-drawer')
    drawer.setup(opts)

    drawer.create_drawer({
      -- This is needed for nvim-tree.
      nvim_tree_hack = true,

      -- Position on the right size of the screen.
      position = 'right',
      size = 40,

      -- Alternatively, you can have it floating.
      -- size = 40,
      -- position = 'float',
      -- win_config = {
      --   margin = 2,
      --   border = 'rounded',
      --   anchor = 'CE',
      --   width = 40,
      --   height = '80%',
      -- },

      on_vim_enter = function(event)
        --- Open the drawer on startup.
        event.instance.open({
          focus = false,
        })

        --- Example mapping to toggle.
        vim.keymap.set('n', '<leader>e', function()
          event.instance.focus_or_toggle()
        end)
      end,

      --- Ideally, we would just call this here and be done with it, but
      --- mappings in nvim-tree don't seem to apply when re-using a buffer in
      --- a new tab / window.
      on_did_create_buffer = function()
        local nvim_tree_api = require('nvim-tree.api')
        nvim_tree_api.tree.open({ current_window = true })
      end,

      --- This gets the tree to sync when changing tabs.
      on_did_open = function()
        local nvim_tree_api = require('nvim-tree.api')
        nvim_tree_api.tree.reload()

        vim.opt_local.number = false
        vim.opt_local.signcolumn = 'no'
        vim.opt_local.statuscolumn = ''
      end,

      --- Cleans up some things when closing the drawer.
      on_did_close = function()
        local nvim_tree_api = require('nvim-tree.api')
        nvim_tree_api.tree.close()
      end,
    })
  end
}
```

# Extension Plugins

Plugins for nvim-tree that add functionality.

## [nvim-lsp-file-operations](https://github.com/antosha417/nvim-lsp-file-operations)

LSP File Operations is an extension to `nvim-tree.lua` that adds support for file operations using built-in [LSP support](https://neovim.io/doc/user/lsp.html).

It automatically applies any necessary workspace edits when performing file operations. So something like imports and package names would be fixed automatically when you rename or move files if your lsp server supports it.  

## [nvim-tree.lua-float-preview](https://github.com/JMarkin/nvim-tree.lua-float-preview)

**Float Preview:** various `api.node.open`, `api.tree` and `api.fs` operations will use a floating window.

See `on_attach` example provided.

## [nvim-tree-preview.lua](https://github.com/b0o/nvim-tree-preview.lua)

Alternative to nvim-tree.lua-float-preview.

# Color Schemes

Sets nvim-tree specific highlight groups which may be configured or overridden.

[mini.base16](https://github.com/echasnovski/mini.base16)

[Catppuccin](https://github.com/catppuccin/nvim)

