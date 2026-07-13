---@type render.md.on.Config
local on = {
  -- Called when plugin initially attaches to a buffer.
  ---@type fun(ctx: render.md.on.attach.Context)
  attach = function()
    -- TODO: it
  end,

  -- Called before adding marks to the buffer for the first time.
  ---@type fun(ctx: render.md.on.attach.Context)
  initial = function()
    -- TODO: it
  end,

  -- Called after plugin renders a buffer.
  ---@type fun(ctx: render.md.on.attach.Context)
  render = function()
    -- TODO: it
  end,

  -- Called after plugin clears a buffer.
  ---@type fun(ctx: render.md.on.attach.Context)
  clear = function()
    -- TODO: it
  end,
}

return on
