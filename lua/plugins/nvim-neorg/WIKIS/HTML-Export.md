<div align="center">

# `core.export.html`

### Neorg's HTML Exporter





</div>

# Overview

This module exists as an interface for `core.export` to export `.norg` files to HTML.
As a user the only reason you would ever have to touch this module is to configure *how* you'd
like your markdown to be exported (i.e. do you want to support certain extensions during the export).
To learn more about configuration, consult the [relevant section](#configuration).

# Configuration

* <details open>
  
  <summary><h6><code>extension</h6></code> (string)</summary>
  
  <div>
  
  Used by the exporter to know what extension to use
  when creating HTML files.
  The default is recommended, although you can change it.
  
  </div>
  
  ```lua
  "html"
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>link_builders</h6></code> (table)</summary>
  
  <br>
  
  
  * <details>
    
    <summary><h6><code>fragment_builder</h6></code> (function)</summary>
    
    <div>
    
    Function handler for building just the fragment. The fragment is the part
    of the URL that comes after the "#" and it's used for linking to specific
    IDs within a file.
    @param args FragmentArgs
    @return string
    
    </div>
    
    ```lua
    function(args)
    ```
    
    </details>
  * <details>
    
    <summary><h6><code>link_builder</h6></code> (function)</summary>
    
    <div>
    
    Function handler for building the entire link. If you change this handler
    you'll need to change
    @param link Link
    @return string
    
    </div>
    
    ```lua
    function(link)
    ```
    
    </details>
  * <details>
    
    <summary><h6><code>path_builder</h6></code> (function)</summary>
    
    <div>
    
    Function handler for building just the path URL path.
    @param link Link
    @return string
    
    </div>
    
    ```lua
    function(link)
    ```
    
    </details>
  
  
  </details>

* <details open>
  
  <summary><h6><code>ranged_tag_handler</h6></code> (empty list)</summary>
  
  <div>
  
  If you'd like to modify the way specific range tabs are handled. For
  example if you wanted to translate document.meta into use-case specific
  HTML, you could so here (see: module.private[ranged_tag_handler""] for
  examples).
  
  </div>
  
  
  
  
  </details>


# Dependencies

- [`core.dirman`](https://github.com/nvim-neorg/neorg/wiki/Dirman) - This module is be responsible for managing directories full of .norg files.
- [`core.esupports.hop`](https://github.com/nvim-neorg/neorg/wiki/Esupports-Hop) - "Hop" between Neorg links, following them with a single keypress.

