<div align="center">

# `core.pivot`

### Ordered or Unordered?

That ~~is~~ was the question. Now you no longer have to ask!



</div>

# Overview

`core.pivot` allows you to switch (or pivot) between the two list types in Norg with the press of a button.

## Keybinds

This module exposes the following keybinds (see [`core.keybinds`](https://github.com/nvim-neorg/neorg/wiki/User-Keybinds) for instructions on
mapping them):

- `neorg.pivot.list.toggle` (default binding: `<LocalLeader>lt` ["list toggle"]) - takes a
  list and, based on the opposite type of the first list item, inverts all the other items in that list.
  Does not respect mixed lists, all items in the list will be converted to the same type.
- `neorg.pivot.list.invert` (default binding: `<LocalLeader>li` ["list invert"]) - same behaviour as
  the previous keybind, however respects mixed lists - unordered items will become ordered, whereas ordered
  items will become unordered.

# Configuration

This module provides no configuration options!

# Dependencies

- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.

