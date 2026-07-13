# Headings

Raw data being used:

````text
# Heading 1

## Heading 2

### Heading 3

#### Heading 4

##### Heading 5

###### Heading 6
````

## Default

[[/images/headings/default.png|Default]]

```lua
require('render-markdown').setup({
    heading = {
        enabled = true,
        render_modes = false,
        atx = true,
        setext = true,
        sign = true,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        position = 'overlay',
        signs = { '󰫎 ' },
        width = 'full',
        left_margin = 0,
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = false,
        border_virtual = false,
        border_prefix = false,
        above = '▄',
        below = '▀',
        backgrounds = {
            'RenderMarkdownH1Bg',
            'RenderMarkdownH2Bg',
            'RenderMarkdownH3Bg',
            'RenderMarkdownH4Bg',
            'RenderMarkdownH5Bg',
            'RenderMarkdownH6Bg',
        },
        foregrounds = {
            'RenderMarkdownH1',
            'RenderMarkdownH2',
            'RenderMarkdownH3',
            'RenderMarkdownH4',
            'RenderMarkdownH5',
            'RenderMarkdownH6',
        },
        custom = {},
    },
})
```

## No Sign

[[/images/headings/no-sign.png|No Sign]]

```lua
require('render-markdown').setup({
    heading = { sign = false },
})
```

## Inline

[[/images/headings/inline.png|Inline]]

```lua
require('render-markdown').setup({
    heading = { position = 'inline' },
})
```

## Icons

[[/images/headings/icons.png|Icons]]

```lua
require('render-markdown').setup({
    heading = { icons = { '󰼏 ', '󰎨 ' } },
})
```

## Block

[[/images/headings/block.png|Block]]

```lua
require('render-markdown').setup({
    heading = {
        width = 'block',
        left_pad = 2,
        right_pad = 4,
    },
})
```

## Block Min

[[/images/headings/block-min.png|Block Min]]

```lua
require('render-markdown').setup({
    heading = {
        width = 'block',
        min_width = 30,
    },
})
```

## Block Center

[[/images/headings/block-center.png|Block Center]]

```lua
require('render-markdown').setup({
    heading = {
        sign = false,
        position = 'inline',
        width = 'block',
        left_margin = 0.5,
        left_pad = 0.2,
        right_pad = 0.2,
    },
})
```

## Width Level

[[/images/headings/width-level.png|Width Level]]

```lua
require('render-markdown').setup({
    heading = {
        width = { 'full', 'block', 'full', 'block' },
        min_width = 30,
    },
})
```

## Border

[[/images/headings/border.png|Border]]

```lua
require('render-markdown').setup({
    heading = { border = true },
})
```

## Border Virtual

[[/images/headings/border-virtual.png|Border Virtual]]

```lua
require('render-markdown').setup({
    heading = {
        border = true,
        border_virtual = true,
    },
})
```
