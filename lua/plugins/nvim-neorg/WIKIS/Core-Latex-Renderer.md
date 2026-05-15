<div align="center">

# `core.latex.renderer`

### Rendering LaTeX with image.nvim





</div>

# Overview


This is an experimental module that requires nvim 0.10+. It renders LaTeX snippets as images
making use of the image.nvim plugin. By default, images are only rendered after running the
command: `:Neorg render-latex`. Rendering can be disabled with `:Neorg render-latex disable`

Requires:
- The [image.nvim](https://github.com/3rd/image.nvim) neovim plugin.
- `latex` executable in path with the following packages:
  - standalone
  - amsmath
  - amssymb
  - graphicx
- `dvipng` executable in path (normally comes with LaTeX)

There's a highlight group that controls the foreground color of the rendered latex:
`@norg.rendered.latex`, configurable in `core.highlights`

# Configuration

* <details open>
  
  <summary><h6><code>conceal</h6></code> (boolean)</summary>
  
  <div>
  
  When true, images of rendered LaTeX will cover the source LaTeX they were produced from.
  Setting this value to false creates more lag, and can be buggy with large numbers of images.
  
  </div>
  
  ```lua
  true
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>debounce_ms</h6></code> (number)</summary>
  
  <div>
  
  Don't re-render anything until 200ms after the buffer has stopped changing. Lowering will
  lead to a more seamless experience but will cause more temporary images to be created
  
  </div>
  
  ```lua
  200
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>dpi</h6></code> (number)</summary>
  
  <div>
  
  "Dots Per Inch" increasing this value will result in crisper images at the expense of
  performance
  
  </div>
  
  ```lua
  350
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>min_length</h6></code> (number)</summary>
  
  <div>
  
  Only render latex snippets that are longer than this many chars. Escaped chars are removed
  spaces are counted, `$` and `$|`/`|$` are not (ie. `$\\int$` counts as 4 chars)
  
  </div>
  
  ```lua
  3
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>render_on_enter</h6></code> (boolean)</summary>
  
  <div>
  
  When true, images will render when a `.norg` buffer is entered
  
  </div>
  
  ```lua
  false
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>renderer</h6></code> (string)</summary>
  
  <div>
  
  Module that renders the images. "core.integrations.image" makes use of image.nvim and is
  currently the only option
  
  </div>
  
  ```lua
  "core.integrations.image"
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>scale</h6></code> (number)</summary>
  
  <div>
  
  Make the images larger or smaller by adjusting the scale. Will not pad images with virtual
  text when `conceal = true`, so they can overlap text. Images will not be blown up larger than
  their true size, so images may still render one line tall.
  
  </div>
  
  ```lua
  1
  ```
  
  </details>


# Dependencies

- [`core.autocommands`](https://github.com/nvim-neorg/neorg/wiki/Autocommands) - Handles the creation and management of Neovim's autocommands.
- [`core.highlights`](https://github.com/nvim-neorg/neorg/wiki/Core-Highlights) - Manages your highlight groups with this module.
- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.
- [`core.neorgcmd`](https://github.com/nvim-neorg/neorg/wiki/Neorgcmd-Module) - This module deals with handling everything related to the `:Neorg` command.

