---@type render.md.table.Config
local pipe_table = {
  -- Turn on / off pipe table rendering.
  enabled = true,

  -- Additional modes to render pipe tables.
  render_modes = false,

  -- Pre configured settings largely for setting table border easier.
  --   heavy: use thicker border characters
  --   double: use double line border characters
  --   round: use round border corners
  --   none: does nothing
  ---@type render.md.table.Preset | string | "heavy" | "double" | "round" | "none"
  preset = "none",

  -- Determines how individual cells of a table are rendered.
  --   overlay: writes completely over the table, removing conceal behavior and highlights
  --   raw: replaces only the '|' characters in each row, leaving the cells unmodified
  --   padded: raw + cells are padded to maximum visual width for each column
  --   trimmed: padded except empty space is subtracted from visual width calculation
  ---@type render.md.table.Cell | string | "overlay" | "raw" | "padded" | "trimmed"
  cell = "padded",

  -- Adjust the computed width of table cells using custom logic.
  ---@type fun(ctx: render.md.table.cell.Context): integer
  cell_offset = function(_ctx)
    return 0
  end,

  -- Amount of space to put between cell contents and border.
  ---@type integer
  padding = 1,

  -- Minimum column width to use for padded or trimmed cell.
  ---@type integer
  min_width = 0,

  -- Characters used to replace table border.
  -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal.
  ---@type string[]
  --border = {
  --  "┌",
  --  "┬",
  --  "┐",
  --  "├",
  --  "┼",
  --  "┤",
  --  "└",
  --  "┴",
  --  "┘",
  --  "│",
  --  "─",
  --},
  border = {
    "╓",
    "╥",
    "╖",
    "╟",
    "╫",
    "╢",
    "╙",
    "╨",
    "╜",
    "║",
    "─",
  },

  -- Turn on / off top & bottom lines.
  ---@type boolean
  border_enabled = true,

  -- Always use virtual lines for table borders instead of attempting to use empty lines.
  -- Will be automatically enabled if indentation module is enabled.
  ---@type boolean
  border_virtual = false,

  -- Gets placed in delimiter row for each column, position is based on alignment.
  ---@type string
  alignment_indicator = "━",
  --alignment_indicator = "┅",

  -- Highlight for table heading, delimiter, and the line above.
  ---@type string
  head = "RenderMarkdownTableHead",

  -- Highlight for everything else, main table rows and the line below.
  ---@type string
  row = "RenderMarkdownTableRow",

  -- Determines how the table as a whole is rendered.
  --   none: { enabled = false }
  --   normal: { border_enabled = false }
  --   full: uses all default values
  ---@type render.md.table.Style | string | "none" | "normal" | "full"
  style = "full",
}

return pipe_table
