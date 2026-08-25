-- Configuration for markdown.
---@type markview.config.markdown
local markdown = {
  -- Enable **markdown** rendering.
  ---@type boolean
  enable = nil,

  -- Block quote configuration.
  ---@type markview.config.markdown.block_quotes
  block_quotes = {
    -- Enable rendering of block quotes.
    ---@type boolean
    enable = true,

    -- Enables text wrap support.
    ---@type boolean
    wrap = true,

    -- Default configuration.
    ---@type markview.config.markdown.block_quotes.opts
    default = {
      -- Text for the border.
      -- Use an array to apply different border *per line*.
      ---@type string | string[]
      border = "▋",

      -- Base highlight group for the block quote.
      ---@type string
      hl = "MarkviewBlockQuoteDefault",

      -- Highlight group for the border.
      -- Use an array to apply different highlights *per line*.
      ---@type string | string[]
      --border_hl=nil,

      -- Highlight group for the icon.
      ---@type string
      --icon_hl=nil,

      -- Highlight group for the preview.
      ---@type string
      --preview_hl=nil,

      -- Highlight group for the preview line *background*.
      -- Uses `line_hl` when not set.
      ---@type string
      --preview_line_hl=nil,

      -- Highlight group for the line *background*.
      ---@type string
      --line_hl=nil,
    },

    -- Configuration for `>[!string]` callout.
    -- Name is **case-insensitive**.
    ---@field [string] markview.config.markdown.block_quotes.opts
    ["ABSTRACT"] = {
      -- Callout/Alert preview string(shown where `>[!string]` was).
      ---@type string
      preview = "󱉫 Abstract",

      -- Base highlight group for the block quote.
      ---@type string
      hl = "MarkviewBlockQuoteNote",

      -- Should this callout allow titles(`>[!string] <Title>`)? Disabled by default.
      ---@type boolean
      title = true,

      -- Icon to show before the block quote title.
      ---@type string
      icon = "󱉫",
    },
    ["SUMMARY"] = {
      hl = "MarkviewBlockQuoteNote",
      preview = "󱉫 Summary",

      title = true,
      icon = "󱉫",
    },
    ["TLDR"] = {
      hl = "MarkviewBlockQuoteNote",
      preview = "󱉫 Tldr",

      title = true,
      icon = "󱉫",
    },
    ["TODO"] = {
      hl = "MarkviewBlockQuoteNote",
      preview = " Todo",

      title = true,
      icon = "",
    },
    ["INFO"] = {
      hl = "MarkviewBlockQuoteNote",
      preview = " Info",

      custom_title = true,
      icon = "",
    },
    ["SUCCESS"] = {
      hl = "MarkviewBlockQuoteOk",
      preview = "󰗠 Success",

      title = true,
      icon = "󰗠",
    },
    ["CHECK"] = {
      hl = "MarkviewBlockQuoteOk",
      preview = "󰗠 Check",

      title = true,
      icon = "󰗠",
    },
    ["DONE"] = {
      hl = "MarkviewBlockQuoteOk",
      preview = "󰗠 Done",

      title = true,
      icon = "󰗠",
    },
    ["QUESTION"] = {
      hl = "MarkviewBlockQuoteWarn",
      preview = "󰋗 Question",

      title = true,
      icon = "󰋗",
    },
    ["HELP"] = {
      hl = "MarkviewBlockQuoteWarn",
      preview = "󰋗 Help",

      title = true,
      icon = "󰋗",
    },
    ["FAQ"] = {
      hl = "MarkviewBlockQuoteWarn",
      preview = "󰋗 Faq",

      title = true,
      icon = "󰋗",
    },
    ["FAILURE"] = {
      hl = "MarkviewBlockQuoteError",
      preview = "󰅙 Failure",

      title = true,
      icon = "󰅙",
    },
    ["FAIL"] = {
      hl = "MarkviewBlockQuoteError",
      preview = "󰅙 Fail",

      title = true,
      icon = "󰅙",
    },
    ["MISSING"] = {
      hl = "MarkviewBlockQuoteError",
      preview = "󰅙 Missing",

      title = true,
      icon = "󰅙",
    },
    ["DANGER"] = {
      hl = "MarkviewBlockQuoteError",
      preview = " Danger",

      title = true,
      icon = "",
    },
    ["ERROR"] = {
      hl = "MarkviewBlockQuoteError",
      preview = " Error",

      title = true,
      icon = "",
    },
    ["BUG"] = {
      hl = "MarkviewBlockQuoteError",
      preview = " Bug",

      title = true,
      icon = "",
    },
    ["EXAMPLE"] = {
      hl = "MarkviewBlockQuoteSpecial",
      preview = "󱖫 Example",

      title = true,
      icon = "󱖫",
    },
    ["QUOTE"] = {
      hl = "MarkviewBlockQuoteDefault",
      preview = " Quote",

      title = true,
      icon = "",
    },
    ["CITE"] = {
      hl = "MarkviewBlockQuoteDefault",
      preview = " Cite",

      title = true,
      icon = "",
    },
    ["HINT"] = {
      hl = "MarkviewBlockQuoteOk",
      preview = " Hint",

      title = true,
      icon = "",
    },
    ["ATTENTION"] = {
      hl = "MarkviewBlockQuoteWarn",
      preview = " Attention",

      title = true,
      icon = "",
    },

    ["NOTE"] = {
      hl = "MarkviewBlockQuoteNote",
      preview = "󰋽 Note",

      title = true,
      icon = "󰋽",
    },
    ["TIP"] = {
      hl = "MarkviewBlockQuoteOk",
      preview = " Tip",

      title = true,
      icon = "",
    },
    ["IMPORTANT"] = {
      hl = "MarkviewBlockQuoteSpecial",
      preview = " Important",

      title = true,
      icon = "",
    },
    ["WARNING"] = {
      hl = "MarkviewBlockQuoteWarn",
      preview = " Warning",

      title = true,
      icon = "",
    },
    ["CAUTION"] = {
      hl = "MarkviewBlockQuoteError",
      preview = "󰳦 Caution",

      title = true,
      icon = "󰳦",
    },
  },

  -- Fenced code block configuration.
  ---@type markview.config.markdown.code_blocks
  code_blocks = {
    -- TODO: it
  },

  -- Heading configuration.
  ---@type markview.config.markdown.headings
  headings = {
    -- TODO: it
  },

  -- Horizontal rules configuration.
  ---@type markview.config.markdown.hr
  horizontal_rules = {
    -- TODO: it
  },

  -- List items configuration.
  ---@type markview.config.markdown.list_items
  list_items = {
    ---@type boolean
    enable = true,

    -- Enables wrap support.
    ---@type boolean
    wrap = true,

    -- Indentation size for list items.
    ---@type integer | fun(buffer: integer, item: markview.parsed.markdown.list_items): integer
    indent_size = function(buffer)
      if type(buffer) ~= "number" then
        return vim.bo.shiftwidth or 4
      end

      --- Use 'shiftwidth' value.
      return vim.bo[buffer].shiftwidth or 4
    end,

    -- Virtual indentation size for previewed list items.
    ---@type integer | fun(buffer: integer, item: markview.parsed.markdown.list_items): integer
    shift_width = 4,

    -- Configuration for `-` list items.
    ---@type markview.config.markdown.list_items.unordered
    marker_minus = {
      add_padding = true,
      conceal_on_checkboxes = true,

      text = "●",
      hl = "MarkviewListItemMinus",
    },

    -- Configuration for `+` list items.
    ---@type markview.config.markdown.list_items.unordered
    marker_plus = {
      add_padding = true,
      conceal_on_checkboxes = true,

      text = "◈",
      hl = "MarkviewListItemPlus",
    },

    -- Configuration for `*` list items.
    ---@type markview.config.markdown.list_items.unordered
    marker_star = {
      add_padding = true,
      conceal_on_checkboxes = true,

      text = "◇",
      hl = "MarkviewListItemStar",
    },

    -- Configuration for `n.` list items.
    ---@type markview.config.markdown.list_items.ordered
    marker_dot = {
      text = function(_, item)
        return string.format("%d.", item.n)
      end,
      hl = "@markup.list.markdown",
      add_padding = true,
      conceal_on_checkboxes = true,
    },

    -- Configuration for `n)` list items.
    ---@type markview.config.markdown.list_items.ordered
    marker_parenthesis = {
      text = function(_, item)
        return string.format("%d)", item.n)
      end,
      hl = "@markup.list.markdown",
      add_padding = true,
      conceal_on_checkboxes = true,
    },
  },

  -- Table configuration.
  ---@type markview.config.markdown.tables
  tables = {
    -- TODO: it
  },

  -- TOML metadata configuration.
  ---@type markview.config.markdown.metadata
  metadata_plus = {
    ---@type boolean
    enable = true,

    -- Background highlight group.
    ---@type string
    hl = "MarkviewCode",

    -- Primary highlight group for the borders.
    ---@type string
    border_hl = "MarkviewCodeFg",

    -- Top border.
    ---@type string
    border_top = "▄",

    -- Highlight group for the top border.
    ---@type string
    --border_top_hl=nil,

    -- Bottom border.
    ---@type string
    border_bottom = "▀",

    -- Highlight group for the bottom border.
    ---@type string
    --border_bottom_hl=nil,
  },

  -- YAML metadata configuration.
  ---@type markview.config.markdown.metadata
  metadata_minus = {
    ---@type boolean
    enable = true,

    -- Background highlight group.
    ---@type string
    hl = "MarkviewCode",

    -- Primary highlight group for the borders.
    ---@type string
    border_hl = "MarkviewCodeFg",

    -- Top border.
    ---@type string
    border_top = "▄",

    -- Highlight group for the top border.
    ---@type string
    --border_top_hl=nil,

    -- Bottom border.
    ---@type string
    border_bottom = "▀",

    -- Highlight group for the bottom border.
    ---@type string
    --border_bottom_hl=nil,
  },

  -- Reference link definition configuration.
  ---@type markview.config.markdown.ref_def
  reference_definitions = {
    ---@type boolean
    enable = true,

    -- Default configuration for reference definitions.
    ---@type markview.config.__inline
    default = {
      -- Icon(added after `padding_left`).
      ---@type string
      icon = " ",

      -- Default highlight group(used by `*_hl` options when they are not set).
      ---@type string
      hl = "MarkviewPalette4Fg",

      ---@field enable? boolean Only valid if it's a top level option, Used for disabling previews.
      ---@field virtual? boolean In `inline_codes`, when `true` masks the text with a virtual text(useful if the line has a background).

      ---@field corner_left? string Left corner.
      ---@field corner_left_hl? string Highlight group for the left corner.

      ---@field padding_left? string Left padding(added after `corner_left`).
      ---@field padding_left_hl? string Highlight group for the left padding.

      ---@field icon_hl? string Highlight group for the icon.

      ---@field padding_right? string Right padding.
      ---@field padding_right_hl? string Highlight group for the right padding.

      ---@field corner_right? string Right corner(added after `padding_right`).
      ---@field corner_right_hl? string Highlight group for the right corner.

      ---@field block_hl? string Only for `block_references`, highlight group for the block name.
      ---@field file_hl? string Only for `block_references`, highlight group for the file name.
    },

    -- Configuration for reference definitions whose description matches `string`.
    ---@field [string] markview.config.__inline
    ["github%.com/[%a%d%-%_%.]+%/?$"] = {
      --- github.com/<user>

      icon = " ",
      hl = "MarkviewPalette0Fg",
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/?$"] = {
      --- github.com/<user>/<repo>

      icon = " ",
      hl = "MarkviewPalette0Fg",
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+/tree/[%a%d%-%_%.]+%/?$"] = {
      --- github.com/<user>/<repo>/tree/<branch>

      icon = " ",
      hl = "MarkviewPalette0Fg",
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+/commits/[%a%d%-%_%.]+%/?$"] = {
      --- github.com/<user>/<repo>/commits/<branch>

      icon = " ",
      hl = "MarkviewPalette0Fg",
    },

    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/releases$"] = {
      --- github.com/<user>/<repo>/releases

      icon = " ",
      hl = "MarkviewPalette0Fg",
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/tags$"] = {
      --- github.com/<user>/<repo>/tags

      icon = " ",
      hl = "MarkviewPalette0Fg",
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/issues$"] = {
      --- github.com/<user>/<repo>/issues

      icon = " ",
      hl = "MarkviewPalette0Fg",
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/pulls$"] = {
      --- github.com/<user>/<repo>/pulls

      icon = " ",
      hl = "MarkviewPalette0Fg",
    },

    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/wiki$"] = {
      --- github.com/<user>/<repo>/wiki

      icon = " ",
      hl = "MarkviewPalette0Fg",
    },

    ["developer%.mozilla%.org"] = {
      priority = -9999,

      icon = "󰖟 ",
      hl = "MarkviewPalette5Fg",
    },

    ["w3schools%.com"] = {
      priority = -9999,

      icon = " ",
      hl = "MarkviewPalette4Fg",
    },

    ["stackoverflow%.com"] = {
      priority = -9999,

      icon = "󰓌 ",
      hl = "MarkviewPalette2Fg",
    },

    ["reddit%.com"] = {
      priority = -9999,

      icon = " ",
      hl = "MarkviewPalette2Fg",
    },

    ["github%.com"] = {
      priority = -9999,

      icon = " ",
      hl = "MarkviewPalette6Fg",
    },

    ["gitlab%.com"] = {
      priority = -9999,

      icon = "󰮠 ",
      hl = "MarkviewPalette2Fg",
    },

    ["dev%.to"] = {
      priority = -9999,

      icon = "󱁴 ",
      hl = "MarkviewPalette0Fg",
    },

    ["codepen%.io"] = {
      priority = -9999,

      icon = " ",
      hl = "MarkviewPalette6Fg",
    },

    ["replit%.com"] = {
      priority = -9999,

      icon = " ",
      hl = "MarkviewPalette2Fg",
    },

    ["jsfiddle%.net"] = {
      priority = -9999,

      icon = " ",
      hl = "MarkviewPalette5Fg",
    },

    ["npmjs%.com"] = {
      priority = -9999,

      icon = " ",
      hl = "MarkviewPalette0Fg",
    },

    ["pypi%.org"] = {
      priority = -9999,

      icon = "󰆦 ",
      hl = "MarkviewPalette0Fg",
    },

    ["mvnrepository%.com"] = {
      priority = -9999,

      icon = " ",
      hl = "MarkviewPalette1Fg",
    },

    ["medium%.com"] = {
      priority = -9999,

      icon = " ",
      hl = "MarkviewPalette6Fg",
    },

    ["linkedin%.com"] = {
      priority = -9999,

      icon = "󰌻 ",
      hl = "MarkviewPalette5Fg",
    },

    ["news%.ycombinator%.com"] = {
      priority = -9999,

      icon = " ",
      hl = "MarkviewPalette2Fg",
    },
  },
}

return markdown
