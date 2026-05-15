<div align="center">

# `core.itero`

### Fast List/Heading Continuation

Fluidness is key, after all.

![module-showcase](https://user-images.githubusercontent.com/76052559/216777858-14e2036e-acc5-4276-aa7d-9a8a8ba549ba.gif)

</div>

# Overview

`core.itero` is a rather small and simple module designed to assist in the creation of many lists,
headings and other repeatable (iterable) items.

By default, the key that is used to iterate on an item is `<M-CR>` (Alt + Enter). If you want to
change the bind, remap the `neorg.itero.next-iteration` event.

Begin by writing an initial item you'd like to iterate (in this instance, and unordered list item):
```md
- Hello World!
```

With your cursor in insert mode at the end of the line, pressing the keybind will continue the item at whatever
nesting level it is currently at (where `|` is the new cursor position):
```md
- Hello World!
- |
```

The same can also be done for headings:
```md
* Heading 1
* |
```

This functionality is commonly paired with the [`core.promo`](https://github.com/nvim-neorg/neorg/wiki/Promo) module to then indent/dedent
the item under the cursor with the `<C-t>` and `<C-d>` bindings.

# Configuration

* <details open>
  
  <summary><h6><code>iterables</h6></code> (list)</summary>
  
  <div>
  
  A list of lua patterns detailing what treesitter nodes can be "iterated".
  Usually doesn't need to be changed, unless you want to disable some
  items from being iterable.
  
  </div>
  
  
  * <details>
    
    <summary> (string)</summary>
    
    <br>
    
    ```lua
    "unordered_list%d"
    ```
    
    </details>
  * <details>
    
    <summary> (string)</summary>
    
    <br>
    
    ```lua
    "ordered_list%d"
    ```
    
    </details>
  * <details>
    
    <summary> (string)</summary>
    
    <br>
    
    ```lua
    "heading%d"
    ```
    
    </details>
  * <details>
    
    <summary> (string)</summary>
    
    <br>
    
    ```lua
    "quote%d"
    ```
    
    </details>
  
  
  </details>

* <details open>
  
  <summary><h6><code>retain_extensions</h6></code> (table)</summary>
  
  <div>
  
  Which item types to retain extensions for.
  
  If the item you are currently iterating has an extension (e.g. `( )`, `(x)` etc.),
  then the following items will also have an extension (by default `( )`) attached
  to them automatically.
  
  </div>
  
  
  * <details>
    
    <summary><h6><code>ordered_list%d</h6></code> (boolean)</summary>
    
    <br>
    
    ```lua
    true
    ```
    
    </details>
  * <details>
    
    <summary><h6><code>unordered_list%d</h6></code> (boolean)</summary>
    
    <br>
    
    ```lua
    true
    ```
    
    </details>
  
  
  </details>


# Dependencies

- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.

