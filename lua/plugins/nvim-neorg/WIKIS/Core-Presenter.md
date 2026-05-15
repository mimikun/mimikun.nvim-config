<div align="center">

# `core.presenter`

### Powerpoint in Neorg

The presenter module creates slideshows out of notes or documents.



</div>

# Overview

The presenter module provides a special Neorg display that resembles an active slideshow
presentation.

To set it up, first be sure to set the `zen_mode` variable in the [configuration](#configuration).
Afterwards, run `:Neorg presenter start` on any Norg file. The presenter will split up your file
at each level 1 heading, and display each in a different slide.

NOTE: This module is due for a rewrite. All of its behaviour is not fully documented here as it will
be overwritten soon anyway.

## Keybinds

This module exposes the following keybinds (see [`core.keybinds`](https://github.com/nvim-neorg/neorg/wiki/User-Keybinds) for instructions on
mapping them):

- `neorg.presenter.next-page` - go to next page
- `neorg.presenter.previous-page` - go to previous page
- `neorg.presenter.close` - close presentation view


# Configuration

* <details open>
  
  <summary><h6><code>zen_mode</h6></code> (string)</summary>
  
  <div>
  
  Zen mode plugin to use. Currenly suppported:
  
  - `zen-mode` - https://github.com/folke/zen-mode.nvim
  - `truezen` - https://github.com/Pocco81/TrueZen.nvim
  
  </div>
  
  ```lua
  ""
  ```
  
  </details>


# Dependencies

- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.
- [`core.queries.native`](https://github.com/nvim-neorg/neorg/wiki/Queries-Module) - TS wrapper in order to fetch nodes using a custom table.
- [`core.ui`](https://github.com/nvim-neorg/neorg/wiki/Core-UI) - A set of public functions to help developers create and manage UI (selection popups, prompts...) in their modules.

