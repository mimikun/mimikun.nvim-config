---@type Navbuddy.config
local opts = {
  ---@type WindowConfig
  window = require("plugins.nvim-navbuddy.opts.window"),

  ---@type table<number, string>
  icons = require("plugins.nvim-navbuddy.opts.icons"),

  -- If set to false, only mappings set
  ---@type boolean
  use_default_mappings = true,

  -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
  -- Which integrations to enable
  ---@type Integrations
  integrations = {
    -- Requires you to have `nvim-telescope/telescope.nvim` installed.
    ---@type boolean
    telescope = nil,

    -- Requires you to have `folke/snacks.nvim` installed.
    ---@type boolean
    snacks = nil,
  },

  -- by user are set.
  -- Else default mappings are used for keys that are not set by user
  ---@type table<string, KeyMapping>
  mappings = require("plugins.nvim-navbuddy.opts.mappings"),

  ---@type LspConfig
  lsp = {
    -- If set to true, you don't need to manually use attach function
    ---@type boolean
    auto_attach = false,

    -- list of lsp server names in order of preference
    ---@type string[]
    preference = nil,
  },

  ---@type SourceBufferConfig
  source_buffer = {
    -- Keep the current node in focus on the source buffer
    ---@type boolean
    follow_node = true,

    -- Highlight the currently focused node
    ---@type boolean
    highlight = true,

    ---@type string | "smart" | "top" | "mid" | "none"
    reorient = "smart",

    -- scrolloff value when navbuddy is open
    ---@type number
    scrolloff = nil,
  },

  ---@type NodeMarkersConfig
  node_markers = {
    ---@type boolean
    enabled = true,

    ---@type NodeMarkersIcons
    icons = {
      ---@type string
      leaf = "  ",

      ---@type string
      leaf_selected = " → ",

      ---@type string
      branch = " ",
    },
  },

  -- "Visual" or any other hl group to use instead of inverted colors
  ---@type string
  custom_hl_group = nil,
}

return opts
