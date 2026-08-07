-- Window settings
local window = {
  -- Size of the todo window: either a table `{ width = <n>, height = <n> }` or a function returning such a table.
  -- The function form is evaluated every time the window is opened, which allows sizes that adapt to the current editor dimensions,
  dimensions = function()
    return {
      -- Width of the floating window
      width = 55,
      --width = math.floor(vim.o.columns * 0.4),
      --width = math.max(40, math.floor(vim.o.columns * 0.4)),

      -- Height of the floating window
      height = 20,
      --height = math.floor(vim.o.lines * 0.6),
      --height = math.max(10, math.floor(vim.o.lines * 0.6)),
    }
  end,

  -- Border style:
  ---@type string | "single" | "double" | "rounded" | "solid"
  border = "rounded",

  -- Base z-index for floating windows (uses zindex to zindex+5)
  zindex = 50,

  -- Window position:
  ---@type string | "right" | "left" | "top" | "bottom" | "center" | "top-right" | "top-left" | "bottom-right" | "bottom-left"
  position = "center",

  padding = {
    top = 1,
    bottom = 1,
    left = 2,
    right = 2,
  },
}

return window
