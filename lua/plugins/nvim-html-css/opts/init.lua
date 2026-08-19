---@type Config
local opts = {
  ---@type table<string>
  enable_on = require("plugins.nvim-html-css.ft"),

  ---@type Handlers
  handlers = require("plugins.nvim-html-css.opts.handlers"),

  ---@type Documentation
  documentation = require("plugins.nvim-html-css.opts.documentation"),

  ---@type table<string>
  style_sheets = require("plugins.nvim-html-css.opts.style_sheets"),
}

return opts
