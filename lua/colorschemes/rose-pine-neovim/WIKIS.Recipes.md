## Lovely statusline

> Feel free to change "love" to your favourite Rosé Pine accent colour

<img width="705" alt="Screenshot 2023-02-23 at 14 31 40" src="https://user-images.githubusercontent.com/1474821/221023421-2f57284e-5b40-4cec-967d-9d5a18ce7128.png">

```lua
vim.opt.laststatus = 2 -- Or 3 for global statusline
vim.opt.statusline = " %f %m %= %l:%c ♥ "

require("rose-pine").setup({
	highlight_groups = {
		StatusLine = { fg = "love", bg = "love", blend = 10 },
		StatusLineNC = { fg = "subtle", bg = "surface" },
	},
})
```

## Roseline

![Captura de tela de 2024-01-28 16-21-39](https://github.com/rose-pine/neovim/assets/50273941/7cd3a342-80b1-4454-8884-8e019b0daa32)

[repo](https://github.com/maxmx03/roseline)

## Leafy search

<img width="64" alt="Leaf coloured search highlights on Rosé Pine" src="https://github.com/user-attachments/assets/e62f669a-0da8-4711-bb88-9c799eb16125">

<img width="64" alt="Leaf coloured search highlights on Rosé Pine Dawn" src="https://github.com/user-attachments/assets/8aad67ae-afc0-432a-ac15-193dfcaa8f53">

```lua
require("rose-pine").setup({
	highlight_groups = {
		CurSearch = { fg = "base", bg = "leaf", inherit = false },
		Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },
	},
})
```

## Transparent telescope.nvim

> This example uses "base" instead of "none" in some cases to match our [kitty theme](https://github.com/rose-pine/kitty) and kitty's [background opacity](https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.background_opacity) feature

Remove selected background and use foreground + bright caret to distinguish current selection.

<img width="1440" alt="Screenshot 2023-02-23 at 14 02 47" src="https://user-images.githubusercontent.com/1474821/221020548-c621dbcd-e593-4c4e-b825-b0bcf3907f79.png">

```lua
require("rose-pine").setup({
	highlight_groups = {
		TelescopeBorder = { fg = "highlight_high", bg = "none" },
		TelescopeNormal = { bg = "none" },
		TelescopePromptNormal = { bg = "base" },
		TelescopeResultsNormal = { fg = "subtle", bg = "none" },
		TelescopeSelection = { fg = "text", bg = "base" },
		TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
	},
})
```

## Borderless telescope.nvim


![](https://user-images.githubusercontent.com/314453/267959977-23f287df-e69b-4636-8da7-b82e119e3468.png)

![](https://user-images.githubusercontent.com/314453/267960069-3a967e62-c959-4734-9d45-f4f6cf402064.png)

```lua
require("rose-pine").setup({
    highlight_groups = {
        TelescopeBorder = { fg = "overlay", bg = "overlay" },
        TelescopeNormal = { fg = "subtle", bg = "overlay" },
        TelescopeSelection = { fg = "text", bg = "highlight_med" },
        TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
        TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },

        TelescopeTitle = { fg = "base", bg = "love" },
        TelescopePromptTitle = { fg = "base", bg = "pine" },
        TelescopePreviewTitle = { fg = "base", bg = "iris" },

        TelescopePromptNormal = { fg = "text", bg = "surface" },
        TelescopePromptBorder = { fg = "surface", bg = "surface" },
    },
})
```