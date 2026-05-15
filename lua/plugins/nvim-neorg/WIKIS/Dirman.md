<div align="center">

# `core.dirman`

### The Most Critical Component of any Organized Workflow

The `dirman` module handles different collections of notes in separate directories.



</div>

# Overview

`core.dirman` provides other modules the ability to see which directories the user is in, where
each note collection is stored and how to interact with it.

When writing notes, it is often crucial to have notes on a certain topic be isolated from notes on another topic.
Dirman achieves this with a concept of "workspaces", which are named directories full of `.norg` notes.

To use `core.dirman`, simply load up the module in your configuration and specify the directories you would like to be managed for you:

```lua
require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    my_ws = "~/neorg", -- Format: <name_of_workspace> = <path_to_workspace_root>
                    my_other_notes = "~/work/notes",
                },
                index = "index.norg", -- The name of the main (root) .norg file
            }
        }
    }
}
```

To query the current workspace, run `:Neorg workspace`. To set the workspace, run `:Neorg workspace <workspace_name>`.

### Changing the Current Working Directory
After a recent update `core.dirman` will no longer change the current working directory after switching
workspace. To get the best experience it's recommended to set the `autochdir` Neovim option.


### Create a new note (in lua)
You can use dirman to create new notes in your workspaces.

```lua
local dirman = require('neorg').modules.get_module("core.dirman")
dirman.create_file("my_file", "my_ws", {
    no_open  = false,  -- open file after creation?
    force    = false,  -- overwrite file if exists
    metadata = {}      -- key-value table for metadata fields
})
```

## Keybinds

This module exposes the following keybinds (see [`core.keybinds`](https://github.com/nvim-neorg/neorg/wiki/User-Keybinds) for instructions on
mapping them):

- `neorg.dirman.new-note` - Create a new note in the current workspace, prompt for name


# Configuration

* <details open>
  
  <summary><h6><code>default_workspace</h6></code> (nil)</summary>
  
  <div>
  
  The default workspace to set whenever Neovim starts.
  If a function, will be called with the current workspace and should resolve to a valid workspace name
  
  </div>
  
  ```lua
  nil
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>index</h6></code> (string)</summary>
  
  <div>
  
  The name for the index file.
  
  The index file is the "entry point" for all of your notes.
  
  </div>
  
  ```lua
  "index.norg"
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>open_last_workspace</h6></code> (boolean)</summary>
  
  <div>
  
  Whether to open the last workspace's index file when `nvim` is executed
  without arguments.
  
  May also be set to the string `"default"`, due to which Neorg will always
  open up the index file for the workspace defined in `default_workspace`.
  
  </div>
  
  ```lua
  false
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>use_popup</h6></code> (boolean)</summary>
  
  <div>
  
  Whether to use core.ui.text_popup for `dirman.new.note` event.
  if `false`, will use vim's default `vim.ui.input` instead.
  
  </div>
  
  ```lua
  true
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>workspaces</h6></code> (table)</summary>
  
  <div>
  
  The list of active Neorg workspaces.
  
  There is always an inbuilt workspace called `default`, whose location is
  set to the Neovim current working directory on boot.
  @type table<string, PathlibPath>
  
  </div>
  
  
  * <details>
    
    <summary><h6><code>default</h6></code> (table)</summary>
    
    <br>
    
    ```lua
    require("pathlib").cwd()
    ```
    
    </details>
  
  
  </details>


# Dependencies

- [`core.autocommands`](https://github.com/nvim-neorg/neorg/wiki/Autocommands) - Handles the creation and management of Neovim's autocommands.
- [`core.dirman.utils`](https://github.com/nvim-neorg/neorg/wiki/Dirman-Utils) - A set of utilities for the `core.dirman` module.
- [`core.storage`](https://github.com/nvim-neorg/neorg/wiki/Storage) - Deals with storing persistent data across Neorg sessions.
- [`core.ui`](https://github.com/nvim-neorg/neorg/wiki/Core-UI) - A set of public functions to help developers create and manage UI (selection popups, prompts...) in their modules.

# Required By

- [`core.completion`](https://github.com/nvim-neorg/neorg/wiki/Completion) - A wrapper to interface with several different completion engines.
- [`core.export.html`](https://github.com/nvim-neorg/neorg/wiki/HTML-Export) - Interface for `core.export` to allow exporting to HTML.
- [`core.journal`](https://github.com/nvim-neorg/neorg/wiki/Journal) - Easily track a journal within Neorg.
