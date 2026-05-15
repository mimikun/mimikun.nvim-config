<div align="center">

# `core.text-objects`

### Navigation, Selection, and Swapping





</div>

# Overview


- Easily move items up and down in the document
- Provides text objects for headings, tags, and lists

## Usage

Users can create keybinds for some or all of the different events this module exposes. Those are:

- `core.text-objects.item_up` - Moves the current "item" up
- `core.text-objects.item_down` - same but down
- `core.text-objects.textobject.heading.outer`
- `core.text-objects.textobject.heading.inner`
- `core.text-objects.textobject.tag.inner`
- `core.text-objects.textobject.tag.outer`
- `core.text-objects.textobject.list.outer` - around the entire list

_Movable "items" include headings, and list items (ordered/unordered/todo)_

### Example

Example keybinds that would go in your Neorg configuration:

```lua
vim.keymap.set("n", "<up>", "<Plug>(neorg.text-objects.item-up)", {})
vim.keymap.set("n", "<down>", "<Plug>(neorg.text-objects.item-down)", {})
vim.keymap.set({ "o", "x" }, "iH", "<Plug>(neorg.text-objects.textobject.heading.inner)", {})
vim.keymap.set({ "o", "x" }, "aH", "<Plug>(neorg.text-objects.textobject.heading.outer)", {})
```


# Configuration

* <details open>
  
  <summary><h6><code>moveables</h6></code> (table)</summary>
  
  <br>
  
  
  * <details>
    
    <summary><h6><code>headings</h6></code> (list)</summary>
    
    <br>
    
    
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
      "heading%d"
      ```
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>todo_items</h6></code> (list)</summary>
    
    <br>
    
    
    * <details>
      
      <summary> (string)</summary>
      
      <br>
      
      ```lua
      "todo_item%d"
      ```
      
      </details>
    * <details>
      
      <summary> (list)</summary>
      
      <br>
      
      
      * <details>
        
        <summary> (string)</summary>
        
        <br>
        
        ```lua
        "todo_item%d"
        ```
        
        </details>
      * <details>
        
        <summary> (string)</summary>
        
        <br>
        
        ```lua
        "unordered_list%d"
        ```
        
        </details>
      
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>unordered_list_elements</h6></code> (list)</summary>
    
    <br>
    
    
    * <details>
      
      <summary> (string)</summary>
      
      <br>
      
      ```lua
      "unordered_list%d"
      ```
      
      </details>
    * <details>
      
      <summary> (list)</summary>
      
      <br>
      
      
      * <details>
        
        <summary> (string)</summary>
        
        <br>
        
        ```lua
        "todo_item%d"
        ```
        
        </details>
      * <details>
        
        <summary> (string)</summary>
        
        <br>
        
        ```lua
        "unordered_list%d"
        ```
        
        </details>
      
      
      </details>
    
    
    </details>
  
  
  </details>


# Dependencies

- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.

