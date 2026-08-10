---@type LineJusticeConfig
local opts = {
  ---@type LineJusticeLineNumbers
  line_numbers = require("plugins.line-justice-nvim.opts.line_numbers"),

  ---@type LineJusticeWrappedLines
  wrapped_lines = require("plugins.line-justice-nvim.opts.wrapped_lines"),
}

return opts
