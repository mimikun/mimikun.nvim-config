---@type markview.config
local opts = {
  ---@type markview.config.experimental
  experimental = require("plugins.markview-nvim.opts.experimental"),

  ---@type markview.config.html
  html = require("plugins.markview-nvim.opts.html"),

  ---@type markview.config.latex
  latex = require("plugins.markview-nvim.opts.latex"),

  ---@type markview.config.markdown
  markdown = require("plugins.markview-nvim.opts.markdown"),

  ---@type markview.config.markdown_inline
  markdown_inline = require("plugins.markview-nvim.opts.markdown_inline"),

  ---@type markview.config.preview
  preview = require("plugins.markview-nvim.opts.preview"),

  ---@type table<string, function>
  renderers = require("plugins.markview-nvim.opts.renderers"),

  ---@type markview.config.typst
  typst = require("plugins.markview-nvim.opts.typst"),

  ---@type markview.config.yaml
  yaml = require("plugins.markview-nvim.opts.yaml"),
}

return opts
