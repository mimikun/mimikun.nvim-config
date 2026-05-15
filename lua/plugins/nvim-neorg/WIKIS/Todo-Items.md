<div align="center">

# `core.qol.todo_items`

### Todo Item Swiss Army Knife





</div>

# Overview

This module handles the whole concept of toggling TODO items, as well as updating
parent and/or children items alongside the current item.

The following keybinds are exposed (with their default binds):
- `<Plug>(neorg.qol.todo-items.todo.task-done)` (`<LocalLeader>td`)
- `<Plug>(neorg.qol.todo-items.todo.task-undone)` (`<LocalLeader>tu`)
- `<Plug>(neorg.qol.todo-items.todo.task-pending)` (`<LocalLeader>tp`)
- `<Plug>(neorg.qol.todo-items.todo.task-on_hold)` (`<LocalLeader>th`)
- `<Plug>(neorg.qol.todo-items.todo.task-cancelled)` (`<LocalLeader>tc`)
- `<Plug>(neorg.qol.todo-items.todo.task-recurring)` (`<LocalLeader>tr`)
- `<Plug>(neorg.qol.todo-items.todo.task-important)` (`<LocalLeader>ti`)
- `<Plug>(neorg.qol.todo-items.todo.task-cycle)` (`<C-Space>`)
- `<Plug>(neorg.qol.todo-items.todo.task-cycle-reverse)` (no default keybind)

With your cursor on a line that contains an item with a TODO attribute, press
any of the above keys to toggle the state of that particular item.
Parent items of the same type and children items of the same type are update accordingly.

# Configuration

* <details open>
  
  <summary><h6><code>create_todo_items</h6></code> (boolean)</summary>
  
  <div>
  
  When `true`, will automatically create a TODO extension for an item
  if it does not exist and an operation is performed on that item.
  
  Given the following example:
  ```norg
  - Test Item
  ```
  With this option set to true, performing an operation (like pressing `<C-space>`
  or what have you) will convert the non-todo item into one:
  ```norg
  - ( ) Test Item
  ```
  
  </div>
  
  ```lua
  true
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>create_todo_parents</h6></code> (boolean)</summary>
  
  <div>
  
  When set to `true`, will automatically convert parent
  items to TODOs whenever a child item's TODO state is updated.
  
  For instance, given the following example:
  ```norg
  - Text
  -- ( ) Child text
  ```
  
  When this option is `true` and the child's state is updated to e.g.
  `(x)` via the `<LocaLeader>td` keybind, the new output becomes:
  ```norg
  - (x) Text
  -- (x) Child text
  ```
  
  </div>
  
  ```lua
  false
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>order</h6></code> (list)</summary>
  
  <div>
  
  The default order of TODO item cycling when cycling via
  `<C-Space>`.
  
  Defaults to the following order: `undone`, `done`, `pending`.
  
  </div>
  
  
  * <details>
    
    <summary> (list)</summary>
    
    <br>
    
    
    * <details>
      
      <summary> (string)</summary>
      
      <br>
      
      ```lua
      "undone"
      ```
      
      </details>
    * <details>
      
      <summary> (string)</summary>
      
      <br>
      
      ```lua
      " "
      ```
      
      </details>
    
    
    </details>
  * <details>
    
    <summary> (list)</summary>
    
    <br>
    
    
    * <details>
      
      <summary> (string)</summary>
      
      <br>
      
      ```lua
      "done"
      ```
      
      </details>
    * <details>
      
      <summary> (string)</summary>
      
      <br>
      
      ```lua
      "x"
      ```
      
      </details>
    
    
    </details>
  * <details>
    
    <summary> (list)</summary>
    
    <br>
    
    
    * <details>
      
      <summary> (string)</summary>
      
      <br>
      
      ```lua
      "pending"
      ```
      
      </details>
    * <details>
      
      <summary> (string)</summary>
      
      <br>
      
      ```lua
      "-"
      ```
      
      </details>
    
    
    </details>
  
  
  </details>

* <details open>
  
  <summary><h6><code>order_with_children</h6></code> (list)</summary>
  
  <div>
  
  The default order of TODO item cycling when the item
  has nested children with TODO items.
  
  When cycling through TODO items with children it's not
  always sensible to follow the same schema as the `order` table.
  
  Defaults to the following order: `undone`, `done`.
  
  </div>
  
  
  * <details>
    
    <summary> (list)</summary>
    
    <br>
    
    
    * <details>
      
      <summary> (string)</summary>
      
      <br>
      
      ```lua
      "undone"
      ```
      
      </details>
    * <details>
      
      <summary> (string)</summary>
      
      <br>
      
      ```lua
      " "
      ```
      
      </details>
    
    
    </details>
  * <details>
    
    <summary> (list)</summary>
    
    <br>
    
    
    * <details>
      
      <summary> (string)</summary>
      
      <br>
      
      ```lua
      "done"
      ```
      
      </details>
    * <details>
      
      <summary> (string)</summary>
      
      <br>
      
      ```lua
      "x"
      ```
      
      </details>
    
    
    </details>
  
  
  </details>

* <details open>
  
  <summary><h6><code>update_todo_parents</h6></code> (boolean)</summary>
  
  <div>
  
  Automatically update the parent todo state when a child node is updated.
  
  eg:
  ```norg
  - ( ) parent
  -- ( ) child
  ```
  Marking `-- ( ) child` as done (with a keybind) will result in:
  ```norg
  - (-) parent
  -- (x) child
  ```
  
  </div>
  
  ```lua
  true
  ```
  
  </details>


# Dependencies

- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.

