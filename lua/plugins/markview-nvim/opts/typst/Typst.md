# 🧩 Typst

---

## headings

```lua from: ../lua/markview/types/renderers/typst.lua class: markview.config.typst.headings
--- Configuration for Typst headings.
---@class markview.config.typst.headings
---
---@field enable boolean Enable rendering of Headings.
---
---@field [string] headings.typst Heading level configuration(name format: "heading_%d", %d = heading level).
---
---@field shift_width integer Amount of spaces to add before the text for teach heading level.
---
---@field org_indent? boolean Enables `Org mode` like section indentation. Disabled by default.
---@field org_shift_width? integer Amount of `org_shift_char` to add per heading level.
---@field org_shift_char? string Character used for indenting/shifting the sections.
```

Changes how headings are shown.

```lua
headings = {
    enable = true,
    shift_width = 1,

    heading_1 = {
        style = "icon",
        sign = "󰌕 ", sign_hl = "MarkviewHeading1Sign",

        icon = "󰼏  ", hl = "MarkviewHeading1",
    },
    heading_2 = {
        style = "icon",
        sign = "󰌖 ", sign_hl = "MarkviewHeading2Sign",

        icon = "󰎨  ", hl = "MarkviewHeading2",
    },
    heading_3 = {
        style = "icon",

        icon = "󰼑  ", hl = "MarkviewHeading3",
    },
    heading_4 = {
        style = "icon",

        icon = "󰎲  ", hl = "MarkviewHeading4",
    },
    heading_5 = {
        style = "icon",

        icon = "󰼓  ", hl = "MarkviewHeading5",
    },
    heading_6 = {
        style = "icon",

        icon = "󰎴  ", hl = "MarkviewHeading6",
    },

    org_indent = false,
    org_shift_char = " ",
    org_shift_width = 1,
},
```

Each heading has the following options.

```lua from: ../lua/markview/types/renderers/typst.lua class: headings.typst
--- Configuration options for each typst heading level.
---@class headings.typst
---
---@field hl? string Highlight group.
---@field icon? string
---@field icon_hl? string
---@field sign? string
---@field sign_hl? string
---@field style "simple" | "icon"
```

---

## list_items

```lua from: ../lua/markview/types/renderers/typst.lua class: markview.config.typst.list_items
--- Configuration for list items.
---@class markview.config.typst.list_items
---
---@field enable boolean Enable rendering of list items.
---
---@field indent_size integer | fun(buffer: integer, item: markview.parsed.typst.list_items): integer Indentation size for list items.
---@field shift_width integer | fun(buffer: integer, item: markview.parsed.typst.list_items): integer Preview indentation size for list items.
---
---@field marker_dot markview.config.typst.list_items.typst Configuration for `n.` list items.
---@field marker_minus markview.config.typst.list_items.typst Configuration for `-` list items.
---@field marker_plus markview.config.typst.list_items.typst Configuration for `+` list items.
```

Changes how list items are shown.

```lua
list_items = {
    enable = true,

    indent_size = function (buffer)
        if type(buffer) ~= "number" then
            return vim.bo.shiftwidth or 4;
        end

        --- Use 'shiftwidth' value.
        return vim.bo[buffer].shiftwidth or 4;
    end,
    shift_width = 4,

    marker_minus = {
        add_padding = true,

        text = "●",
        hl = "MarkviewListItemMinus"
    },

    marker_plus = {
        add_padding = true,

        text = "%d)",
        hl = "MarkviewListItemPlus"
    },

    marker_dot = {
        add_padding = true,

        text = "%d.",
        hl = "MarkviewListItemStar"
    }
},
```

Each list type has the following options.

```lua from: ../lua/markview/types/renderers/typst.lua class: markview.config.typst.list_items.typst
---@class markview.config.typst.list_items.typst
---
---@field enable? boolean Enable rendering of this list item type.
---
---@field add_padding boolean
---@field hl? string Highlight group.
---@field text string
```

---

## raw_blocks

```lua from: ../lua/markview/types/renderers/typst.lua class: markview.config.typst.raw_blocks
---@class markview.config.typst.raw_blocks
---
---@field enable boolean Enable rendering of raw blocks.
---
---@field border_hl? string Highlight group for top & bottom border of raw blocks.
---@field label_direction? "left" | "right" Changes where the label is shown.
---@field label_hl? string Highlight group for the label
---@field min_width? integer Minimum width of the code block.
---@field pad_amount? integer Left & right padding size.
---@field pad_char? string Character to use for the padding.
---@field sign? boolean Whether to show signs for the code blocks.
---@field sign_hl? string Highlight group for the signs.
---@field style "simple" | "block" Preview style for code blocks.
---
---@field default markview.config.typst.raw_blocks.opts Default line configuration for the raw block.
---@field [string] markview.config.typst.raw_blocks.opts Line configuration for the raw block whose `language` matches `string`
```

Changes how raw blocks are shown.

```lua
raw_blocks = {
    enable = true,

    style = "block",
    label_direction = "right",

    sign = true,

    min_width = 60,
    pad_amount = 3,
    pad_char = " ",

    border_hl = "MarkviewCode",

    default = {
        block_hl = "MarkviewCode",
        pad_hl = "MarkviewCode"
    },

    ["diff"] = {
        block_hl = function (_, line)
            if line:match("^%+") then
                return "MarkviewPalette4";
            elseif line:match("^%-") then
                return "MarkviewPalette1";
            else
                return "MarkviewCode";
            end
        end,
        pad_hl = "MarkviewCode"
    }
},
```

You can also add line specific styles for different languages. Such as this one for diff files.

```lua
    ["diff"] = {
        block_hl = function (_, line)
            if line:match("^%+") then
                return "MarkviewPalette4";
            elseif line:match("^%-") then
                return "MarkviewPalette1";
            else
                return "MarkviewCode";
            end
        end,
        pad_hl = "MarkviewCode"
    },
```

---

## url_links

```lua from: ../lua/markview/types/renderers/typst.lua class: markview.config.typst.url_links
--- Configuration for URL links.
---@class markview.config.typst.url_links
---
---@field enable boolean Enable rendering of URL links.
---
---@field default markview.config.typst.url_links.opts Default configuration for URL links.
---@field [string] markview.config.typst.url_links.opts Configuration for URL links whose label matches `string`.
```

Changes how url links are shown.

```lua
url_links = {
    enable = true,

    default = {
        icon = " ",
        hl = "MarkviewEmail"
    },

    ["github%.com/[%a%d%-%_%.]+%/?$"] = {
        --- github.com/<user>

        icon = " ",
        hl = "MarkviewPalette0Fg"
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/?$"] = {
        --- github.com/<user>/<repo>

        icon = " ",
        hl = "MarkviewPalette0Fg"
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+/tree/[%a%d%-%_%.]+%/?$"] = {
        --- github.com/<user>/<repo>/tree/<branch>

        icon = " ",
        hl = "MarkviewPalette0Fg"
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+/commits/[%a%d%-%_%.]+%/?$"] = {
        --- github.com/<user>/<repo>/commits/<branch>

        icon = " ",
        hl = "MarkviewPalette0Fg"
    },

    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/releases$"] = {
        --- github.com/<user>/<repo>/releases

        icon = " ",
        hl = "MarkviewPalette0Fg"
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/tags$"] = {
        --- github.com/<user>/<repo>/tags

        icon = " ",
        hl = "MarkviewPalette0Fg"
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/issues$"] = {
        --- github.com/<user>/<repo>/issues

        icon = " ",
        hl = "MarkviewPalette0Fg"
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/pulls$"] = {
        --- github.com/<user>/<repo>/pulls

        icon = " ",
        hl = "MarkviewPalette0Fg"
    },

    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/wiki$"] = {
        --- github.com/<user>/<repo>/wiki

        icon = " ",
        hl = "MarkviewPalette0Fg"
    },

    ["developer%.mozilla%.org"] = {
        priority = -9999,

        icon = "󰖟 ",
        hl = "MarkviewPalette5Fg"
    },

    ["w3schools%.com"] = {
        priority = -9999,

        icon = " ",
        hl = "MarkviewPalette4Fg"
    },

    ["stackoverflow%.com"] = {
        priority = -9999,

        icon = "󰓌 ",
        hl = "MarkviewPalette2Fg"
    },

    ["reddit%.com"] = {
        priority = -9999,

        icon = " ",
        hl = "MarkviewPalette2Fg"
    },

    ["github%.com"] = {
        priority = -9999,

        icon = " ",
        hl = "MarkviewPalette6Fg"
    },

    ["gitlab%.com"] = {
        priority = -9999,

        icon = "󰮠 ",
        hl = "MarkviewPalette2Fg"
    },

    ["dev%.to"] = {
        priority = -9999,

        icon = "󱁴 ",
        hl = "MarkviewPalette0Fg"
    },

    ["codepen%.io"] = {
        priority = -9999,

        icon = " ",
        hl = "MarkviewPalette6Fg"
    },

    ["replit%.com"] = {
        priority = -9999,

        icon = " ",
        hl = "MarkviewPalette2Fg"
    },

    ["jsfiddle%.net"] = {
        priority = -9999,

        icon = " ",
        hl = "MarkviewPalette5Fg"
    },

    ["npmjs%.com"] = {
        priority = -9999,

        icon = " ",
        hl = "MarkviewPalette0Fg"
    },

    ["pypi%.org"] = {
        priority = -9999,

        icon = "󰆦 ",
        hl = "MarkviewPalette0Fg"
    },

    ["mvnrepository%.com"] = {
        priority = -9999,

        icon = " ",
        hl = "MarkviewPalette1Fg"
    },

    ["medium%.com"] = {
        priority = -9999,

        icon = " ",
        hl = "MarkviewPalette6Fg"
    },

    ["linkedin%.com"] = {
        priority = -9999,

        icon = "󰌻 ",
        hl = "MarkviewPalette5Fg"
    },

    ["news%.ycombinator%.com"] = {
        priority = -9999,

        icon = " ",
        hl = "MarkviewPalette2Fg"
    },
}
```

Each url links type has the following options.

```lua from: ../lua/markview/types/renderers/typst.lua alias: markview.config.typst.url_links.opts
--- Configuration for a specific URL type.
---@alias markview.config.typst.url_links.opts markview.config.__inline
```

---

## reference_links

```lua from: ../lua/markview/types/renderers/typst.lua class: markview.config.typst.reference_links
--- Configuration for reference links.
---@class markview.config.typst.reference_links
---
---@field enable boolean Enable rendering of reference links.
---
---@field default markview.config.typst.reference_links.opts Default configuration for reference links.
---@field [string] markview.config.typst.reference_links.opts Configuration for reference links whose label matches `string`.
```

Changes how reference links are shown.

```lua
reference_links = {
    enable = true,

    default = {
        icon = " ",
        hl = "MarkviewHyperlink"
    },
},
```

Each link type has the following options.

```lua from: ../lua/markview/types/renderers/typst.lua alias: markview.config.typst.reference_links.opts
--- Configuration for a specific reference link type.
---@alias markview.config.typst.reference_links.opts markview.config.__inline
```

---
