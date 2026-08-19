local ui = {
  ---@type string | "floating" | "tabline"
  mode = "floating",

  floating = {
    -- See position options below
    position = "middle-right",

    -- Horizontal offset from position
    offset_x = 0,

    -- Vertical offset from position
    offset_y = 0,

    -- Character for collapsed dashes
    dash_char = "─",

    ---@type string | "rounded" | "single" | "double"
    border = "none",

    -- Padding around labels
    label_padding = 1,

    ---@type string | "dashed" | "filename" | "full" | nil
    minimal_menu = nil,

    -- nil (no limit) or number for pagination
    max_rendered_buffers = nil,
  },

  tabline = {
    -- Symbol shown when previous buffers exist
    left_page_symbol = "❮",

    -- Symbol shown when more buffers exist
    right_page_symbol = "❯",

    -- Separator between buffer components
    separator_symbol = "│",
  },
}

return ui
