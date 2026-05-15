<div align="center">

# `core.esupports.metagen`

### Manually Writing Metadata? No Thanks

The metagen module automatically places relevant metadata at the top of your `.norg` files.



</div>

# Overview

The metagen module exposes two commands - `:Neorg inject-metadata` and `:Neorg update-metadata`.

- The `inject-metadata` command will remove any existing metadata and overwrite it with fresh information.
- The `update-metadata` preserves existing info, updating things like the `updated` fields (when the file
  was last edited) as well as a few other non-destructive fields.

# Configuration

* <details open>
  
  <summary><h6><code>author</h6></code> (string)</summary>
  
  <div>
  
  Custom author name that overrides default value if not nil or empty
  Default value is autopopulated by querying the current user's system username.
  
  </div>
  
  ```lua
  ""
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>delimiter</h6></code> (string)</summary>
  
  <div>
  
  Custom delimiter between tag and value
  
  </div>
  
  ```lua
  ": "
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>tab</h6></code> (string)</summary>
  
  <div>
  
  How to generate a tabulation inside the `@document.meta` tag
  
  </div>
  
  ```lua
  ""
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>template</h6></code> (nil)</summary>
  
  <div>
  
  Custom template to use for generating content inside `@document.meta` tag
  The template is a list of lists, each defining a key-value pair of metadata
  
  Example:
  ```
  template = {
  -- Default field name without a value will fall back to the default behavior
  { "title" },
  -- Set a custom value for "authors" field
  { "authors", "Vhyrro" },
  -- Fields can be set by lua functions
  {
  "categories",
  function()
  return {"Category-1", "Category-2"}
  end
  }
  }
  ```
  
  </div>
  
  ```lua
  default_template
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>timezone</h6></code> (string)</summary>
  
  <div>
  
  Timezone information in the timestamps
  - "utc" the timestamp is in UTC+0
  - "local" the timestamp is in the local timezone
  - "implicit-local" like "local", but the timezone information is omitted from the timestamp
  
  </div>
  
  ```lua
  "local"
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>type</h6></code> (string)</summary>
  
  <div>
  
  One of "none", "auto" or "empty"
  - "none" generates no metadata
  - "auto" generates metadata if it is not present
  - "empty" generates metadata only for new files/buffers.
  
  </div>
  
  ```lua
  "none"
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>undojoin_updates</h6></code> (boolean)</summary>
  
  <div>
  
  Whether or not to call `:h :undojoin` just before changing the timestamp in
  `update_metadata`. This will make your undo key undo the last change before writing the file
  in addition to the timestamp change. This will move your cursor to the top of the file. For
  users with an autosave plugin, this option must be paired with keybinds for undo/redo to
  avoid problems with undo tree branching:
  ```lua
  vim.keymap.set("n", "u", function()
  require("neorg.modules").get_module("core.esupports.metagen").skip_next_update()
  local k = vim.api.nvim_replace_termcodes("u<c-o>", true, false, true)
  vim.api.nvim_feedkeys(k, 'n', false)
  end)
  vim.keymap.set("n", "<C-r>", function()
  require("neorg.modules").get_module("core.esupports.metagen").skip_next_update()
  local k = vim.api.nvim_replace_termcodes("<c-r><c-o>", true, false, true)
  vim.api.nvim_feedkeys(k, 'n', false)
  end)
  ```
  
  </div>
  
  ```lua
  false
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>update_date</h6></code> (boolean)</summary>
  
  <div>
  
  Whether updated date field should be automatically updated on save if required
  
  </div>
  
  ```lua
  true
  ```
  
  </details>


# Dependencies

- [`core.autocommands`](https://github.com/nvim-neorg/neorg/wiki/Autocommands) - Handles the creation and management of Neovim's autocommands.
- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.

