# Links

Raw data being used:

````text
# Links

- ![Image](test.png)
- [Markdown File](test.md)
- [Python File](test.py)
- [Website](https://test.com)
- [[wikilink]]
- [[wikilink|Wikilink Alias]]
- [Reference][example]
- <user@test.com>
````

## Default

[[/images/link/default.png|Default]]

```lua
require('render-markdown').setup({
    link = {
        enabled = true,
        render_modes = false,
        footnote = {
            enabled = true,
            icon = '󰯔 ',
            body = function(ctx)
                return ctx.text
            end,
            superscript = true,
            prefix = '',
            suffix = '',
        },
        image = '󰥶 ',
        image_custom = true,
        email = '󰀓 ',
        hyperlink = '󰌹 ',
        highlight = 'RenderMarkdownLink',
        highlight_title = 'RenderMarkdownLinkTitle',
        wiki = {
            enabled = true,
            icon = '󱗖 ',
            conceal_destination = true,
            body = function()
                return nil
            end,
            highlight = 'RenderMarkdownWikiLink',
            scope_highlight = nil,
        },
        custom = {
            web = { icon = '󰖟 ', pattern = '^http' },
            apple = { icon = ' ', pattern = 'apple%.com', kind = 'url' },
            discord = { icon = '󰙯 ', pattern = 'discord%.com', kind = 'url' },
            github = { icon = '󰊤 ', pattern = 'github%.com', kind = 'url' },
            gitlab = { icon = '󰮠 ', pattern = 'gitlab%.com', kind = 'url' },
            google = { icon = '󰊭 ', pattern = 'google%.com', kind = 'url' },
            hackernews = { icon = ' ', pattern = 'ycombinator%.com', kind = 'url' },
            linkedin = { icon = '󰌻 ', pattern = 'linkedin%.com', kind = 'url' },
            microsoft = { icon = ' ', pattern = 'microsoft%.com', kind = 'url' },
            neovim = { icon = ' ', pattern = 'neovim%.io', kind = 'url' },
            reddit = { icon = '󰑍 ', pattern = 'reddit%.com', kind = 'url' },
            slack = { icon = '󰒱 ', pattern = 'slack%.com', kind = 'url' },
            stackoverflow = { icon = '󰓌 ', pattern = 'stackoverflow%.com', kind = 'url' },
            steam = { icon = ' ', pattern = 'steampowered%.com', kind = 'url' },
            twitter = { icon = ' ', pattern = 'twitter%.com', kind = 'url' },
            wikipedia = { icon = '󰖬 ', pattern = 'wikipedia%.org', kind = 'url' },
            x = { icon = ' ', pattern = 'x%.com', kind = 'url' },
            youtube = { icon = '󰗃 ', pattern = 'youtube[^.]*%.com', kind = 'url' },
            youtube_short = { icon = '󰗃 ', pattern = 'youtu%.be', kind = 'url' },
        },
    },
})
```

## Image Icon

[[/images/link/image-icon.png|Image Icon]]

```lua
require('render-markdown').setup({
    link = { image = '󰋵 ' },
})
```

## Email Icon

[[/images/link/email-icon.png|Email Icon]]

```lua
require('render-markdown').setup({
    link = { email = ' ' },
})
```

## Link Icon

[[/images/link/link-icon.png|Link Icon]]

```lua
require('render-markdown').setup({
    link = { hyperlink = '󰌷 ' },
})
```

## Python Icon

[[/images/link/python-icon.png|Python Icon]]

```lua
require('render-markdown').setup({
    link = {
        custom = {
            python = {
                pattern = '%.py$',
                icon = '󰌠 ',
            },
        },
    },
})
```
