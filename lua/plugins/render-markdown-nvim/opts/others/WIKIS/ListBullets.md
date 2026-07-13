# List Bullets

Raw data being used:

````text
# List

- Nest 0 Item 1
  - Nest 1 Item 1
  - Nest 1 Item 2
    - Nest 2 Item 1
      - Nest 3 Item 1
        - Nest 4 Item 1
- Nest 0 Item 2
  - Nest 1 Item 3
````

## Default

[[/images/list/default.png|Default]]

```lua
require('render-markdown').setup({
    bullet = {
        enabled = true,
        render_modes = false,
        icons = { '●', '○', '◆', '◇' },
        ordered_icons = function(ctx)
            local value = vim.trim(ctx.value)
            local index = tonumber(value:sub(1, #value - 1))
            return ('%d.'):format(index > 1 and index or ctx.index)
        end,
        left_pad = 0,
        right_pad = 0,
        highlight = 'RenderMarkdownBullet',
        scope_highlight = {},
        scope_priority = nil,
    },
})
```

## Icons

[[/images/list/icons.png|Icons]]

```lua
require('render-markdown').setup({
    bullet = { icons = { '', '' } },
})
```

## Nested

[[/images/list/nested.png|Nested]]

```lua
require('render-markdown').setup({
    bullet = { icons = { { '󰫶 ', '󱂉 ' } } },
})
```

## Left Pad

[[/images/list/left-pad.png|Left Pad]]

```lua
require('render-markdown').setup({
    bullet = { left_pad = 4 },
})
```

## Right Pad

[[/images/list/right-pad.png|Right Pad]]

```lua
require('render-markdown').setup({
    bullet = { right_pad = 2 },
})
```
