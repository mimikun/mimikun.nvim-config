---@type table
local opts = {
  pack = "material",
  packs = require("plugins.real-icons-nvim.opts.packs"),
  overrides = require("plugins.real-icons-nvim.opts.overrides"),
  rules = require("plugins.real-icons-nvim.opts.rules"),
  --auto: detects Kitty Graphics Protocol compatible terminals
  --kitty: forces the Kitty Graphics Protocol renderer
  --disabled: forces glyph fallback
  ---@type string | "auto" | "kitty" | "disabled"
  backend = "auto",
  size = require("plugins.real-icons-nvim.opts.size"),
  color = require("plugins.real-icons-nvim.opts.color"),
  fallback = require("plugins.real-icons-nvim.opts.fallback"),
  integrations = require("plugins.real-icons-nvim.opts.integrations"),
}

return opts
