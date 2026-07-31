---@type ShelterUserConfig
local opts = {
  --- Appearance
  -- Character used for masking (default: "*")
  ---@type string
  mask_char = "*",

  -- Highlight group for masked text
  ---@type string
  highlight_group = "Comment",

  --- Behavior
  -- Don't mask commented lines
  -- Whether to skip masking in comments
  ---@type boolean
  skip_comments = true,

  -- Default masking mode
  -- With partial masking (show first/last characters)
  ---@type string | "full" | "partial" | "none"
  default_mode = "partial",

  -- Filetypes to mask (default: {"dotenv", "edf"})
  ---@type string[]
  env_filetypes = require("plugins.shelter-nvim.opts.env_filetypes"),

  -- Module toggles (see Modules section for details)
  ---@type ShelterModulesConfig
  modules = require("plugins.shelter-nvim.opts.modules"),

  -- Pattern-based mode selection
  -- Key patterns to mode mapping
  ---@type table<string, string>
  patterns = require("plugins.shelter-nvim.opts.patterns"),
  -- Source file-based mode selection
  -- Source file patterns to mode mapping
  ---@type table<string, string>
  sources = require("plugins.shelter-nvim.opts.sources"),

  -- Mode configuration (see Modes section)
  -- Mode configurations and custom mode definitions
  ---@type table<string, ShelterModeConfig>
  modes = require("plugins.shelter-nvim.opts.modes"),
}

return opts
