-- Configuration for inline markdown.
---@type markview.config.markdown_inline
local markdown_inline = {
  -- Enable **inline markdown** rendering.
  ---@type boolean
  enable = nil,

  -- Block reference link configuration.
  ---@type markview.config.markdown_inline.block_refs
  block_references = {
    -- Enable rendering of block references.
    ---@type boolean
    enable = true,

    -- Default configuration for block reference links.
    ---@type markview.config.__inline
    default = {
      icon = "󰿨 ",

      hl = "MarkviewPalette6Fg",
      file_hl = "MarkviewPalette0Fg",
    },

    -- Configuration for block references whose label matches with the key's pattern.
    ---@field [string] markview.config.__inline
  },

  -- Checkbox configuration.
  ---@type markview.config.markdown_inline.checkboxes
  checkboxes = {
    -- TODO: it
  },

  -- Email link configuration.
  ---@type markview.config.markdown_inline.emails
  emails = {
    -- TODO: it
  },

  -- Footnotes configuration.
  ---@type markview.config.markdown_inline.footnotes
  footnotes = {
    -- TODO: it
  },

  -- Hyperlink configuration.
  ---@type markview.config.markdown_inline.hyperlinks
  hyperlinks = {
    -- TODO: it
  },

  -- Image link configuration.
  ---@type markview.config.markdown_inline.images
  images = {
    -- TODO: it
  },

  -- Inline code/code span configuration.
  ---@type markview.config.markdown_inline.inline_codes
  inline_codes = {
    enable = true,
    hl = "MarkviewInlineCode",

    padding_left = " ",
    padding_right = " ",
  },

  -- URI autolink configuration.
  ---@type markview.config.markdown_inline.uri_autolinks
  uri_autolinks = {
    -- TODO: it
  },

  -- Embed file link configuration.
  ---@type markview.config.markdown_inline.embed_files
  embed_files = {
    -- TODO: it
  },

  -- Highlighted text configuration.
  ---@type markview.config.markdown_inline.highlights
  highlights = {
    -- TODO: it
  },

  -- Internal link configuration.
  ---@type markview.config.markdown_inline.internal_links
  internal_links = {
    -- TODO: it
  },

  -- HTML entities configuration.
  ---@type markview.config.markdown_inline.entities
  entities = {
    -- Enable rendering of HTML entities.
    ---@type boolean
    enable = true,

    -- Highlight group for the symbol.
    ---@type string
    hl = "Special",
  },

  -- Github styled emoji shorthands.
  ---@type markview.config.markdown_inline.emojis
  emoji_shorthands = {
    -- Enable rendering of emoji shorthands.
    ---@type boolean
    enable = true,

    -- Highlight group for the emoji.
    ---@type string
    --hl=nil,
  },

  -- Escaped characters configuration.
  ---@type markview.config.markdown_inline.escapes
  escapes = {
    -- Enable rendering of escaped characters.
    ---@type boolean
    enable = true,
  },

  -- Obsidian-style tags configuration.
  ---@type markview.config.markdown_inline.tags
  --tags = nil,
}

return markdown_inline
