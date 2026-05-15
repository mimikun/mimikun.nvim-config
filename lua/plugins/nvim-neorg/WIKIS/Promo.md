<div align="center">

# `core.promo`

### You have Received a Promotion!

The `promo` module increases or decreases the nesting level of nestable items by repeating their characters.



</div>

# Overview

When dealing with Norg, it may sometimes be tedious to continually repeat a single character to increase
your nesting level. For example, for a level 6 nested unordered list, you need to repeat the `-` character
six times:
```norg
------ This is my item!
```

The `core.promo` module allows you to indent these object by utilizing the inbuilt Neovim keybinds:
- `>>` - increase the indentation level for the current object (also dedents children)
- `<<` - decrease the indentation level for the current object recursively (also dedents children)
- `>.` - increase the indentation level for the current object (non-recursively)
- `<,` - decrease the indentation level for the current object (non-recursively)

In insert mode, you are also provided with two keybinds, also being Neovim defaults:
- `<C-t>` increase the indentation level for the current object
- `<C-d>` decrease the indentation level for the current object

This module is commonly used with the [`core.itero`](https://github.com/nvim-neorg/neorg/wiki/Itero) module for an effective workflow.

## Keybinds

This module exposes the following keybinds (see [`core.keybinds`](https://github.com/nvim-neorg/neorg/wiki/User-Keybinds) for instructions on
mapping them):

- `neorg.promo.promote` - Promote item on current line
- `neorg.promo.promote.nested` - Promote current line and nested items
- `neorg.promo.promote.range` - Promote all items in range
- `neorg.promo.demote` - similar
- `neorg.promo.demote.nested` - similar
- `neorg.promo.demote.range` - similar


# Configuration

This module provides no configuration options!

# Dependencies

- [`core.esupports.indent`](https://github.com/nvim-neorg/neorg/wiki/Indent) - A set of instructions for Neovim to indent Neorg documents.
- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.

