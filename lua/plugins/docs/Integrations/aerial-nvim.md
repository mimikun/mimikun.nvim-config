# Integrations

## stevearc/aerial.nvim

### folke/snacks.nvim

If you have [snacks.nvim](https://github.com/folke/snacks.nvim) installed, you can use the picker to find and jump to symbols.

```lua
require("aerial").snacks_picker()
```

You can pass in an options table that will get sent to `Snacks.picker.pick` directly. 
Use this to customize the display.

```lua
require("aerial").snacks_picker({
  layout = {
    preset = "dropdown",
    preview = false,
  }
})
```

### nvim-telescope/telescope.nvim

If you have [telescope](https://github.com/nvim-telescope/telescope.nvim) installed, there is an extension for fuzzy finding and jumping to symbols. 
It functions similarly to the builtin `lsp_document_symbols` picker, the main difference being that it uses the aerial backend for the source (e.g. LSP, treesitter, etc) and that it filters out some symbols (see the `filter_kind`
option).

You can activate the picker with `:Telescope aerial` or `:lua require("telescope").extensions.aerial.aerial()`

The extension can be customized with the following options:

```lua
require("telescope").setup({
  extensions = {
    aerial = {
      -- Set the width of the first two columns (the second
      -- is relevant only when show_columns is set to 'both')
      col1_width = 4,
      col2_width = 30,
      -- How to format the symbols
      format_symbol = function(symbol_path, filetype)
        if filetype == "json" or filetype == "yaml" then
          return table.concat(symbol_path, ".")
        else
          return symbol_path[#symbol_path]
        end
      end,
      -- Available modes: symbols, lines, both
      show_columns = "both",
    },
  },
})
```

If you want the command to autocomplete, you can load the extension first (this line must come after the setup section from above):

```lua
require("telescope").load_extension("aerial")
```

### ibhagwan/fzf-lua

If you have [fzf-lua](https://github.com/ibhagwan/fzf-lua/) installed, you can use the picker to find and jump to symbols.
It supports multi-select and uses the default actions from the `files` picker (e.g. `<C-s>` to open a symbol in a split).

```lua
require("aerial").fzf_lua_picker()
```

You can pass in an options table that will get sent to `require('fzf-lua').fzf_exec` directly. 
Use this to customize the display.

```lua
require("aerial").fzf_lua_picker({
  profile = 'ivy',
})
```

### junegunn/fzf.vim

If you have [fzf](https://github.com/junegunn/fzf.vim) installed you can trigger fuzzy finding with `:call aerial#fzf()`. To create a mapping:

```vim
nmap <silent> <leader>ds <cmd>call aerial#fzf()<cr>
```

### nvim-lualine/lualine.nvim

There is a lualine component to display the symbols for your current cursor position

```lua
require("lualine").setup({
  sections = {
    lualine_x = { "aerial" },

    -- Or you can customize it
    lualine_y = {
      {
        "aerial",
        -- The separator to be used to separate symbols in status line.
        sep = " ) ",

        -- The number of symbols to render top-down. In order to render only 'N' last
        -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
        -- be used in order to render only current symbol.
        depth = nil,

        -- When 'dense' mode is on, icons are not rendered near their symbols. Only
        -- a single icon that represents the kind of current symbol is rendered at
        -- the beginning of status line.
        dense = false,

        -- The separator to be used to separate symbols in dense mode.
        dense_sep = ".",

        -- Color the symbol icons.
        colored = true,
      },
    },
  },
})
```

