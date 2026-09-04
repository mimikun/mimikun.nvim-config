---@type render.md.indent.Config
local indent = {
  -- Mimic org-indent-mode behavior by indenting everything under a heading based on the level of the heading.
  -- Indenting starts from level 2 headings onward by default.

  -- Turn on / off org-indent-mode.
  enabled = false,

  -- Additional modes to render indents.
  render_modes = false,

  -- Amount of additional padding added for each heading level.
  ---@type integer
  per_level = 2,

  -- Heading levels <= this value will not be indented.
  -- Use 0 to begin indenting from the very first level.
  ---@type integer
  skip_level = 1,

  -- Do not indent heading titles, only the body.
  ---@type boolean
  skip_heading = false,

  -- Prefix added when indenting, one per level.
  ---@type string
  icon = "▎",

  -- Priority to assign to extmarks.
  ---@type integer
  priority = 0,

  -- Applied to icon.
  ---@type string
  highlight = "RenderMarkdownIndent",
}

return indent
