# 🧩 Asciidoc inline

```lua $config: ../lua/markview/types/renderers/asciidoc_inline.lua, from: $config class: markview.config.asciidoc_inline
---@class markview.config.asciidoc_inline
---
---@field enable boolean Enable rendering of inline asciidoc.
---
---@field bolds markview.config.asciidoc_inline.bolds
---@field highlights markview.config.asciidoc_inline.highlights
---@field italics markview.config.asciidoc_inline.italics
---@field monospaces markview.config.asciidoc_inline.monospaces
---@field uris markview.config.asciidoc_inline.uris
```

## enable

Enables previewing inline asciidoc.

```lua
enable = true
```

## bolds

```lua from: $config class: markview.config.asciidoc_inline.bolds
---@class markview.config.asciidoc_inline.bolds
---
---@field enable boolean
```

Hides the delimiters surrounding **bold text**.

```lua $src: ../lua/markview/config/asciidoc_inline.lua, from: $src field: bolds
bolds = { enable = true },
```

## highlights

```lua from: $config class: markview.config.asciidoc_inline.highlights
--- Configuration for Obsidian-style highlighted texts.
---@class markview.config.asciidoc_inline.highlights
---
---@field enable boolean Enable rendering of highlighted text.
---
---@field default markview.config.asciidoc_inline.highlights.opts Default configuration for highlighted text.
---@field [string] markview.config.asciidoc_inline.highlights.opts Configuration for highlighted text that matches `string`.
```

Changes how specific highlights are shown.

```lua $src: ../lua/markview/config/asciidoc_inline.lua, from: $src field: highlights
highlights = {
    enable = true,

    default = {
        padding_left = " ",
        padding_right = " ",

        hl = "MarkviewPalette3"
    }
},
```

Highlights can be made to look different based on lua patterns matching the content(`default` also works the same way but acts as the default style). These can have the following options.

```lua from: $config alias: markview.config.asciidoc_inline.highlights.opts
--[[ Options for a specific highlight type. ]]
---@alias markview.config.asciidoc_inline.highlights.opts markview.config.__inline
```

## italics

```lua from: $config class: markview.config.asciidoc_inline.italics
---@class markview.config.asciidoc_inline.italics
---
---@field enable boolean
```

Hides the delimiters surrounding *italic text*.

```lua $src: ../lua/markview/config/asciidoc_inline.lua, from: $src field: italics
italics = { enable = true },
```

## monospaces

```lua from: $config alias: markview.config.asciidoc_inline.monospaces
---@alias markview.config.asciidoc_inline.monospaces markview.config.__inline
```

Hides the delimiters surrounding `monospace text`.

```lua $src: ../lua/markview/config/asciidoc_inline.lua, from: $src field: monospaces
monospaces = {
    enable = true,
    hl = "MarkviewInlineCode",

    padding_left = " ",
    padding_right = " "
},
```

## uris

```lua from: $config class: markview.config.asciidoc_inline.uris
---@class markview.config.asciidoc_inline.uris
---
---@field enable boolean Enable rendering of unlabeled URIs.
---
---@field default markview.config.asciidoc_inline.uris.opts Default configuration for URIs.
---@field [string] markview.config.asciidoc_inline.uris.opts Configuration for URIs that matches `string`.
```

Changes how specific uris are shown.

```lua $src: ../lua/markview/config/asciidoc_inline.lua, from: $src field: uris
uris = {
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

Each uri type has the following options.

```lua from: $config alias: markview.config.asciidoc_inline.uris.opts
--[[ Options for a specific highlight type. ]]
---@alias markview.config.asciidoc_inline.uris.opts markview.config.__inline
```
