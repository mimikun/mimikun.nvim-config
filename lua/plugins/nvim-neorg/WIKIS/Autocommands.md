<div align="center">

# `core.autocommands`

### 

Handles the creation and management of Neovim's autocommands.



</div>

# Overview

This internal module exposes functionality for subscribing to autocommands and performing actions based on those autocommands.

###### NOTE: This module will be soon deprecated, and it's favourable to use the `vim.api*` functions instead.

In your `module.setup()`, make sure to require `core.autocommands` (`requires = { "core.autocommands" }`)
Afterwards in a function of your choice that gets called *after* core.autocommmands gets intialized (e.g. `load()`):

```lua
module.load = function()
    module.required["core.autocommands"].enable_autocommand("VimLeavePre") -- Substitute VimLeavePre for any valid neovim autocommand
end
```

Afterwards, be sure to subscribe to the event:

```lua
module.events.subscribed = {
    ["core.autocommands"] = {
        vimleavepre = true
    }
}
```

Upon receiving an event, it will come in this format:
```lua
{
    type = "core.autocommands.events.<name of autocommand, e.g. vimleavepre>",
    broadcast = true
}
```

# Configuration

This module provides no configuration options!


# Required By

- [`core.concealer`](https://github.com/nvim-neorg/neorg/wiki/Concealer) - Enhances the basic Neorg experience by using icons instead of text.
- [`core.dirman`](https://github.com/nvim-neorg/neorg/wiki/Dirman) - This module is be responsible for managing directories full of .norg files.
- [`core.esupports.indent`](https://github.com/nvim-neorg/neorg/wiki/Indent) - A set of instructions for Neovim to indent Neorg documents.
- [`core.esupports.metagen`](https://github.com/nvim-neorg/neorg/wiki/Metagen) - A Neorg module for generating document metadata automatically.
- [`core.highlights`](https://github.com/nvim-neorg/neorg/wiki/Core-Highlights) - Manages your highlight groups with this module.
- [`core.latex.renderer`](https://github.com/nvim-neorg/neorg/wiki/Core-Latex-Renderer) - An experimental module for rendering latex images inline.
- [`core.storage`](https://github.com/nvim-neorg/neorg/wiki/Storage) - Deals with storing persistent data across Neorg sessions.
- [`core.syntax`](https://github.com/nvim-neorg/neorg/wiki/Syntax) - Handles interaction for syntax files for code blocks.
