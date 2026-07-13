# Block Quotes

Raw data being used:

````text
# Normal Quote

> A modest length quote
> Split over
> Multiple lines

# Really Long Quote

> Just a long line
> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ut eleifend metus. Proin velit dui, suscipit in viverra eu, scelerisque dictum elit.
````

## Default

[[/images/quote/default.png|Default]]

```lua
require('render-markdown').setup({
    quote = {
        enabled = true,
        render_modes = false,
        icon = '▋',
        repeat_linebreak = false,
        highlight = {
            'RenderMarkdownQuote1',
            'RenderMarkdownQuote2',
            'RenderMarkdownQuote3',
            'RenderMarkdownQuote4',
            'RenderMarkdownQuote5',
            'RenderMarkdownQuote6',
        },
    },
})
```

## Icon

[[/images/quote/icon.png|Icon]]

```lua
require('render-markdown').setup({
    quote = { icon = '▯' },
})
```

## Break Naive

[[/images/quote/break-naive.png|Break Naive]]

```lua
require('render-markdown').setup({
    quote = { repeat_linebreak = true },
})
```

## Break Works

In the previous example you can see that while the line break has the quote marker
the actual text is being cut off. This is due to all the settings that impact line
break behavior. Rather than validating these we provide an example that works
using the `win_options` field. There are many more ways to accomplish this.

[[/images/quote/break-works.png|Break Works]]

```lua
require('render-markdown').setup({
    quote = { repeat_linebreak = true },
    win_options = {
        showbreak = {
            default = '',
            rendered = '  ',
        },
        breakindent = {
            default = false,
            rendered = true,
        },
        breakindentopt = {
            default = '',
            rendered = '',
        },
    },
})
```
