# render-markdown.nvim

Plugin to improve viewing Markdown files in Neovim.

## Getting Started

Please follow the main repo's README for the most up to date information regarding:

- [Requirements](https://github.com/MeanderingProgrammer/render-markdown.nvim?tab=readme-ov-file#requirements)
- [Installation](https://github.com/MeanderingProgrammer/render-markdown.nvim?tab=readme-ov-file#install)
- [Highlights](https://github.com/MeanderingProgrammer/render-markdown.nvim?tab=readme-ov-file#colors)

This plugin works with any buffer that has markdown injected anywhere. As a result
it is not filetype specific and we allow users to specify which to run on. For example
to run on both `Markdown` and `Quarto` files:

```lua
require('render-markdown').setup({
    file_types = { 'markdown', 'quarto' },
})
```

This plugin integrates with `lazy.nvim` to read any lazy load filetypes you have
configured. As a result you can get the same behavior as above + lazy loading with:

```lua
{
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'quarto' },
}
```

This plugin's main party trick is the ability to get out of the way of the user in
2 ways.

1. Via mode changes using the `render_modes` field
2. Via anti-conceal behavior using the `anti_conceal` field

### Render Modes

The default value is provided below:

```lua
require('render-markdown').setup({
    render_modes = { 'n', 'c', 't' },
})
```

This means that in `normal`, `command`, and `terminal` modes you'll get a rendered
view, and in other modes such as `insert` the marks added by the plugin will disappear.
This behavior along with an alternative is shown below.

| Default Modes                      | All Modes               |
| ---------------------------------- | ----------------------- |
| `render_modes = { 'n', 'c', 't' }` | `render_modes = true`   |
| [[/media/default.gif\|Default]]    | [[/media/all.gif\|All]] |

If you want to use a specific subset of all modes make sure to use the values specified
in `:help mode()`. For example visual mode consists of 3 different types:

1. Character: v = `'v'`
2. Line: V = `'V'`
3. Block: CTRL-V = `'\22'`

Notice that the block one is a bit special, since we need to represent the CTRL character
in Lua. To do this we use the ASCII value directly which just so happens to be 22.

### Anti-Conceal

Anti-conceal is a cursor row based behavior where any marks added by the plugin that
are on the same row as your cursor (regardless of mode) will disappear. This allows
for a much more fluid editing experience.

The default value is provided below:

```lua
require('render-markdown').setup({
    anti_conceal = {
        enabled = true,
        disabled_modes = false,
        above = 0,
        below = 0,
        -- Which elements to always show, ignoring anti conceal behavior. Values can either be
        -- booleans to fix the behavior or string lists representing modes where anti conceal
        -- behavior will be ignored. Valid values are:
        --   bullet
        --   callout
        --   check_icon, check_scope
        --   code_background, code_border, code_language
        --   dash
        --   head_background, head_border, head_icon
        --   indent
        --   link
        --   quote
        --   sign
        --   table_border
        --   virtual_lines
        ignore = {
            code_background = true,
            indent = true,
            sign = true,
            virtual_lines = true,
        },
    },
})
```

If you prefer this can be disabled via:

```lua
require('render-markdown').setup({
    anti_conceal = { enabled = false },
})
```

## Components

For a more in depth look at individual components visit the associated page.

|                                  |                             |
| -------------------------------- | --------------------------- |
| [[[/images/headings/default.png\|Headings]]](Headings)       | [[[/images/code/default.png\|Code Blocks]]](CodeBlocks) |
| [[[/images/list/default.png\|List Bullets]]](ListBullets)    | [[[/images/callout/default.png\|Callouts]]](Callouts)   |
| [[[/images/link/default.png\|Links]]](Links)                 | [[[/images/table/default.png\|Tables]]](Tables)         |
| [[[/images/checkboxes/default.png\|Checkboxes]]](Checkboxes) | |

## Useful Configuration Options

### Presets

These allow you to set many different non default options with a single value. You
can view the values for these [here](https://github.com/MeanderingProgrammer/render-markdown.nvim/blob/main/lua/render-markdown/lib/presets.lua).

The default value is provided below:

```lua
require('render-markdown').setup({
    preset = 'none',
})
```

### Enabled

This lets you set whether the plugin should render documents from the start or not.
Useful if you want to use a command like `RenderMarkdown enable` to start rendering
documents rather than having it on by default. There are ways to accomplish the
same thing with the `lazy.nvim` `cmd` option, the point of this feature is to be
plugin manager agnostic.

The default value is provided below:

```lua
require('render-markdown').setup({
    enabled = true,
})
```

### Treesitter Injections

This plugin works by iterating through the language trees of the current buffer and
adding marks for handled languages such as `markdown`. For standard `markdown` files
this is the entire file, however for other filetypes this may be only specific sections.
This option allows users to define these sections within the plugin configuration
as well as allowing this plugin to provide logical defaults for a "batteries included"
experience.

The default value is provided below:

```lua
require('render-markdown').setup({
    injections = {
        gitcommit = {
            enabled = true,
            query = [[
                ((message) @injection.content
                    (#set! injection.combined)
                    (#set! injection.include-children)
                    (#set! injection.language "markdown"))
            ]],
        },
    },
})
```

### Treesitter Patterns

This allows the plugin to disable treesitter highlights in your configuration (likely
provided by nvim-treesitter), without completely overriding them. This is needed
to disable the `conceal_lines` directive added around code blocks which prevents
us from adding the language icon. We check both the id and the name of the directive
so we can be confident we're disabling the correct thing.

The default value is provided below:

```lua
require('render-markdown').setup({
    markdown = {
        disable = true,
        directives = {
            { id = 17, name = 'conceal_lines' },
            { id = 18, name = 'conceal_lines' },
        },
    },
})
```

### Callbacks

These can be used to trigger custom events at different points of the rendering lifecycle.

The default value is provided below:

```lua
require('render-markdown').setup({
    on = {
        attach = function() end,
        initial = function() end,
        render = function() end,
        clear = function() end,
    },
})
```

### Max File Size

The maximum file size that this plugin will attempt to render in megabytes. This
plugin only does rendering for what is visible within the viewport so the size of
the file does not directly impact its performance. However large files in general
are laggy enough hence this feature. The size is only checked once when the file
is opened and not after every update, so a file that grows larger than this in the
process of editing will continue to be rendered.

The default value is provided below:

```lua
require('render-markdown').setup({
    max_file_size = 10.0,
})
```

### Debounce

This is meant to space out how often this plugin parses the content of the viewport
in milliseconds to avoid causing too much lag while scrolling & editing. For example
if you hold `j` once you've scrolled far enough down you'll notice that there is
no longer any rendering happening. Only once you've stopped scrolling for this debounce
time will the plugin parse the viewport and update the marks. If you don't mind the
lag or have a really fast system you can reduce this value to make the plugin feel
snappier.

The default value is provided below:

```lua
require('render-markdown').setup({
    debounce = 100,
})
```

### Window Options

Window options are used by the plugin to set different window level neovim option
values when rendering and when not rendering a file. This is useful for 2 reasons:

1. To allow options for rendering to be controlled by the plugin configuration so
   users don't need to set global or ftplugin options to make things work.
2. Some option values are more useful for appearance and others are more useful
   while editing.

The default value is provided below:

```lua
require('render-markdown').setup({
    win_options = {
        conceallevel = { default = vim.o.conceallevel, rendered = 3 },
        concealcursor = { default = vim.o.concealcursor, rendered = '' },
    },
})
```

### Overrides

This lets you set nearly all the options available at a `buftype` & `filetype` level.
Think of the top level configuration as the default where when the `buftype` or `filetype`
match these override values are used instead. `filetype` takes precedence over `buftype`.

The default value is provided below:

```lua
require('render-markdown').setup({
    overrides = {
        buflisted = {},
        buftype = {
            nofile = {
                render_modes = true,
                padding = { highlight = 'NormalFloat' },
                sign = { enabled = false },
            },
        },
        filetype = {},
    },
})
```

What this means is for the nofile `buftype` (the value for LSP hover docs) we disable
sign marks. This is because signs do not look good in hover docs which omit line
numbers. Similarly you can use this to set different code block rendering in hover
docs like disabling padding since that will cause line wraps:

```lua
require('render-markdown').setup({
    overrides = {
        buftype = {
            nofile = {
                code = { left_pad = 0, right_pad = 0 },
            },
        },
    },
})
```

## Less Useful Configuration Options

### Log

The log options are largely useful for debugging more complicated issues and for
plugin development, but not something you would want running all the time.

The default values are provided below:

```lua
require('render-markdown').setup({
    log_level = 'error',
    log_runtime = false,
})
```

### Padding

This configures values related to adding spacing around content. For the most part
the default value should work due to common conventions but in some cases may need
to be modified.

The default value is provided below:

```lua
require('render-markdown').setup({
    padding = {
        highlight = 'Normal',
    },
})
```
