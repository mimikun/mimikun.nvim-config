<div align="center">

# `core.export.markdown`

### Neorg's Markdown Exporter





</div>

# Overview

This module exists as an interface for `core.export` to export `.norg` files to Markdown.
As a user the only reason you would ever have to touch this module is to configure *how* you'd
like your markdown to be exported (i.e. do you want to support certain extensions during the export).
To learn more about configuration, consult the [relevant section](#configuration).

# Configuration

* <details open>
  
  <summary><h6><code>extension</h6></code> (string)</summary>
  
  <div>
  
  Used by the exporter to know what extension to use
  when creating markdown files.
  The default is recommended, although you can change it.
  
  </div>
  
  ```lua
  "md"
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>extensions</h6></code> (empty list)</summary>
  
  <div>
  
  Any extensions you may want to use when exporting to markdown. By
  default no extensions are loaded (the exporter is commonmark compliant).
  You can also set this value to `"all"` to enable all extensions.
  The full extension list is: `todo-items-basic`, `todo-items-pending`, `todo-items-extended`,
  `definition-lists`, `mathematics`, `metadata` and `latex`.
  
  </div>
  
  
  
  
  </details>

* <details open>
  
  <summary><h6><code>mathematics</h6></code> (table)</summary>
  
  <div>
  
  Data about how to render mathematics.
  The default is recommended as it is the most common, although certain flavours
  of markdown use different syntax.
  
  </div>
  
  
  * <details>
    
    <summary><h6><code>block</h6></code> (table)</summary>
    
    <div>
    
    Block-level mathematics are represented as such:
    
    ```md
    $$
    \frac{3, 2}
    $$
    ```
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>end</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "$$"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>start</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "$$"
      ```
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>inline</h6></code> (table)</summary>
    
    <div>
    
    Inline mathematics are represented `$like this$`.
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>end</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "$"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>start</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "$"
      ```
      
      </details>
    
    
    </details>
  
  
  </details>

* <details open>
  
  <summary><h6><code>metadata</h6></code> (table)</summary>
  
  <div>
  
  Data about how to render metadata
  There are a few ways to render metadata blocks, but this is the most
  common.
  
  </div>
  
  
  * <details>
    
    <summary><h6><code>end</h6></code> (string)</summary>
    
    <br>
    
    ```lua
    "---"
    ```
    
    </details>
  * <details>
    
    <summary><h6><code>start</h6></code> (string)</summary>
    
    <br>
    
    ```lua
    "---"
    ```
    
    </details>
  
  
  </details>


# Dependencies

- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.

