---@type table
local opts = {
  enable_on = require("plugins.nvim-html-css.ft"),
  handlers = {
    definition = {
      bind = "gd",
    },
    hover = {
      bind = "K",
      wrap = true,
      border = "none",
      position = "cursor",
    },
  },
  documentation = {
    auto_show = true,
  },
  peek = {
    enabled = true,
    border = "rounded",
    position = "center", -- "center" | "cursor"
    width = 0.5, -- fraction of editor width (0.0–1.0)
    height = 0.5, -- fraction of editor height (0.0–1.0)
    focus = true, -- whether the float steals focus on open
    style = "minimal",
  },
  style_sheets = {
    "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
    "https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
    "./index.css", -- `./` refers to the current working directory.
  },
}

return opts
