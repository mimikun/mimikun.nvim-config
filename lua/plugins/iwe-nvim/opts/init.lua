---@type IWE.Config
local opts = {
  -- Key mapping configuration
  ---@type IWE.Config.Mappings
  mappings = require("plugins.iwe-nvim.opts.mappings"),

  -- Picker backend configuration
  ---@type IWE.Config.Picker
  picker = require("plugins.iwe-nvim.opts.picker"),

  -- Preview generation configuration
  ---@type IWE.Config.Preview
  preview = require("plugins.iwe-nvim.opts.preview"),
}

return opts
