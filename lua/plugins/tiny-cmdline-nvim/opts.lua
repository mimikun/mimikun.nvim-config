---@type TinyCmdlineConfig
local opts = {
  -- Cmdline window width
  ---@type TinyCmdlineWidthConfig
  width = {
    -- "N%" = fraction of editor columns, integer = absolute columns
    -- Width: "60%" = fraction of editor columns, integer = absolute columns
    ---@type string | integer
    value = "70%",

    -- minimum width in columns
    -- Minimum width in columns
    ---@type integer
    min = 40,

    -- maximum width in columns
    -- Maximum width in columns
    ---@type integer
    max = 80,
  },

  -- Window position ("N%" = fraction of available space, integer = absolute columns/rows)
  ---@type TinyCmdlinePositionConfig
  position = {
    -- horizontal: "0%" = left, "50%" = center, "100%" = right
    -- Horizontal position: "50%" = center, integer = absolute columns from left
    ---@type string | integer
    x = "50%",

    -- vertical:   "0%" = top,  "50%" = center, "100%" = bottom
    -- Vertical position: "50%" = center, integer = absolute rows from top
    ---@type string | integer
    y = "50%",
  },

  -- Border style for the floating window
  -- nil inherits vim.o.winborder at setup() time, falling back to "rounded"
  -- Set to "none" to disable the border
  -- nil = inherit vim.o.winborder at setup() time
  ---@type string | nil
  border = nil,

  -- Horizontal offset of the completion menu anchor from the window's left inner edge
  -- Used to align blink.cmp / nvim-cmp menus with the cmdline window
  -- Completion menu offset from the window's left inner edge
  ---@type integer
  menu_col_offset = 3,

  -- Cmdline types rendered at the bottom of the screen instead of centered
  -- "/" and "?" (search) are kept native by default
  -- Types shown at the bottom instead of centered (e.g. "/", "?")
  ---@type string[]
  native_types = {
    "/",
    "?",
  },

  -- Optional callback invoked after every reposition
  -- Called after every reposition
  ---@type fun() | nil
  on_reposition = function()
    return nil
  end,
}

return opts
