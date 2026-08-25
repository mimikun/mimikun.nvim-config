-- Configuration for Typst.
---@type markview.config.typst
local typst = {
  -- Enable **Typst** rendering.
  ---@type boolean
  enable = nil,

  -- Configuration for block of typst code.
  ---@type markview.config.typst.code_blocks
  code_blocks = {
    -- Enable rendering of code blocks.
    ---@type boolean
    enable = true,

    -- Highlight group.
    ---@type string
    hl = "MarkviewCode",

    -- Minimum width of code blocks.
    ---@type integer
    min_width = 60,

    -- Number of paddings added around the text.
    ---@type integer
    pad_amount = 3,

    -- Character to use for padding.
    ---@type string
    pad_char = " ",

    -- simple:
    --   Only highlights the lines inside this block.
    --   This will be used if a `wrap` is enabled or if `tab` is used in the text.
    -- block:
    --   Creates a box around the code block.
    ---@type string | "simple" | "block"
    style = "block",

    -- Text to use as the label.
    ---@type string
    text = "󰣖 Code",

    -- left: Shows label on the top-left side of the block
    -- right: Shows label on the top-right side of the block
    ---@type string | "left" | "right"
    text_direction = "right",

    -- Highlight group for the label
    ---@type string
    text_hl = "MarkviewIcon5",

    -- Sign for the code block.
    ---@type string
    ---sign=nil,

    -- Highlight group for the sign.
    ---@type string
    --sign_hl=nil,
  },

  -- Configuration for inline typst code.
  ---@type markview.config.typst.code_spans
  code_spans = {
    -- Enable rendering of code spans.
    ---@type boolean
    enable = true,

    -- Left corner.
    ---@type string
    --corner_left=nil,

    -- Highlight group for left corner.
    ---@type string
    --corner_left_hl=nil,

    -- Right corner.
    ---@type string
    --corner_right=nil,

    -- Highlight group for right corner.
    ---@type string
    --corner_right_hl=nil,

    -- Base Highlight group.
    ---@type string
    hl = "MarkviewCode",

    -- Left padding.
    ---@type string
    padding_left = " ",

    -- Highlight group for left padding.
    ---@type string
    --padding_left_hl=nil,

    -- Right padding.
    ---@type string
    padding_right = " ",

    -- Highlight group for right padding.
    ---@type string
    --padding_right_hl=nil,
  },

  -- Configuration for escaped characters.
  ---@type markview.config.typst.escapes
  escapes = {
    -- Enable rendering of escaped characters.
    ---@type boolean
    enable = true,
  },

  -- Configuration for typst symbols.
  ---@type markview.config.typst.symbols
  symbols = {
    -- Enable rendering of math symbols.
    ---@type boolean
    enable = true,

    -- Highlight group.
    ---@type string
    hl = "Special",
  },

  -- Configuration for headings.
  ---@type markview.config.typst.headings
  headings = {
    --TODO: it
  },

  -- Configuration for labels.
  ---@type markview.config.typst.labels
  labels = {
    -- Enable rendering of labels.
    ---@type boolean
    enable = true,

    -- Default configuration for labels.
    ---@type markview.config.typst.labels.opts
    default = {
      hl = "MarkviewInlineCode",
      padding_left = " ",
      icon = " ",
      padding_right = " ",
    },

    -- Configuration for labels whose text matches `string`.
    ---@field [string] markview.config.typst.labels.opts
  },

  -- Configuration for list items
  ---@type markview.config.typst.list_items
  list_items = {
    --TODO: it
  },

  -- Configuration for blocks of math code.
  ---@type markview.config.typst.math_blocks
  math_blocks = {
    -- Enable rendering of math blocks.
    ---@type boolean
    enable = true,

    -- Highlight group.
    ---@type string
    hl = "MarkviewCode",

    -- Number of `pad_char` to add before the lines.
    ---@type integer
    pad_amount = 3,

    -- Text used as padding.
    ---@type string
    pad_char = " ",

    ---@type string
    text = " 󰪚 Math ",

    ---@type string
    text_hl = "MarkviewCodeInfo",
  },

  -- Configuration for inline math code.
  ---@type markview.config.typst.math_spans
  math_spans = {
    enable = true,

    padding_left = " ",
    padding_right = " ",

    hl = "MarkviewInlineCode",
  },

  -- Configuration for raw blocks.
  ---@type markview.config.typst.raw_blocks
  raw_blocks = {
    --TODO: it
  },

  -- Configuration for raw spans.
  ---@type markview.config.typst.raw_spans
  raw_spans = {
    enable = true,

    padding_left = " ",
    padding_right = " ",

    hl = "MarkviewInlineCode",
  },

  -- Configuration for reference links.
  ---@type markview.config.typst.reference_links
  reference_links = {
    --TODO: it
  },

  -- Configuration for terms.
  ---@type markview.config.typst.terms
  terms = {
    -- Enable rendering of terms.
    ---@type boolean
    enable = true,

    -- Default configuration for terms.
    ---@type markview.config.typst.terms.opts
    default = {
      ---@type string
      text = " ",

      -- Highlight group.
      ---@type string
      hl = "MarkviewPalette6Fg",
    },

    -- Configuration for terms whose label matches `string`.
    ---@field [string] markview.config.typst.terms.opts
  },

  -- Configuration for URL links.
  ---@type markview.config.typst.url_links
  url_links = {
    --TODO: it
  },

  -- Configuration for subscript texts.
  ---@type markview.config.typst.subscripts
  subscripts = {
    -- Enable rendering of subscript text.
    ---@type boolean
    enable = true,

    -- Use Unicode characters to mimic subscript text.
    ---@type boolean
    --fake_preview=nil,

    -- Highlight group.
    -- Use a list to change nested subscript text color.
    ---@type string | string[]
    hl = "MarkviewSubscript",

    ---@type string
    --marker_left=nil,

    ---@type string
    --marker_right=nil,
  },

  -- Configuration for superscript texts.
  ---@type markview.config.typst.subscripts
  superscripts = {
    -- Enable rendering of superscript text.
    ---@type boolean
    enable = true,

    -- Use Unicode characters to mimic superscript text.
    ---@type boolean
    --fake_preview=nil,

    -- Highlight group.
    -- Use a list to change nested subscript text color.
    ---@type string | string[]
    hl = "MarkviewSuperscript",

    ---@type string
    --marker_left=nil,

    ---@type string
    --marker_right=nil,
  },
}

return typst
