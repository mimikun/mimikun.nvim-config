---@type render.md.anti.conceal.Config
local anti_conceal = {
  -- This enables hiding added text on the line the cursor is on.
  ---@type boolean
  enabled = true,

  -- Modes to disable anti conceal feature.
  ---@type render.md.Modes
  disabled_modes = false,

  -- Number of lines above cursor to show.
  ---@type integer
  above = 0,

  -- Number of lines below cursor to show.
  ---@type integer
  below = 0,

  -- Which elements to always show, ignoring anti conceal behavior.
  -- Values can either be booleans to fix the behavior or string lists representing modes where anti conceal behavior will be ignored.
  -- Valid values are:
  --   bullet
  --   callout
  --   check_icon, check_scope
  --   code_background, code_border, code_language
  --   dash
  --   head_background, head_border, head_icon
  --   indent
  --   latex
  --   link
  --   quote
  --   sign
  --   table_border
  --   virtual_lines
  ---@type render.md.conceal.Ignore
  ignore = {
    code_background = true,
    indent = true,
    sign = true,
    virtual_lines = true,
  },
}

return anti_conceal
