# Tables

Raw data being used:

````text
# Table


| `Left` | *Center* | Right  | Default |
|  :---  | :----:   |-------:| --------|
| `Code` | **Bold** | ~~Strike~~ |Item     |
| Item   | [Link](/test) | Item   |  Item   |
|       1| 2        | 3      | 4       |
````

## Default

[[/images/table/default.png|Default]]

```lua
require('render-markdown').setup({
    pipe_table = {
        enabled = true,
        render_modes = false,
        preset = 'none',
        cell = 'padded',
        cell_offset = function()
            return 0
        end,
        padding = 1,
        min_width = 0,
        border = {
            '┌', '┬', '┐',
            '├', '┼', '┤',
            '└', '┴', '┘',
            '│', '─',
        },
        border_enabled = true,
        border_virtual = false,
        alignment_indicator = '━',
        head = 'RenderMarkdownTableHead',
        row = 'RenderMarkdownTableRow',
        style = 'full',
    },
})
```

## Normal

[[/images/table/normal.png|Normal]]

```lua
require('render-markdown').setup({
    pipe_table = { style = 'normal' },
})
```

## Min Width

[[/images/table/min-width.png|Min Width]]

```lua
require('render-markdown').setup({
    pipe_table = { min_width = 12 },
})
```

## Round

[[/images/table/round.png|Round]]

```lua
require('render-markdown').setup({
    pipe_table = { preset = 'round' },
})
```

## Double

[[/images/table/double.png|Double]]

```lua
require('render-markdown').setup({
    pipe_table = { preset = 'double' },
})
```

## Heavy

[[/images/table/heavy.png|Heavy]]

```lua
require('render-markdown').setup({
    pipe_table = { preset = 'heavy' },
})
```

## Custom

[[/images/table/custom.png|Custom]]

```lua
require('render-markdown').setup({
    pipe_table = {
        border = { '╓', '╥', '╖', '╟', '╫', '╢', '╙', '╨', '╜', '║', '─' },
    },
})
```

## Indicator

[[/images/table/indicator.png|Indicator]]

```lua
require('render-markdown').setup({
    pipe_table = { alignment_indicator = '┅' },
})
```

## Cell Trimmed

[[/images/table/cell-trimmed.png|Cell Trimmed]]

```lua
require('render-markdown').setup({
    pipe_table = { cell = 'trimmed' },
})
```

## Cell Raw

[[/images/table/cell-raw.png|Cell Raw]]

```lua
require('render-markdown').setup({
    pipe_table = { cell = 'raw' },
})
```

## Cell Overlay

[[/images/table/cell-overlay.png|Cell Overlay]]

```lua
require('render-markdown').setup({
    pipe_table = { cell = 'overlay' },
})
```
