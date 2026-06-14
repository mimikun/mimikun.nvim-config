---@field use_as_default_explorer boolean

---@type fyler.Config
local opts = {
  -- Whether to skip confirmation for "simple" mutations.
  -- A simple mutation has at most:
  -- - 1 copy operation
  -- - 1 delete operation
  -- - 1 move operation
  -- - 5 create operations
  ---@type boolean
  auto_confirm_simple_mutation = false,

  -- Restricts cursor from moving outside editable region
  ---@type boolean
  bound_cursor = true,

  -- Buffer-local options applied to the finder buffer (see: nvim_set_option_value)
  ---@type table<string, any>
  buf_opts = {},

  -- Follow current file
  ---@type boolean
  follow_current_file = true,

  -- List of extensions to enable (e.g., 'git', 'trash')
  ---@type string[]
  extensions = {
    git = {
      enabled = true,
      -- if you want icons to be right aligned
      --inline = false,
    },
    trash = {
      enabled = true,
    },
  },
  -- Event hooks for custom behavior (on_highlight, on_delete, on_rename)
  ---@type fyler.HooksConfig
  hooks = {},

  ---@class fyler.HooksConfig
  ---@field on_delete fun(path: string)|nil
  ---@field on_highlight fun(highlights: table, palette: table)|nil
  ---@field on_rename fun(old_path: string, new_path: string)|nil
  -- External integrations (e.g., icon provider)
  ---@type table
  integrations = {
    icon = "nvim_web_devicons",
    --icon = 'mini_icons',
    --icon = 'vim_nerdfont`',
  },

  -- Window-local options applied to the finder window (see: nvim_set_option_value)
  ---@type table<string, any>
  win_opts = {},

  -- Buffer kind to use globally.
  ---@type fyler.FinderWindowKind
  kind = "replace",

  -- Per-kind preset overrides.
  -- Each preset can contain mappings, buf_opts, win_opts,
  -- and any window layout fields (width, height, border, etc.).
  ---@type table<string, fyler.KindPresetConfig>
  kind_presets = require("plugins.fyler-nvim.opts.kind_presets"),

  -- Key mappings organized by mode (see: fyler.Mapping)
  ---@type table<string, table<string, fyler.Mapping>>
  mappings = require("plugins.fyler-nvim.opts.mappings"),

  -- UI configuration
  ---@type fyler.UiConfig
  ui = require("plugins.fyler-nvim.opts.ui"),
}

return opts
