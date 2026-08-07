# Integrations

## Mirsmog/real-icons.nvim

All integrations are opt-in.

### akinsho/bufferline.nvim

```lua
require("bufferline").setup(require("real-icons.integrations.bufferline").opts())
```

### ibhagwan/fzf-lua

```lua
require("fzf-lua").setup(require("real-icons.integrations.fzf_lua").opts())
```

The adapter preserves the configured fzf-lua layout and search pipeline. It
reserves an icon slot and renders only entries visible in the embedded fzf
window. Native fzf-tmux windows cannot display Neovim extmarks and keep the
lightweight fallback slot.

### nvim-lualine/lualine.nvim

```lua
require("lualine").setup({
  sections = {
    lualine_c = {
      require("real-icons.integrations.lualine").component,
      "filename",
    },
  },
})
```

### nvim-mini/mini.files

```lua
require("mini.files").setup(require("real-icons.integrations.mini_files").opts())
```

### nvim-neo-tree/neo-tree.nvim

```lua
require("neo-tree").setup(require("real-icons.integrations.neo_tree").opts())
```

### nvim-telescope/telescope-file-browser.nvim

```lua
require("telescope").setup({
  extensions = {
    file_browser = {
      entry_maker = require("real-icons.integrations.telescope_file_browser").entry_maker,
    },
  },
})
require("telescope").load_extension("file_browser")
```

The adapter wraps the extension's upstream entry maker. Caching,
multi-selection, git and stat columns, and resize handling stay upstream.
