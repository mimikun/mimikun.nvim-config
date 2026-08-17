-- Disabled: another plugin in this config already owns the feature.
-- smear-cursor-nvim
---@type snacks.scroll.Config
local scroll = {
  enabled = false,

  ---@type snacks.animate.Config | {}
  animate = {
    duration = {
      step = 10,
      total = 200,
    },

    easing = "linear",
  },

  -- faster animation when repeating scroll after delay
  ---@type snacks.animate.Config | {} | {delay:number}
  animate_repeat = {
    -- delay in ms before using the repeat animation
    delay = 100,

    duration = {
      step = 5,
      total = 50,
    },

    easing = "linear",
  },

  -- what buffers to animate
  filter = function(buf)
    return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
  end,
}

return scroll
