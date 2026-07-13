# Checkboxes

Raw data being used:

````text
# Checkboxes

- [ ] Unchecked
- [x] Checked
- [-] Todo
- [~] Custom
````

## Default

[[/images/checkboxes/default.png|Default]]

```lua
require('render-markdown').setup({
    checkbox = {
        enabled = true,
        render_modes = false,
        bullet = false,
        left_pad = 0,
        right_pad = 1,
        unchecked = {
            icon = '󰄱 ',
            highlight = 'RenderMarkdownUnchecked',
            scope_highlight = nil,
        },
        checked = {
            icon = '󰱒 ',
            highlight = 'RenderMarkdownChecked',
            scope_highlight = nil,
        },
        custom = {
            todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
        },
        scope_priority = nil,
    },
})
```

## Icons

[[/images/checkboxes/icons.png|Icons]]

```lua
require('render-markdown').setup({
    checkbox = {
        unchecked = { icon = '✘ ' },
        checked = { icon = '✔ ' },
        custom = { todo = { rendered = '◯ ' } },
    },
})
```

## State

[[/images/checkboxes/state.png|State]]

```lua
require('render-markdown').setup({
    checkbox = {
        custom = {
            important = {
                raw = '[~]',
                rendered = '󰓎 ',
                highlight = 'DiagnosticWarn',
            },
        },
    },
})
```

## Scope

[[/images/checkboxes/scope.png|Scope]]

```lua
require('render-markdown').setup({
    checkbox = { checked = { scope_highlight = '@markup.strikethrough' } },
})
```
