<div align="center">

# `core.looking-glass`

### Code Blocks + Superpowers

The `core.looking-glass` module magnifies code blocks and allows you to edit them in a separate buffer.

![module-showcase](https://user-images.githubusercontent.com/76052559/216782314-5d82907f-ea6c-44f9-9bd8-1675f1849358.gif)

</div>

# Overview

The looking glass module provides a simple way to edit code blocks in an external buffer,
which allows LSPs and other language-specific tools to kick in.

If you would like LSP features in code blocks without having to magnify, you can use
[`core.integrations.otter`](@core.integrations.otter).

## Keybinds

This module exposes the following keybinds (see [`core.keybinds`](https://github.com/nvim-neorg/neorg/wiki/User-Keybinds) for instructions on
mapping them):

- `neorg.looking-glass.magnify-code-block` - magnify the code block under the cursor

# Configuration

This module provides no configuration options!

# Dependencies

- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.
- [`core.ui`](https://github.com/nvim-neorg/neorg/wiki/Core-UI) - A set of public functions to help developers create and manage UI (selection popups, prompts...) in their modules.

