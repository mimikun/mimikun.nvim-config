-- edgebar animations
local animate = {
  enabled = true,
  -- frames per second
  fps = 100,
  -- cells per second
  cps = 120,
  on_begin = function()
    vim.g.minianimate_disable = true
  end,
  on_end = function()
    vim.g.minianimate_disable = false
  end,
  -- Spinner for pinned views that are loading.
  -- if you have noice.nvim installed, you can use any spinner from it, like:
  -- spinner = require("noice.util.spinners").spinners.circleFull,
  spinner = {
    frames = {
      "⠋",
      "⠙",
      "⠹",
      "⠸",
      "⠼",
      "⠴",
      "⠦",
      "⠧",
      "⠇",
      "⠏",
    },
    interval = 80,
  },
}

return animate
