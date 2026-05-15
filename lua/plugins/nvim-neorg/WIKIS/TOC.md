<div align="center">

# `core.qol.toc`

### A Bird's Eye View of Norg Documents

The TOC module generates a table of contents for a given Norg buffer.



</div>

# Overview


The TOC module exposes a single command - `:Neorg toc`. This command can be executed with one of three
optional arguments: `left`, `right` and `qflist`.

When `left` or `right` is supplied, the Table of Contents split is placed on that side of the screen.
When the `qflist` argument is provided, the whole table of contents is sent to the Neovim quickfix list,
should that be more convenient for you.

When in the TOC view, `<CR>` can be pressed on any of the entries to move to that location in the respective
Norg document. The TOC view updates automatically when switching buffers.

# Configuration

* <details open>
  
  <summary><h6><code>auto_toc</h6></code> (table)</summary>
  
  <div>
  
  Options for automatically opening/entering the ToC window
  
  </div>
  
  
  * <details>
    
    <summary><h6><code>close</h6></code> (boolean)</summary>
    
    <div>
    
    Automatically close the ToC window when there is no longer an open norg buffer
    
    </div>
    
    ```lua
    true
    ```
    
    </details>
  * <details>
    
    <summary><h6><code>enter</h6></code> (boolean)</summary>
    
    <div>
    
    Enter an automatically opened ToC window
    
    </div>
    
    ```lua
    false
    ```
    
    </details>
  * <details>
    
    <summary><h6><code>exit_nvim</h6></code> (boolean)</summary>
    
    <div>
    
    Will exit nvim if the ToC is the last buffer on the screen, similar to help windows
    
    </div>
    
    ```lua
    true
    ```
    
    </details>
  * <details>
    
    <summary><h6><code>open</h6></code> (boolean)</summary>
    
    <div>
    
    Automatically open a ToC window when entering any `norg` buffer
    
    </div>
    
    ```lua
    false
    ```
    
    </details>
  
  
  </details>

* <details open>
  
  <summary><h6><code>close_after_use</h6></code> (boolean)</summary>
  
  <div>
  
  Close the Table of Contents after an entry in the table is picked
  
  </div>
  
  ```lua
  false
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>enter</h6></code> (boolean)</summary>
  
  <div>
  
  Enter a ToC window opened manually (any ToC window not opened by auto_toc)
  
  </div>
  
  ```lua
  true
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>fit_width</h6></code> (boolean)</summary>
  
  <div>
  
  Width of the Table of Contents window will automatically fit its longest line, up to
  `max_width`
  
  </div>
  
  ```lua
  true
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>fixed_width</h6></code> (nil)</summary>
  
  <div>
  
  When set, the ToC window will always be this many cols wide.
  will override `fit_width` and ignore `max_width`
  
  </div>
  
  ```lua
  nil
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>max_width</h6></code> (number)</summary>
  
  <div>
  
  Max width of the ToC window when `fit_width = true` (in columns)
  
  </div>
  
  ```lua
  30
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>sync_cursorline</h6></code> (boolean)</summary>
  
  <div>
  
  Enable `cursorline` in the ToC window, and sync the cursor position between ToC and content
  window
  
  </div>
  
  ```lua
  true
  ```
  
  </details>


# Dependencies

- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.
- [`core.ui`](https://github.com/nvim-neorg/neorg/wiki/Core-UI) - A set of public functions to help developers create and manage UI (selection popups, prompts...) in their modules.

