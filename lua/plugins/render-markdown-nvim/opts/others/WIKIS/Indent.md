# Indent

Raw data being used:

````text
# Heading 1

Some content.

## Heading 2

> [!NOTE]
> A callout note

### Heading 3

```python
print("Hello, World!")
```

## Heading 2

- List Item 1
- List Item 2
  - Nested List Item 1

### Heading 3

More content

#### Heading 4

| First | Second |
| :---- | ------ |
| Item  | Item   |
````

## Default

[[/images/indent/default.png|Default]]

```lua
require('render-markdown').setup({
    indent = {
        enabled = false,
        render_modes = false,
        per_level = 2,
        skip_level = 1,
        skip_heading = false,
        icon = '▎',
        priority = 0,
        highlight = 'RenderMarkdownIndent',
    },
})
```

## Enabled

[[/images/indent/enabled.png|Enabled]]

```lua
require('render-markdown').setup({
    heading = { border = true },
    indent = { enabled = true },
})
```

## Skip Level

[[/images/indent/skip-level.png|Skip Level]]

```lua
require('render-markdown').setup({
    heading = { border = true },
    indent = {
        enabled = true,
        skip_level = 0,
    },
})
```

## Skip Heading

[[/images/indent/skip-heading.png|Skip Heading]]

```lua
require('render-markdown').setup({
    heading = { border = true },
    indent = {
        enabled = true,
        skip_heading = true,
    },
})
```
