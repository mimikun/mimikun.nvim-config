---@type snacks.dim.Config
local dim = {
  ---@type snacks.scope.Config
  scope = {
    min_size = 5,
    max_size = 20,
    siblings = true,
  },
  ---@type snacks.animate.Config
  animate = {
    enabled = true,
    easing = "outQuad",
    duration = {
      -- ms per step
      step = 20,
      -- maximum duration
      total = 300,
    },
  },
  -- what buffers to dim
  filter = function(buf)
    return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
  end,
}

return dim
