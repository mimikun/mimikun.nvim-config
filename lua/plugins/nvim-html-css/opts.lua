---@type Config
local opts = {
  ---@type table<string>
  enable_on = require("plugins.nvim-html-css.ft"),

  ---@type Handlers
  handlers = {
    ---@type Definition
    definition = {
      ---@type string
      bind = "gd",
    },

    ---@type Hover
    hover = {
      ---@type string
      bind = "K",

      ---@type boolean
      wrap = true,

      ---@type string
      border = "none",

      ---@type string
      position = "cursor",
    },
  },

  ---@type Documentation
  documentation = {
    ---@type boolean
    auto_show = true,
  },

  ---@type Peek
  peek = {
    ---@type boolean
    enabled = true,

    ---@type string | "rounded" | "single" | "double" | "shadow" | "none"
    border = "rounded",

    ---@type string | "cursor" | "center"
    position = "center",

    -- fraction of editor width (0.0–1.0)
    ---@type number
    width = 0.5,

    -- fraction of editor height (0.0–1.0)
    ---@type number
    height = 0.5,

    -- whether the float steals focus on open
    ---@type boolean
    focus = true,

    ---@type string
    style = "minimal",
  },

  ---@type table<string>
  style_sheets = {
    "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
    "https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
    -- `./` refers to the current working directory.
    "./index.css",
  },
}

return opts
