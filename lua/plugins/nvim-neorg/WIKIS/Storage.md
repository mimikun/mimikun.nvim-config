<div align="center">

# `core.storage`

### Store persistent data and query it easily with `core.storage`





</div>


# Configuration

* <details open>
  
  <summary><h6><code>path</h6></code> (string)</summary>
  
  <div>
  
  Full path to store data (saved in mpack data format)
  
  </div>
  
  ```lua
  vim.fn.stdpath("data") .. "/neorg.mpack"
  ```
  
  </details>


# Dependencies

- [`core.autocommands`](https://github.com/nvim-neorg/neorg/wiki/Autocommands) - Handles the creation and management of Neovim's autocommands.

# Required By

- [`core.dirman`](https://github.com/nvim-neorg/neorg/wiki/Dirman) - This module is be responsible for managing directories full of .norg files.
