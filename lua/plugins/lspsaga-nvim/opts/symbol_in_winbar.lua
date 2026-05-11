---@type LspsagaConfig.Crumbs
local symbol_in_winbar = {
  -- Enable breadcrumbs
  ---@type boolean
  enable = true,

  -- Separator symbol
  ---@type string
  separator = " › ",

  -- when true some symbols like if and for;
  -- ignored if treesitter is not installed
  ---@type boolean
  hide_keyword = false,

  -- Filename patterns to ignore
  ---@type string[]
  ignore_patterns = nil,

  -- Show file name before symbols
  ---@type boolean
  show_file = true,

  -- Show how many folder layers before the file name
  ---@type integer
  folder_level = 1,

  -- mean the symbol name and icon have same color.
  -- Otherwise, symbol name is light-white
  ---@type boolean
  color_mode = true,

  -- Dynamic render delay
  ---@type integer
  delay = 300,
}

return symbol_in_winbar
