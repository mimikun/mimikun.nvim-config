<div align="center">

# `core.todo-introspector`

### See Your Progress at a Glance

The introspector module displays progress for nested tasks.



</div>

# Overview


When an item with a TODO status has children with their own TODOs this module enables virtual text in the top level item and displays the
progress of the subtasks. By default it displays in the format of `[completed/total] (progress%)`.

# Configuration

* <details open>
  
  <summary><h6><code>completed_statuses</h6></code> (list)</summary>
  
  <div>
  
  Which status should count towards the completed count (should be a subset of counted_statuses).
  
  Defaults to the following: `done`.
  
  </div>
  
  
  * <details>
    
    <summary> (string)</summary>
    
    <br>
    
    ```lua
    "done"
    ```
    
    </details>
  
  
  </details>

* <details open>
  
  <summary><h6><code>counted_statuses</h6></code> (list)</summary>
  
  <div>
  
  Which status types to count towards the totol.
  
  Defaults to the following: `done`, `pending`, `undone`, `urgent`.
  
  </div>
  
  
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
    "pending"
    ```
    
    </details>
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
    "urgent"
    ```
    
    </details>
  
  
  </details>

* <details open>
  
  <summary><h6><code>format</h6></code> (function)</summary>
  
  <div>
  
  Callback to format introspector. Takes in two parameters:
  * `completed`: number of completed tasks
  * `total`: number of total counted tasks
  
  Should return a string with the format you want to display the introspector in.
  
  Defaults to "[completed/total] (progress%)"
  
  </div>
  
  ```lua
  function(completed, total)
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>highlight_group</h6></code> (string)</summary>
  
  <div>
  
  Highlight group to display introspector in.
  
  Defaults to "Normal".
  
  </div>
  
  ```lua
  "Normal"
  ```
  
  </details>


# Dependencies

- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.

