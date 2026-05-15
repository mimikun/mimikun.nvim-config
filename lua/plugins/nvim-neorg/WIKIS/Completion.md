<div align="center">

# `core.completion`

### Get completions in Neorg files





</div>

# Overview


This module is an intermediary between Neorg and the completion engine of your choice. After setting up this
module (this usually just involves setting the `engine` field in the [configuration](#configuration) section),
please read the corresponding wiki page for the engine you selected ([`nvim-cmp`](https://github.com/nvim-neorg/neorg/wiki/Nvim-Cmp)
[`coq_nvim`](@core.integrations.coq_nvim) or [`nvim-compe`](https://github.com/nvim-neorg/neorg/wiki/Nvim-Compe)) to complete setup.

Completions are provided in the following cases (examples in (), `|` represents the cursor location):
- TODO items (`- (|`)
- @ tags (`@|`)
- \# tags (`#|`)
- file path links (`{:|`) provides workspace relative paths (`:$/workspace/relative/path:`)
- header links (`{*|`)
- fuzzy header links (`{#|`)
- footnotes (`{^|`)
- file path + header links (`{:path:*|`)
- file path + fuzzy header links (`{:path:#|`)
- file path + footnotes (`{:path:^|`)
- anchor names (`[|`)
- link names (`{<somelink>}[|`)

Header completions will show only valid headers at the current level in the current or specified file. All
link completions are smart about closing `:` and `}`.

# Configuration

* <details open>
  
  <summary><h6><code>engine</h6></code> (nil)</summary>
  
  <div>
  
  The engine to use for completion.
  
  Possible values:
  - [`"nvim-cmp"`](https://github.com/nvim-neorg/neorg/wiki/Nvim-Cmp)
  - [`"coq_nvim"`](@core.integrations.coq_nvim)
  - [`"nvim-compe"`](https://github.com/nvim-neorg/neorg/wiki/Nvim-Compe)
  - `{ module_name = "external.lsp-completion" }` this must be used with
  [neorg-interim-ls](https://github.com/benlubas/neorg-interim-ls) and can provide
  completions through a shim Language Server. This allows users without an auto complete
  plugin to still get Neorg completions
  
  </div>
  
  ```lua
  nil
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>name</h6></code> (string)</summary>
  
  <div>
  
  The identifier for the Neorg source.
  
  </div>
  
  ```lua
  "[Neorg]"
  ```
  
  </details>


# Dependencies

- [`core.dirman`](https://github.com/nvim-neorg/neorg/wiki/Dirman) - This module is be responsible for managing directories full of .norg files.
- [`core.dirman.utils`](https://github.com/nvim-neorg/neorg/wiki/Dirman-Utils) - A set of utilities for the `core.dirman` module.
- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.

