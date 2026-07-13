# Latex

Raw data being used:

````text
# Latex

$\begin{pmatrix}1\\2\end{pmatrix}$ + $\begin{pmatrix}1\\2\\3\end{pmatrix}$

$\sqrt{3x-1}+(1+x)^2$

$$
\lim_{n\to\infty} \left(1 + \frac{1}{n}\right)^n
$$
````

## Default

[[/images/latex/default.png|Default]]

```lua
require('render-markdown').setup({
    latex = {
        enabled = true,
        render_modes = false,
        converter = { 'utftex', 'latex2text' },
        inline = true,
        block = true,
        highlight = 'RenderMarkdownMath',
        position = 'center',
        top_pad = 0,
        bottom_pad = 0,
    },
})
```

## Above

[[/images/latex/above.png|Above]]

```lua
require('render-markdown').setup({
    latex = { position = 'above' },
})
```

## Below

[[/images/latex/below.png|Below]]

```lua
require('render-markdown').setup({
    latex = { position = 'below' },
})
```

## Padding Top

[[/images/latex/padding-top.png|Padding Top]]

```lua
require('render-markdown').setup({
    latex = { top_pad = 1 },
})
```

## Padding Bottom

[[/images/latex/padding-bottom.png|Padding Bottom]]

```lua
require('render-markdown').setup({
    latex = { bottom_pad = 1 },
})
```

## Disabled

[[/images/latex/disabled.png|Disabled]]

```lua
require('render-markdown').setup({
    latex = { enabled = false },
})
```
