---@type nvumi.Options
local opts = {
  ---@type string | "newline" | "inline"
  virtual_text = "newline",

  -- prefix shown before the output
  ---@type string
  prefix = " = ",

  ---@type string | "iso" | "uk" | "us" | "long"
  date_format = "iso",

  -- window width: 0–1 = fraction of terminal, >1 = absolute columns
  ---@type number
  width = 0.4,

  -- window height: 0–1 = fraction of terminal, >1 = absolute lines
  ---@type number
  height = 0.4,

  ---@type nvumi.Keys
  keys = require("plugins.nvumi.opts.opts_keys"),

  ---@type table
  custom_conversions = require("plugins.nvumi.opts.custom_conversions"),

  ---@type table
  custom_functions = require("plugins.nvumi.opts.custom_functions"),
}

return opts
