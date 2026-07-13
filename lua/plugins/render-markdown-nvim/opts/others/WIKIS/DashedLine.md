# Dashed Line

Raw data being used:

````text
# Dashed Line

---
````

## Default

[[/images/dash/default.png|Default]]

```lua
require('render-markdown').setup({
    dash = {
        enabled = true,
        render_modes = false,
        icon = '─',
        width = 'full',
        left_margin = 0,
        priority = nil,
        highlight = 'RenderMarkdownDash',
    },
})
```

## Icon

[[/images/dash/icon.png|Icon]]

```lua
require('render-markdown').setup({
    dash = { icon = '█' },
})
```

## Width

[[/images/dash/width.png|Width]]

```lua
require('render-markdown').setup({
    dash = { width = 15 },
})
```
