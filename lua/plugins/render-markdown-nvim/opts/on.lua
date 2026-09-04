---@type render.md.on.Config
local on = {
  -- Called when plugin initially attaches to a buffer.
  ---@type fun(ctx: render.md.on.attach.Context)
  attach = function(_ctx)
    ---@field buf integer
  end,

  -- Called before adding marks to the buffer for the first time.
  ---@type fun(ctx: render.md.on.render.Context)
  initial = function(_ctx)
    ---@field buf integer
    ---@field win integer
  end,

  -- Called after plugin renders a buffer.
  ---@type fun(ctx: render.md.on.render.Context)
  render = function(_ctx)
    ---@field buf integer
    ---@field win integer
  end,

  -- Called after plugin clears a buffer.
  ---@type fun(ctx: render.md.on.render.Context)
  clear = function(_ctx)
    ---@field buf integer
    ---@field win integer
  end,
}

return on
