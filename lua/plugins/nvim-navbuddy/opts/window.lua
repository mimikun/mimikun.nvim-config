---@type WindowConfig
local window = {
  -- "rounded", "double", "solid", "none" or an array with eight chars building up the border in a clockwise fashion starting with the top-left corner.
  -- eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
  ---@type BorderConfig | string | "double" | "none" | "rounded" | "shadow" | "single" | "solid" | "default" | nui_popup_border_options
  border = "single",

  -- Or table format example: { height = "40%", width = "100%"}
  ---@type number | string | nui_layout_option_size
  size = "60%",

  -- Or table format example: { row = "100%", col = "0%"}
  ---@type string
  position = "50%",

  -- scrolloff value within navbuddy window
  ---@type number
  scrolloff = nil,

  ---@type { left?: WindowSectionConfig, mid?: WindowSectionConfig, right?: WindowSectionConfig }
  sections = {
    ---@type WindowSectionConfig
    left = {
      -- You can set border style for each section individually as well.
      ---@type BorderConfig | string | "double" | "none" | "rounded" | "shadow" | "single" | "solid" | "default" | nui_popup_border_options
      border = nil,

      ---@type string
      size = "20%",

      -- list of window options for each section individually.
      ---@type table<string, any>
      win_options = nil,
    },

    ---@type WindowSectionConfig
    mid = {
      ---@type BorderConfig | string | "double" | "none" | "rounded" | "shadow" | "single" | "solid" | "default" | nui_popup_border_options
      border = nil,

      ---@type string
      size = "40%",

      ---@type table<string, any>
      win_options = {
        -- Uncomment this line if you want see the number
        --number = true,
        --relativenumber = true,
      },
    },

    ---@type WindowSectionConfig
    right = {
      -- No size option for right most section.
      -- It fills to remaining area.
      ---@type BorderConfig | string | "double" | "none" | "rounded" | "shadow" | "single" | "solid" | "default" | nui_popup_border_options
      border = nil,

      -- Right section can show previews too.
      ---@type string | "always" | "leaf" | "never"
      preview = "leaf",

      -- "leaf": Right section can show previews too.
      ---@type table<string, any>
      win_options = nil,
    },
  },
}

return window
