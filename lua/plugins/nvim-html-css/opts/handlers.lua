---@type Handlers
local handlers = {
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
}

return handlers
