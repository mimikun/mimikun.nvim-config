-- Configuration table for HTML preview.
---@type markview.config.html
local html = {
  -- Enable **HTML** rendering.
  ---@type boolean
  enable = nil,

  -- Configuration for container elements.
  ---@type markview.config.html.container_elements
  container_elements = require("plugins.markview-nvim.opts.html.container_elements"),

  -- Configuration for headings(e.g. `<h1>`).
  ---@type markview.config.html.headings
  headings = require("plugins.markview-nvim.opts.html.headings"),

  -- Configuration for void elements.
  ---@type markview.config.html.void_elements
  void_elements = require("plugins.markview-nvim.opts.html.void_elements"),
}

return html
