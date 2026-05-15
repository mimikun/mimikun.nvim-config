<div align="center">

# `core.neorgcmd`

### Does the Heavy Lifting for the `:Neorg` Command





</div>

# Overview

This internal module handles everything there is for the `:Neorg` command to function.

Different modules can define their own commands, completions and conditions on when they'd
like these commands to be avaiable.

For a full example on how to create your own command, it is recommended to read the
`core.neorgcmd`'s `module.lua` file. At the beginning of the file is an examples table
which walks you through the necessary steps.

# Configuration

* <details open>
  
  <summary><h6><code>default</h6></code> (list)</summary>
  
  <div>
  
  A list of default commands to load.
  
  This feature will soon be deprecated, so it is not recommended to touch it.
  
  </div>
  
  
  * <details>
    
    <summary> (string)</summary>
    
    <br>
    
    ```lua
    "return"
    ```
    
    </details>
  
  
  </details>

* <details open>
  
  <summary><h6><code>load</h6></code> (list)</summary>
  
  <div>
  
  A list of neorgcmd modules to load automatically.
  This feature will soon be deprecated, so it is not recommended to touch it.
  
  </div>
  
  
  * <details>
    
    <summary> (string)</summary>
    
    <br>
    
    ```lua
    "default"
    ```
    
    </details>
  
  
  </details>



# Required By

- [`core.latex.renderer`](https://github.com/nvim-neorg/neorg/wiki/Core-Latex-Renderer) - An experimental module for rendering latex images inline.
- [`core.neorgcmd.commands.return`](https://github.com/nvim-neorg/neorg/wiki/Neorgcmd-return) - Return to last location before entering Neorg.
- [`core.tangle`](https://github.com/nvim-neorg/neorg/wiki/Tangling) - An Advanced Code Block Exporter.
