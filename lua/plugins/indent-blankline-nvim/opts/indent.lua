---@type string | string[] | nil
local highlight = require("plugins.indent-blankline-nvim.opts.highlight").indent

---@type ibl.config.indent
local indent = {
  -- Character, or list of characters, that get used to display the indentation guide
  -- Each character has to have a display width of 0 or 1
  ---@type string | string[] | nil
  char = "▎",

  -- Character, or list of characters, that get used to display the indentation guide for tabs
  -- Defaults to what is set in `listchars`
  -- Each character has to have a display width of 0 or 1
  ---@type string | string[] | nil
  tab_char = nil,

  -- Highlight group, or list of highlight groups, that get applied to the indentation guide
  ---@type string | string[] | nil
  highlight = highlight,

  -- Caps the number of indentation levels by looking at the surrounding code
  ---@type boolean
  smart_indent_cap = true,

  -- Virtual text priority for the indentation guide
  ---@type number
  priority = 1,

  -- Repeat indentation guide virtual text on wrapped lines if 'breakindent' is set
  ---@type boolean
  repeat_linebreak = true,
}

return indent
