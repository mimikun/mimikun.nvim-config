-- Configuration for vim:modeline:.
---@type vimdoc.modelines
local modelines = {
  -- When `false`, modeline won't be rendered.
  ---@type boolean
  enable = true,

  -- Character to use as the borders.
  ---@type string
  border = "─",

  -- Highlight group for the `border`.
  ---@type string
  border_hl = "@text.todo.unchecked",

  -- Configuration for various **data-types**.
  ---@type { [string]: { option_hl: string?, value_hl: string? } }
  data_types = {
    ["nil"] = { value_hl = "@constant.builtin" },
    ["string"] = { value_hl = "String" },
    ["number"] = { value_hl = "Number" },
    ["boolean"] = { value_hl = "Boolean" },
  },

  -- Configuration for various options.
  ---@type { option_hl: string?, value_hl: string? }
  default = {
    option_hl = "@property",
    value_hl = "Comment",
  },

  -- Configuration for various options.
  ---@field [string] { option_hl: string?, value_hl: string? }
}

return modelines
