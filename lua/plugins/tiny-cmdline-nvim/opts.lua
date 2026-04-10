---@type TinyCmdlineConfig
local opts = {
  -- Cmdline window width
  ---@type TinyCmdlineWidthConfig
  width = {
    -- "N%" = fraction of editor columns, integer = absolute columns
    ---@type string|integer Width: "60%" = fraction of editor columns, integer = absolute columns
    value = "70%",
    -- minimum width in columns
    ---@type integer Minimum width in columns
    min = 40,
    -- maximum width in columns
    ---@type integer Maximum width in columns
    max = 80,
  },

  -- Window position ("N%" = fraction of available space, integer = absolute columns/rows)
  ---@type TinyCmdlinePositionConfig
  position = {
    -- horizontal: "0%" = left, "50%" = center, "100%" = right
    ---@type string|integer Horizontal position: "50%" = center, integer = absolute columns from left
    x = "50%",
    -- vertical:   "0%" = top,  "50%" = center, "100%" = bottom
    ---@type string|integer Vertical position: "50%" = center, integer = absolute rows from top
    y = "50%",
  },

  -- Border style for the floating window
  -- nil inherits vim.o.winborder at setup() time, falling back to "rounded"
  -- Set to "none" to disable the border
  ---@type string|nil nil = inherit vim.o.winborder at setup() time
  border = nil,

  -- Horizontal offset of the completion menu anchor from the window's left inner edge
  -- Used to align blink.cmp / nvim-cmp menus with the cmdline window
  ---@type integer Completion menu offset from the window's left inner edge
  menu_col_offset = 3,

  -- Cmdline types rendered at the bottom of the screen instead of centered
  -- "/" and "?" (search) are kept native by default
  ---@type string[] Types shown at the bottom instead of centered (e.g. "/", "?")
  native_types = {
    "/",
    "?",
  },

  -- Optional callback invoked after every reposition
  ---@type fun()|nil Called after every reposition
  on_reposition = function()
    return nil
  end,
}

return opts
