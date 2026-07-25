---@type table
local opts = {
  colors = {
    -- Optional bg param, defaults to Normal hl group
    bg = "",
    copy = "#f5c359",
    delete = "#c75c6a",
    -- Optional param, defaults to delete
    change = "#c75c6a",
    format = "#c79585",
    insert = "#78ccc5",
    replace = "#245361",
    -- Optional param, defaults to visual
    select = "#9745be",
    visual = "#9745be",
  },

  -- Set opacity for cursorline and number background
  line_opacity = {
    copy = 0.15,
    delete = 0.15,
    change = 0.15,
    format = 0.15,
    insert = 0.15,
    replace = 0.15,
    select = 0.15,
    visual = 0.15,
  },

  -- Enable cursor highlights
  set_cursor = true,

  -- Enable cursorline initially, and disable cursorline for inactive windows or ignored filetypes
  set_cursorline = true,

  -- Enable line number highlights to match cursorline
  set_number = true,

  -- Enable sign column highlights to match cursorline
  set_signcolumn = true,

  -- Disable modes highlights for specified filetypes or enable with prefix "!" if otherwise disabled (please PR common patterns)
  -- Can also be a function fun():boolean that disables modes highlights when true
  ignore = {
    "NvimTree",
    "lspinfo",
    "packer",
    "checkhealth",
    "help",
    "man",
    "TelescopePrompt",
    "TelescopeResults",
    "!minifiles",
  },
}

return opts
