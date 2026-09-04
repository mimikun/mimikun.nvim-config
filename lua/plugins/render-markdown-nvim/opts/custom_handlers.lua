---@type table<string, render.md.Handler>
local custom_handlers = {
  -- Mapping from treesitter language to user defined handlers.
  -- @see [Custom Handlers](doc/custom-handlers.md)
  ---@class (exact) render.md.Handler
  ---@field extends? boolean
  ---@field parse fun(ctx: render.md.handler.Context): render.md.Mark[]

  ---@class (exact) render.md.handler.Context
  ---@field buf integer
  ---@field root TSNode
  ---@field last boolean
}

return custom_handlers
