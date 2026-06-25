-- Floating cmdline (Neovim 0.12+ ui2). Set to false to disable.
---@type JuuCmdlineConfig | false | nil
local cmdline = {
  -- Set to false to disable floating cmdline (default: true)
  ---@type boolean | nil
  enabled = true,

  ---@field width JuuCmdlineWidthConfig

  ---@field position JuuCmdlinePositionConfig

  -- nil = inherit vim.o.winborder at setup() time
  ---@field border string|nil

  -- Completion menu offset from the window's left inner edge
  ---@field menu_col_offset integer

  -- Types shown full-width at the bottom instead of centered (e.g. "/", "?").
  -- Default {} applies the floating style to all cmdline types including search.
  ---@field native_types string[]

  -- Called after every reposition
  ---@field on_reposition fun()|nil
}

return cmdline

---@class JuuCmdlineWidthConfig
---@field value string|integer Width: "60%" = fraction of editor columns, integer = absolute columns
---@field min integer Minimum width in columns
---@field max integer Maximum width in columns

---@class JuuCmdlinePositionConfig
---@field x string|integer Horizontal position: "50%" = center, integer = absolute columns from left
---@field y string|integer Vertical position: "50%" = center, integer = absolute rows from top
