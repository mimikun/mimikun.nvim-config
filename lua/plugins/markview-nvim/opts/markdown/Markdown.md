# 🧩 Markdown

---

## headings

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.headings
--- Configuration for ATX & Setext headings.
---@class markview.config.markdown.headings
---
---@field enable boolean Enable rendering of headings.
---
---@field heading_1 markview.config.markdown.headings.atx
---@field heading_2 markview.config.markdown.headings.atx
---@field heading_3 markview.config.markdown.headings.atx
---@field heading_4 markview.config.markdown.headings.atx
---@field heading_5 markview.config.markdown.headings.atx
---@field heading_6 markview.config.markdown.headings.atx
---
---@field setext_1 markview.config.markdown.headings.setext
---@field setext_2 markview.config.markdown.headings.setext
---
---@field shift_width integer Amount of spaces to add before the text for teach heading level.
---
---@field org_indent? boolean Enables `Org mode` like section indentation. Disabled by default.
---@field org_shift_width? integer Amount of `org_shift_char` to add per heading level.
---@field org_shift_char? string Character used for indenting/shifting the sections.
---
---@field org_indent_wrap? boolean Enable wrap support for sections. Enabled by default
```

Changes how headings are shown.

```lua
headings = {
    enable = true,

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

    setext_1 = {
        style = "decorated",

        sign = "󰌕 ", sign_hl = "MarkviewHeading1Sign",
        icon = "  ", hl = "MarkviewHeading1",
        border = "▂"
    },
    setext_2 = {
        style = "decorated",

        sign = "󰌖 ", sign_hl = "MarkviewHeading2Sign",
        icon = "  ", hl = "MarkviewHeading2",
        border = "▁"
    },

    shift_width = 1,

    org_indent = false,
    org_indent_wrap = true,
    org_shift_char = " ",
    org_shift_width = 1,
},
```

`heading_<n>` options are for ATX headings. They each have the following options.

```lua from: ../lua/markview/types/renderers/markdown.lua alias: markview.config.markdown.headings.atx
---@alias markview.config.markdown.headings.atx
---| markview.config.markdown.headings.atx.simple
---| markview.config.markdown.headings.atx.label
---| markview.config.markdown.headings.atx.icon
```

Each style is explained below.

### heading: Simple

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.headings.atx.simple
---@class markview.config.markdown.headings.atx.simple
---
---@field style "simple" Heading style.
---@field hl? string Base Highlight group.
```

### heading: Label

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.headings.atx.label
---@class markview.config.markdown.headings.atx.label
---
---@field style "label" Heading style.
---@field align? "left" | "center" | "right" Label alignment.
---
---@field corner_left? string Text for left corner.
---@field corner_left_hl? string Highlight group for left corner.
---
---@field corner_right? string Text for right corner.
---@field corner_right_hl? string Highlight group for right corner.
---
---@field hl? string Base Highlight group. Used by other `*_hl` options as default value.
---
---@field icon? string Text to use for the icon(use `%d` to add heading number).
---@field icon_hl? string Highlight group for icon.
---
---@field padding_left? string Text for left padding.
---@field padding_left_hl? string Highlight group for left padding.
---
---@field padding_right? string Text for right padding.
---@field padding_right_hl? string Highlight group for right padding.
---
---@field sign? string Text to show on the sign column.
---@field sign_hl? string Highlight group for the sign.
```

Creates a label for the heading text that you can optionally align on the left/right/center of the screen screen(like how `glow` shows headings).

>[!NOTE]
> Only the first window's width is used for alignment! Even if you view the same file in multiple windows.

### heading: Icon

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.headings.atx.icon
---@class markview.config.markdown.headings.atx.icon
---
---@field style "icon" Heading style.
---@field hl? string Base Highlight group. Used by other `*_hl` options as default value.
---
---@field icon? string Text to use for the icon(use `%d` to add heading number).
---@field icon_hl? string Highlight group for icon.
---
---@field sign? string Text to show on the sign column.
---@field sign_hl? string Highlight group for the sign.
```

Like `simple` but adds an icon & sign.

---

`setext_<n>` options are for Setext headings. They each have the following options.

```lua from: ../lua/markview/types/renderers/markdown.lua alias: markview.config.markdown.headings.setext
---@alias markview.config.markdown.headings.setext
---| markview.config.markdown.headings.setext.simple
---| markview.config.markdown.headings.setext.decorated
```

Each style is explained below.

### heading: Simple

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.headings.setext.simple
---@class markview.config.markdown.headings.setext.simple
---
---@field style "simple" Preview style.
---@field hl? string Base highlight group.
---
---@field sign? string Text to show in the sign column.
---@field sign_hl? string Highlight group for the sign.
```

Colors the heading lines and adds an icon & sign.

### heading: Decorated

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.headings.setext.decorated
---@class markview.config.markdown.headings.setext.decorated
---
---@field style "decorated" Preview style.
---
---@field border string Text to use for the preview border.
---@field border_hl? string Highlight group for the border.
---
---@field hl? string Base highlight group.
---
---@field icon? string Text to use for the icon.
---@field icon_hl? string Highlight group for the icon.
---
---@field sign? string Text to show in the sign column.
---@field sign_hl? string Highlight group for the sign.
```

Like `simple` but allows adding custom borders below the heading text(instead of showing just `---` or `===`).

---

## horizontal_rules

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.hr
--- Configuration for horizontal rules.
---@class markview.config.markdown.hr
---
---@field enable boolean Enable preview of horizontal rules.
---@field parts markview.config.markdown.hr.part[] Parts for the horizontal rules.
```

Changes how horizontal rules are shown.

```lua
horizontal_rules = {
    enable = true,

    parts = {
        {
            type = "repeating",
            direction = "left",

            repeat_amount = function (buffer)
                local utils = require("markview.utils");
                local window = utils.buf_getwin(buffer)

                local width = vim.api.nvim_win_get_width(window)
                local textoff = vim.fn.getwininfo(window)[1].textoff;

                return math.floor((width - textoff - 3) / 2);
            end,

            text = "─",

            hl = {
                "MarkviewGradient1", "MarkviewGradient1",
                "MarkviewGradient2", "MarkviewGradient2",
                "MarkviewGradient3", "MarkviewGradient3",
                "MarkviewGradient4", "MarkviewGradient4",
                "MarkviewGradient5", "MarkviewGradient5",
                "MarkviewGradient6", "MarkviewGradient6",
                "MarkviewGradient7", "MarkviewGradient7",
                "MarkviewGradient8", "MarkviewGradient8",
                "MarkviewGradient9", "MarkviewGradient9"
            }
        },
        {
            type = "text",

            text = "  ",
            hl = "MarkviewIcon3Fg"
        },
        {
            type = "repeating",
            direction = "right",

            repeat_amount = function (buffer) --[[@as function]]
                local utils = require("markview.utils");
                local window = utils.buf_getwin(buffer)

                local width = vim.api.nvim_win_get_width(window)
                local textoff = vim.fn.getwininfo(window)[1].textoff;

                return math.ceil((width - textoff - 3) / 2);
            end,

            text = "─",
            hl = {
                "MarkviewGradient1", "MarkviewGradient1",
                "MarkviewGradient2", "MarkviewGradient2",
                "MarkviewGradient3", "MarkviewGradient3",
                "MarkviewGradient4", "MarkviewGradient4",
                "MarkviewGradient5", "MarkviewGradient5",
                "MarkviewGradient6", "MarkviewGradient6",
                "MarkviewGradient7", "MarkviewGradient7",
                "MarkviewGradient8", "MarkviewGradient8",
                "MarkviewGradient9", "MarkviewGradient9"
            }
        }
    }
},
```

### parts

You can have any of the following parts.

> Text

Shows some text *literally*.

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.hr.text
---@class markview.config.markdown.hr.text
---
---@field type "text" Part name.
---
---@field hl? string Highlight group for this part.
---@field text string Text to show.
```

> Repeating

Repeats given text by an amount.

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.hr.repeating
---@class markview.config.markdown.hr.repeating
---
---@field type "repeating" Part name.
---
---@field direction "left" | "right" Direction from which the highlight groups are applied from.
---
---@field repeat_amount integer | fun(buffer: integer, item: markview.parsed.markdown.hr): integer How many times to repeat the text.
---@field repeat_hl? boolean Whether to repeat the highlight groups.
---@field repeat_text? boolean Whether to repeat the text.
---
---@field text string | string[] Text to repeat.
---@field hl? string | string[] Highlight group for the text.
```

---

## tables

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.tables
--- Configuration for tables.
---@class markview.config.markdown.tables
---
---@field enable boolean
---@field strict boolean When `true`, leading & trailing whitespaces are not considered part of the cell.
---
---@field block_decorator boolean Whether to draw top & bottom border.
---@field use_virt_lines boolean Whether to use virtual lines for the borders.
---
---@field hl markview.config.markdown.tables.parts Highlight groups for the parts.
---@field parts markview.config.markdown.tables.parts Parts for the table.
```

Changes how tables are shown.

![Demo](./images/markdown/markview.nvim-markdown.tables.png)

>{!IMPORTANT]
> When using `wrap`, tables are partially rendered to prevent text wrapping issues.
> This is not a bug.

| `wrap = true` | `wrap = false` |
|---------------|----------------|
| ![wrap](https://github.com/OXY2DEV/markview.nvim/blob/images/v27/markview.nvim-wrap.png) | ![nowrap](https://github.com/OXY2DEV/markview.nvim/blob/images/v27/markview.nvim-nowrap.png) |

```lua
tables = {
    enable = true,
    strict = false,

    block_decorator = true,
    use_virt_lines = false,

    parts = {
        top = { "╭", "─", "╮", "┬" },
        header = { "│", "│", "│" },
        separator = { "├", "─", "┤", "┼" },
        row = { "│", "│", "│" },
        bottom = { "╰", "─", "╯", "┴" },

        overlap = { "┝", "━", "┥", "┿" },

        align_left = "╼",
        align_right = "╾",
        align_center = { "╴", "╶" }
    },

    hl = {
        top = { "MarkviewTableHeader", "MarkviewTableHeader", "MarkviewTableHeader", "MarkviewTableHeader" },
        header = { "MarkviewTableHeader", "MarkviewTableHeader", "MarkviewTableHeader" },
        separator = { "MarkviewTableHeader", "MarkviewTableHeader", "MarkviewTableHeader", "MarkviewTableHeader" },
        row = { "MarkviewTableBorder", "MarkviewTableBorder", "MarkviewTableBorder" },
        bottom = { "MarkviewTableBorder", "MarkviewTableBorder", "MarkviewTableBorder", "MarkviewTableBorder" },

        overlap = { "MarkviewTableBorder", "MarkviewTableBorder", "MarkviewTableBorder", "MarkviewTableBorder" },

        align_left = "MarkviewTableAlignLeft",
        align_right = "MarkviewTableAlignRight",
        align_center = { "MarkviewTableAlignCenter", "MarkviewTableAlignCenter" }
    }
},
```

`parts` & `hl` have the following options.

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.tables.parts
--- Parts that make the previewed table.
---@class markview.config.markdown.tables.parts
---
---@field align_center [ string, string ]
---@field align_left string
---@field align_right string
---
---@field top string[]
---@field header string[]
---@field separator string[]
---@field row string[]
---@field bottom string[]
---
---@field overlap string[]
```

---

## list_items

`marker_minus`, `marker_plus` & `marker_star` has the following options.

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.list_items.unordered
---@class markview.config.markdown.list_items.unordered
---
---@field add_padding boolean
---@field conceal_on_checkboxes? boolean
---@field enable? boolean
---@field hl? string
---@field text string
```

`marker_dot` & `marker_parenthesis` has the following options.

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.list_items.ordered
---@class markview.config.markdown.list_items.ordered
---
---@field add_padding boolean
---@field conceal_on_checkboxes? boolean
---@field enable? boolean
```

---

## code_blocks

```lua from: ../lua/markview/types/renderers/markdown.lua alias: markview.config.markdown.code_blocks
--- Configuration for code blocks.
---@alias markview.config.markdown.code_blocks
---| markview.config.markdown.code_blocks.simple
---| markview.config.markdown.code_blocks.block
```

Changes how code blocks are shown.

![Demo](./images/markdown/markview.nvim-markdown.code_blocks.png)

```lua from: ../lua/markview/config/markdown.lua field: code_blocks
code_blocks = {
    enable = true,

    border_hl = "MarkviewCode",
    info_hl = "MarkviewCodeInfo",

    label_direction = "right",
    label_hl = nil,

    min_width = 60,
    pad_amount = 2,
    pad_char = " ",

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
    },

    style = function (buf)
        if vim.o.wrap then
            return "simple";
        end

        local win = require("markview.utils").buf_getwin(buf);
        return vim.wo[win].wrap == true and "simple" or "block";
    end,
    sign = true,
},
```

Each style is explained below.

### code_blocks: block

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.code_blocks.block
---@class markview.config.markdown.code_blocks.block
---
---@field enable boolean Enable rendering of code blocks.
---
---@field border_hl? string Highlight group for borders.
---@field info_hl? string Highlight group for the info string.
---
---@field label_direction? "left" | "right" Position of the language & icon.
---@field label_hl? string Highlight group for the label.
---
---@field min_width? integer Minimum width of the code block.
---@field pad_amount? integer Number of `pad_char`s to add on the left & right side of the code block.
---@field pad_char? string Character used as padding.
---
---@field sign? boolean Enables signs for the code block?
---@field sign_hl? string Highlight group for the sign.
---
---@field style "block" | fun(buf: integer, item: markview.parsed.markdown.code_blocks): "block" Creates a block around the code block. Disabled when `wrap` is enabled.
---
---@field default markview.config.markdown.code_blocks.opts
---@field [string] markview.config.markdown.code_blocks.opts
```

Creates a block around the code block.

>[!IMPORTANT]
> This is disabled if `wrap` is enabled. Or if you used `tab` inside the code block.

### code_blocks: simple

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.code_blocks.simple
---@class markview.config.markdown.code_blocks.simple
---
---@field enable boolean Enable rendering of code blocks.
---
---@field border_hl? string Highlight group for borders.
---@field info_hl? string Highlight group for the info string.
---
---@field label_direction? "left" | "right" Position of the language & icon.
---@field label_hl? string Highlight group for the label.
---
---@field sign? boolean Enables signs for the code block?
---@field sign_hl? string Highlight group for the sign.
---
---@field style "simple" | fun(buf: integer, item: markview.parsed.markdown.code_blocks): "simple" Only highlights the line. Enabled when `wrap` is enabled.
---
---@field default markview.config.markdown.code_blocks.opts
---@field [string] markview.config.markdown.code_blocks.opts
```

Highlights the lines of the code block.

>[!IMPORTANT]
> This is enabled if `wrap` is enabled.

---

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

Each language has the following options.

```lua from: ../lua/markview/types/renderers/markdown.lua class: markview.config.markdown.code_blocks.opts
--[[ Configuration for highlighting `lines` inside a code block. ]]
---@class markview.config.markdown.code_blocks.opts
---
---@field block_hl
---| string Highlight group for the background of the line.
---| fun(buffer: integer, line: string): string? Takes `line` & the `buffer` containing it and returns a highlight group for the line.
---@field pad_hl
---| string Highlight group for the padding of the line.
---| fun(buffer: integer, line: string): string? Takes `line` & the `buffer` containing it and returns a highlight group for the padding..
```

---
