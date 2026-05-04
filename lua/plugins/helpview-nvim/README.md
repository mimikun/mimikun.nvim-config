```lua
{
    "OXY2DEV/helpview.nvim",
    branch = "dev",
    lazy = false
cmd="Helpview",
-- [mini.icons](https://github.com/echasnovski/mini.icons)
-- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
},
```

## 🧭 Configuration

```lua
--- Configuration for `helpview.nvim`.
---@class helpview.config
---
--- Preview options.
---@field preview? helpview.preview
---
--- Configuration options for vimdoc.
---@field vimdoc? helpview.vimdoc
---
--- Custom highlight groups.
---@field highlight_groups? table[]
---
--- Custom renderers
---@field renderers? { [string]: function }
local opts = {
	renderers = {},

	preview = {
		enable = true,
		enable_hybrid_mode = true,

		modes = { "n", "c", "no" },
		hybrid_modes = {},
		linewise_hybrid_mode = false,

		filetypes = { "help" },
		ignore_previews = {},
		ignore_buftypes = {},
		condition = nil,

		max_buf_lines = 500,
		draw_range = { 2 * vim.o.lines, 2 * vim.o.lines },
		edit_range = { 0, 0 },

		debounce = 150,
		callbacks = {},

         icon_provider = "internal", -- "mini" or "devicons"

		splitview_winopts = { split = "right" },
		preview_winopts = { width = math.floor(80) }
	},

    vimdoc = {
        arguments = {},
        code_blocks = {},
        headings = {},
        highlight_groups = {},
        horizontal_rules = {},
        inline_codes = {},
        keycodes = {},
        modelines = {},
        notes = {},
        optionlinks = {},
        tags = {},
        taglinks = {},
        urls = {}
    }
}
```

