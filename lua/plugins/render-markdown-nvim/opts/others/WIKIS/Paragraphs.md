# Paragraphs

Raw data being used:

````text
# Heading

Single line paragraph.

Line 1 of paragraph,
Line 2 of paragraph,
Line 3 of paragraph.

Another line paragraph.
````

## Default

[[/images/paragraphs/default.png|Default]]

```lua
require('render-markdown').setup({
    paragraph = {
        enabled = true,
        render_modes = false,
        left_margin = 0,
        indent = 0,
        min_width = 0,
    },
})
```

## Center

[[/images/paragraphs/center.png|Center]]

```lua
require('render-markdown').setup({
    paragraph = { left_margin = 0.5 },
})
```

## Center Min Width

[[/images/paragraphs/center-min-width.png|Center Min Width]]

```lua
require('render-markdown').setup({
    paragraph = {
        left_margin = 0.5,
        min_width = 30,
    },
})
```
