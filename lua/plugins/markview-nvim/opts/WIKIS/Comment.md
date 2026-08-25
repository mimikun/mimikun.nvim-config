# 🧩 Comment

![demo](./images/comment/markview.nvim-comment.injection.png)

```lua $src: ../lua/markview/config/comment.lua,, $file: ../lua/markview/types/renderers/comment.lua, from: $file class: markview.config.comment
--[[ Configuration for `comments`. ]]
---@class markview.config.comment
---
---@field enable boolean Enable **comment** rendering.
---
---@field autolinks markview.config.comment.autolinks
---@field code_blocks markview.config.comment.code_blocks
---@field inline_codes markview.config.comment.inline_codes
---@field issues markview.config.comment.issues
---@field mentions markview.config.comment.mentions
---@field taglinks markview.config.comment.taglinks
---@field tasks markview.config.comment.tasks
---@field task_scopes markview.config.comment.task_scopes
---@field urls markview.config.comment.urls
```

<!-- Demo -->

>[!WARNING]
> Fancy comments are **experimental** at the moment. Single line comments like these,
>
> ```lua
> -- feat: Some comment
> ```
>
> May not be correctly rendered when in large groups. Use multi-line comments(e.g. `--[[ ... ]]`, `/* ... */`) for these.
> This is a **Neovim issue** with tree-sitter injections in general and not a plugin issue!

## enable

```lua
enable = true
```

Enable rendering of fancy comments.

## autolinks

```lua from: $file, class: markview.config.comment.autolinks
--- Configuration for autolinks.
---@class markview.config.comment.autolinks
---
---@field enable boolean Enable rendering of `<autolink>`s.
---
---@field default markview.config.comments.autolinks.opts Default configuration.
---@field [string] markview.config.comments.autolinks.opts Configuration for autolinks matching the key's pattern.
```

Enable rendering of `<autolinks>`.

<details>
    <summary>See default configuration</summary>

```lua from: $src, field: autolinks
autolinks = {
    enable = true,

    default = {
        icon = "󰋽 ",
        hl = "MarkviewPalette6",
    },

    ---|fS

    --NOTE(@OXY2DEV): Github sites.

    ["github%.com/[%a%d%-%_%.]+%/?$"] = {
        --- github.com/<user>
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return string.match(item.destination, "github%.com/([%a%d%-%_%.]+)%/?$");
        end
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/?$"] = {
        --- github.com/<user>/<repo>
        icon = "󰳐 ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/?$");
        end
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+/tree/[%a%d%-%_%.]+%/?$"] = {
        --- github.com/<user>/<repo>/tree/<branch>
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            local repo, branch = string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)/tree/([%a%d%-%_%.]+)%/?$");
            return repo .. " at " .. branch;
        end
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+/commits/[%a%d%-%_%.]+%/?$"] = {
        --- github.com/<user>/<repo>/commits/<branch>
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+/commits/[%a%d%-%_%.]+)%/?$");
        end
    },

    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/releases$"] = {
        --- github.com/<user>/<repo>/releases
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return "Releases • " .. string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/releases$");
        end
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/tags$"] = {
        --- github.com/<user>/<repo>/tags
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return "Tags • " .. string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/tags$");
        end
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/issues$"] = {
        --- github.com/<user>/<repo>/issues
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return "Issues • " .. string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/issues$");
        end
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/pulls$"] = {
        --- github.com/<user>/<repo>/pulls
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return "Pull requests • " .. string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/pulls$");
        end
    },

    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/wiki$"] = {
        --- github.com/<user>/<repo>/wiki
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return "Wiki • " .. string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/wiki$");
        end
    },

    --- NOTE(@OXY2DEV): Commonly used sites by programmers.

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

        icon = " ",
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

    ["neovim%.io/doc/user/.*#%_?.*$"] = {
        icon = " ",
        hl = "MarkviewPalette4Fg",

        text = function (_, item)
            local file, tag = string.match(item.destination, "neovim%.io/doc/user/(.*)#%_?(.*)$");
            --- The actual website seems to show
            --- _ in the site name so, we won't
            --- be replacing `_`s with ` `s.
            file = string.gsub(file, "%.html$", "");

            return string.format("%s(%s) - Neovim docs", normalize_str(file), tag);
        end
    },
    ["neovim%.io/doc/user/.*$"] = {
        icon = " ",
        hl = "MarkviewPalette4Fg",

        text = function (_, item)
            local file = string.match(item.destination, "neovim%.io/doc/user/(.*)$");
            file = string.gsub(file, "%.html$", "");

            return string.format("%s - Neovim docs", normalize_str(file));
        end
    },

    ["github%.com/vim/vim"] = {
        priority = -100,

        icon = " ",
        hl = "MarkviewPalette4Fg",
    },

    ["github%.com/neovim/neovim"] = {
        priority = -100,

        icon = " ",
        hl = "MarkviewPalette4Fg",
    },

    ["vim%.org"] = {
        icon = " ",
        hl = "MarkviewPalette4Fg",
    },

    ["luals%.github%.io/wiki/?.*$"] = {
        icon = " ",
        hl = "MarkviewPalette5Fg",

        text = function (_, item)
            if string.match(item.destination, "luals%.github%.io/wiki/(.-)/#(.+)$") then
                local page_mappings = {
                    annotations = {
                        ["as"] = "@as",
                        ["alias"] = "@alias",
                        ["async"] = "@async",
                        ["cast"] = "@cast",
                        ["class"] = "@class",
                        ["deprecated"] = "@deprecated",
                        ["diagnostic"] = "@diagnostic",
                        ["enum"] = "@enum",
                        ["field"] = "@field",
                        ["generic"] = "@generic",
                        ["meta"] = "@meta",
                        ["module"] = "@module",
                        ["nodiscard"] = "@nodiscard",
                        ["operator"] = "@operator",
                        ["overload"] = "@overload",
                        ["package"] = "@package",
                        ["param"] = "@param",
                        ["see"] = "@see",
                        ["source"] = "@source",
                        ["type"] = "@type",
                        ["vaarg"] = "@vaarg",
                        ["version"] = "@version"
                    }
                };

                local page, section = string.match(item.destination, "luals%.github%.io/wiki/(.-)/#(.+)$");

                if page_mappings[page] and page_mappings[page][section] then
                    section = page_mappings[page][section];
                else
                    section = normalize_str(string.gsub(section, "%-", " "));
                end

                return string.format("%s(%s) | Lua Language Server", normalize_str(page), section);
            elseif string.match(item.destination, "") then
                local page = string.match(item.destination, "luals%.github%.io/wiki/(.-)/?$");

                return string.format("%s | Lua Language Server", normalize_str(page));
            else
                return item.destination;
            end
        end
    },

    ---|fE
},
```

</details>

Each autolink type has the following options.

```lua from: $file, class: markview.config.comments.autolinks.opts
---@class markview.config.comments.autolinks.opts
---
---@field corner_left? string Left corner.
---@field corner_left_hl? string Highlight group for the left corner.
---
---@field padding_left? string Left padding(added after `corner_left`).
---@field padding_left_hl? string Highlight group for the left padding.
---
---@field icon? string Icon(added after `padding_left`).
---@field icon_hl? string Highlight group for the icon.
---
--[[ Text to show instead of the `autolink`.]]
---@field text?
---| string
---| function(buffer: integer, item: markview.parsed.comment.autolinks): string
---@field text_hl? string Highlight group for the shown text.
---
---@field hl? string Default highlight group(used by `*_hl` options when they are not set).
---
---@field padding_right? string Right padding.
---@field padding_right_hl? string Highlight group for the right padding.
---
---@field corner_right? string Right corner(added after `padding_right`).
---@field corner_right_hl? string Highlight group for the right corner.
```

## code_blocks

```lua from: $file, alias: markview.config.comment.code_blocks
--- Configuration for code blocks.
---@alias markview.config.comment.code_blocks
---| markview.config.comment.code_blocks.simple
---| markview.config.comment.code_blocks.block
```

Enable rendering of `fenced code blocks`.

<details>
    <summary>See default configuration</summary>

```lua from: $src, field: code_blocks
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

    style = "block",
    sign = true,
},
```

</details>

Each style is explained below.

### code_blocks: block

```lua from: $file class: markview.config.comment.code_blocks.block
---@class markview.config.comment.code_blocks.block
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
---@field style "block" Creates a block around the code block. Disabled when `wrap` is enabled.
---
---@field default markview.config.comment.code_blocks.opts
---@field [string] markview.config.comment.code_blocks.opts
```

Creates a block around the code block.

>[!IMPORTANT]
> This is disabled if `wrap` is enabled. Or if you used `tab` inside the code block.

### code_blocks: simple

```lua from: $file class: markview.config.comment.code_blocks.simple
---@class markview.config.comment.code_blocks.simple
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
---@field style "simple" Only highlights the line. Enabled when `wrap` is enabled.
---
---@field default markview.config.comment.code_blocks.opts
---@field [string] markview.config.comment.code_blocks.opts
```

Highlights the lines of the code block.

>[!IMPORTANT]
> This is enabled if `wrap` is enabled.

------

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

```lua from: $file class: markview.config.comment.code_blocks.opts
--[[ Configuration for highlighting `lines` inside a code block. ]]
---@class markview.config.comment.code_blocks.opts
---
---@field block_hl
---| string Highlight group for the background of the line.
---| fun(buffer: integer, line: string): string? Takes `line` & the `buffer` containing it and returns a highlight group for the line.
---@field pad_hl
---| string Highlight group for the padding of the line.
---| fun(buffer: integer, line: string): string? Takes `line` & the `buffer` containing it and returns a highlight group for the padding..
```

## inline_codes

```lua from: $file, class: markview.config.comment.inline_codes
--- Configuration for autolinks.
---@class markview.config.comment.autolinks
---
---@field enable boolean Enable rendering of `<autolink>`s.
---
---@field default markview.config.comments.autolinks.opts Default configuration.
---@field [string] markview.config.comments.autolinks.opts Configuration for autolinks matching the key's pattern.
```

Enable rendering of `inline codes`.

<details>
    <summary>See default configuration</summary>

```lua from: $src, field: inline_codes
inline_codes = {
    padding_left = " ",
    padding_right = " ",

    hl = "MarkviewInlineCode",
},
```

</details>

## issues

```lua from: $file, class: markview.config.comment.issues
--- Configuration for issues.
---@class markview.config.comment.issues
---
---@field enable boolean Enable rendering of `#issue`s.
---
---@field default markview.config.__inline Default configuration for issues.
---@field [string] markview.config.__inline Configuration for issues whose text matches with the key's pattern.
```

Enable rendering of `inline codes`.

<details>
    <summary>See default configuration</summary>

```lua from: $src, field: issues
issues = {
    enable = true,

    default = {
        padding_left = " ",
        padding_right = " ",

        icon = " ",

        hl = "MarkviewPalette2",
    },
},
```

</details>

Each issue type has [inline options](#inline-syntax), unless explicitly mentioned otherwise.

## mentions

```lua from: $file, class: markview.config.comment.mentions
--- Configuration for mentions.
---@class markview.config.comment.mentions
---
---@field enable boolean Enable rendering of `@mention`s.
---
---@field default markview.config.__inline Default configuration for mentions.
---@field [string] markview.config.__inline Configuration for mentions whose text matches with the key's pattern.
```

Enable rendering of `@mentions`.

<details>
    <summary>See default configuration</summary>

```lua from: $src, field: mentions
mentions = {
    enable = true,

    default = {
        padding_left = " ",
        padding_right = " ",

        icon = " ",

        hl = "MarkviewPalette5",
    },
},
```

</details>

Each mention type has [inline options](#inline-syntax), unless explicitly mentioned otherwise.

## taglinks

```lua from: $file, class: markview.config.comment.taglinks
--- Configuration for taglinks.
---@class markview.config.comment.taglinks
---
---@field enable boolean Enable rendering of `|taglink|`s.
---
---@field default markview.config.__inline Default configuration.
---@field [string] markview.config.__inline Configuration for taglinks matching the key's pattern.
```

Enable rendering of `|taglinks|`.

<details>
    <summary>See default configuration</summary>

```lua from: $src, field: taglinks
taglinks = {
    enable = true,

    default = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰌷 ",

        hl = "MarkviewHyperlink",
    },
},
```

</details>

Each taglink type has [inline options](#inline-syntax), unless explicitly mentioned otherwise.

## tasks

```lua from: $file, class: markview.config.comment.tasks
---@class markview.config.comment.tasks
---
---@field enable boolean
---
---@field default markview.config.comment.tasks.opts
---@field [string] markview.config.comment.tasks.opts
```

Enable rendering of `tasks`.

<details>
    <summary>See default configuration</summary>

```lua from: $src, field: tasks
tasks = {
    enable = true,

    default = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰄰 ",

        hl = "MarkviewPalette1",
    },

    ["^feat"] = {
        padding_left = " ",
        padding_right = " ",

        icon = "󱕅 ",

        hl = "MarkviewPalette7",
    },

    praise = {
        padding_left = " ",
        padding_right = " ",

        icon = "󱥋 ",

        hl = "MarkviewPalette3",
    },

    ["^suggest"] = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰣖 ",

        hl = "MarkviewPalette2",
    },

    thought = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰧑 ",

        hl = "MarkviewPalette0",
    },

    note = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰠮 ",

        hl = "MarkviewPalette5",
    },

    ["^info"] = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰋼 ",

        hl = "MarkviewPalette0",
    },

    xxx = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰓽 ",

        hl = "MarkviewPalette0",
    },

    ["^nit"] = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰩰 ",

        hl = "MarkviewPalette6",
    },

    ["^warn"] = {
        padding_left = " ",
        padding_right = " ",

        icon = " ",

        hl = "MarkviewPalette3",
    },

    fix = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰁨 ",

        hl = "MarkviewPalette7",
    },

    hack = {
        padding_left = " ",
        padding_right = " ",

        icon = "󱍔 ",

        hl = "MarkviewPalette1",
    },

    typo = {
        padding_left = " ",
        padding_right = " ",

        icon = " ",

        hl = "MarkviewPalette0",
    },

    wip = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰦖 ",

        hl = "MarkviewPalette2",
    },

    issue = {
        padding_left = " ",
        padding_right = " ",

        icon = " ",

        hl = "MarkviewPalette1",
    },

    ["error"] = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰅙 ",

        hl = "MarkviewPalette1",
    },

    fixme = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰶯 ",

        hl = "MarkviewPalette4",
    },

    deprecated = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰩆 ",

        hl = "MarkviewPalette1",
    },
},
```

</details>

Each task type has [inline options](#inline-syntax), unless explicitly mentioned otherwise.

## task_scopes

```lua from: $file, class: markview.config.comment.task_scopes
--- Configuration for task_scopes.
---@class markview.config.comment.task_scopes
---
---@field enable boolean Enable rendering of `task scope`s.
---
---@field default markview.config.__inline Default configuration for mentions.
---@field [string] markview.config.__inline Configuration for scopes matching the key's pattern.
```

Enable rendering of `task_scopes`.

<details>
    <summary>See default configuration</summary>

```lua from: $src, field: task_scopes
task_scopes = {
    enable = true,

    default = {
        padding_left = " ",
        padding_right = " ",

        icon = "󰈲 ",

        hl = "MarkviewPalette4",
    },
},
```

</details>

Each task scope type has [inline options](#inline-syntax), unless explicitly mentioned otherwise.

## urls

```lua from: $file, class: markview.config.comment.urls
--- Configuration for URLs.
---@class markview.config.comment.urls
---
---@field enable boolean Enable rendering of `URL`s.
---
---@field default markview.config.comments.urls.opts Default configuration for URLs.
---@field [string] markview.config.comments.urls.opts Configuration for URLs whose text matches with the key's pattern.
```

Enable rendering of `urls`.

<details>
    <summary>See default configuration</summary>

```lua from: $src, field: urls
urls = {
    enable = true,

    default = {
        icon = "󰌷 ",

        hl = "MarkviewHyperlink",
    },

    ---|fS

    --NOTE(@OXY2DEV): Github sites.

    ["github%.com/[%a%d%-%_%.]+%/?$"] = {
        --- github.com/<user>
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return string.match(item.destination, "github%.com/([%a%d%-%_%.]+)%/?$");
        end
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/?$"] = {
        --- github.com/<user>/<repo>
        icon = "󰳐 ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/?$");
        end
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+/tree/[%a%d%-%_%.]+%/?$"] = {
        --- github.com/<user>/<repo>/tree/<branch>
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            local repo, branch = string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)/tree/([%a%d%-%_%.]+)%/?$");
            return repo .. " at " .. branch;
        end
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+/commits/[%a%d%-%_%.]+%/?$"] = {
        --- github.com/<user>/<repo>/commits/<branch>
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+/commits/[%a%d%-%_%.]+)%/?$");
        end
    },

    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/releases$"] = {
        --- github.com/<user>/<repo>/releases
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return "Releases • " .. string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/releases$");
        end
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/tags$"] = {
        --- github.com/<user>/<repo>/tags
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return "Tags • " .. string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/tags$");
        end
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/issues$"] = {
        --- github.com/<user>/<repo>/issues
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return "Issues • " .. string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/issues$");
        end
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/pulls$"] = {
        --- github.com/<user>/<repo>/pulls
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return "Pull requests • " .. string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/pulls$");
        end
    },

    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/wiki$"] = {
        --- github.com/<user>/<repo>/wiki
        icon = " ",
        hl = "MarkviewPalette0Fg",

        text = function (_, item)
            return "Wiki • " .. string.match(item.destination, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/wiki$");
        end
    },

    --- NOTE(@OXY2DEV): Commonly used sites by programmers.

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

        icon = " ",
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

    ["neovim%.io/doc/user/.*#%_?.*$"] = {
        icon = " ",
        hl = "MarkviewPalette4Fg",

        text = function (_, item)
            local file, tag = string.match(item.destination, "neovim%.io/doc/user/(.*)#%_?(.*)$");
            --- The actual website seems to show
            --- _ in the site name so, we won't
            --- be replacing `_`s with ` `s.
            file = string.gsub(file, "%.html$", "");

            return string.format("%s(%s) - Neovim docs", normalize_str(file), tag);
        end
    },
    ["neovim%.io/doc/user/.*$"] = {
        icon = " ",
        hl = "MarkviewPalette4Fg",

        text = function (_, item)
            local file = string.match(item.destination, "neovim%.io/doc/user/(.*)$");
            file = string.gsub(file, "%.html$", "");

            return string.format("%s - Neovim docs", normalize_str(file));
        end
    },

    ["github%.com/vim/vim"] = {
        priority = -100,

        icon = " ",
        hl = "MarkviewPalette4Fg",
    },

    ["github%.com/neovim/neovim"] = {
        priority = -100,

        icon = " ",
        hl = "MarkviewPalette4Fg",
    },

    ["vim%.org"] = {
        icon = " ",
        hl = "MarkviewPalette4Fg",
    },

    ["luals%.github%.io/wiki/?.*$"] = {
        icon = " ",
        hl = "MarkviewPalette5Fg",

        text = function (_, item)
            if string.match(item.destination, "luals%.github%.io/wiki/(.-)/#(.+)$") then
                local page_mappings = {
                    annotations = {
                        ["as"] = "@as",
                        ["alias"] = "@alias",
                        ["async"] = "@async",
                        ["cast"] = "@cast",
                        ["class"] = "@class",
                        ["deprecated"] = "@deprecated",
                        ["diagnostic"] = "@diagnostic",
                        ["enum"] = "@enum",
                        ["field"] = "@field",
                        ["generic"] = "@generic",
                        ["meta"] = "@meta",
                        ["module"] = "@module",
                        ["nodiscard"] = "@nodiscard",
                        ["operator"] = "@operator",
                        ["overload"] = "@overload",
                        ["package"] = "@package",
                        ["param"] = "@param",
                        ["see"] = "@see",
                        ["source"] = "@source",
                        ["type"] = "@type",
                        ["vaarg"] = "@vaarg",
                        ["version"] = "@version"
                    }
                };

                local page, section = string.match(item.destination, "luals%.github%.io/wiki/(.-)/#(.+)$");

                if page_mappings[page] and page_mappings[page][section] then
                    section = page_mappings[page][section];
                else
                    section = normalize_str(string.gsub(section, "%-", " "));
                end

                return string.format("%s(%s) | Lua Language Server", normalize_str(page), section);
            elseif string.match(item.destination, "") then
                local page = string.match(item.destination, "luals%.github%.io/wiki/(.-)/?$");

                return string.format("%s | Lua Language Server", normalize_str(page));
            else
                return item.destination;
            end
        end
    },

    ---|fE
},
```

</details>

Each URL type has [inline options](#inline-syntax), unless explicitly mentioned otherwise.

------

## Inline syntax

Inline elements support **most** of these options.

```lua from: ../lua/markview/types/markview.lua, class: markview.config.__inline
---@class markview.config.__inline
---
---@field enable? boolean Only valid if it's a top level option, Used for disabling previews.
---@field virtual? boolean In `inline_codes`, when `true` masks the text with a virtual text(useful if the line has a background).
---
---@field corner_left? string Left corner.
---@field corner_left_hl? string Highlight group for the left corner.
---
---@field padding_left? string Left padding(added after `corner_left`).
---@field padding_left_hl? string Highlight group for the left padding.
---
---@field icon? string Icon(added after `padding_left`).
---@field icon_hl? string Highlight group for the icon.
---
---@field hl? string Default highlight group(used by `*_hl` options when they are not set).
---
---@field padding_right? string Right padding.
---@field padding_right_hl? string Highlight group for the right padding.
---
---@field corner_right? string Right corner(added after `padding_right`).
---@field corner_right_hl? string Highlight group for the right corner.
---
---
---
---@field block_hl? string Only for `block_references`, highlight group for the block name.
---@field file_hl? string Only for `block_references`, highlight group for the file name.
```
