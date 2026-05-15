<div align="center">

# `core.integrations.treesitter`

### Snazzy Treesitter Integration



![module-showcase](https://user-images.githubusercontent.com/76052559/151668244-9805afc4-8c50-4925-85ec-1098aff5ede6.gif)

</div>

# Overview


## Keybinds

This module exposes the following keybinds (see [`core.keybinds`](https://github.com/nvim-neorg/neorg/wiki/User-Keybinds) for instructions on
mapping them):

- `neorg.treesitter.next.heading` - jump to the next heading
- `neorg.treesitter.next.link` - jump to the next link
- `neorg.treesitter.previous.heading` - jump to the previous heading
- `neorg.treesitter.previous.link` - jump to the previous link

# Configuration

* <details open>
  
  <summary><h6><code>configure_parsers</h6></code> (boolean)</summary>
  
  <div>
  
  If true will auto-configure the parsers to use the recommended setup.
  Set to false only if you install the parsers some other way (ie. nix)
  
  </div>
  
  ```lua
  true
  ```
  
  </details>


# Dependencies

- [`core.highlights`](https://github.com/nvim-neorg/neorg/wiki/Core-Highlights) - Manages your highlight groups with this module.

# Required By

- [`core.clipboard`](https://github.com/nvim-neorg/neorg/wiki/Clipboard) - A module to manipulate and interact with the user's clipboard.
- [`core.completion`](https://github.com/nvim-neorg/neorg/wiki/Completion) - A wrapper to interface with several different completion engines.
- [`core.concealer`](https://github.com/nvim-neorg/neorg/wiki/Concealer) - Enhances the basic Neorg experience by using icons instead of text.
- [`core.esupports.hop`](https://github.com/nvim-neorg/neorg/wiki/Esupports-Hop) - "Hop" between Neorg links, following them with a single keypress.
- [`core.esupports.indent`](https://github.com/nvim-neorg/neorg/wiki/Indent) - A set of instructions for Neovim to indent Neorg documents.
- [`core.esupports.metagen`](https://github.com/nvim-neorg/neorg/wiki/Metagen) - A Neorg module for generating document metadata automatically.
- [`core.export`](https://github.com/nvim-neorg/neorg/wiki/Exporting-Files) - Exports Neorg documents into any other supported filetype.
- [`core.export.markdown`](https://github.com/nvim-neorg/neorg/wiki/Markdown-Export) - Interface for `core.export` to allow exporting to markdown.
- [`core.itero`](https://github.com/nvim-neorg/neorg/wiki/Itero) - Module designed to continue lists, headings and other iterables.
- [`core.journal`](https://github.com/nvim-neorg/neorg/wiki/Journal) - Easily track a journal within Neorg.
- [`core.latex.renderer`](https://github.com/nvim-neorg/neorg/wiki/Core-Latex-Renderer) - An experimental module for rendering latex images inline.
- [`core.looking-glass`](https://github.com/nvim-neorg/neorg/wiki/Looking-Glass) - Allows for editing of code blocks within a separate buffer.
- [`core.pivot`](https://github.com/nvim-neorg/neorg/wiki/Pivot) - Toggles the type of list currently under the cursor.
- [`core.presenter`](https://github.com/nvim-neorg/neorg/wiki/Core-Presenter) - Neorg module to create gorgeous presentation slides.
- [`core.promo`](https://github.com/nvim-neorg/neorg/wiki/Promo) - Promotes or demotes nestable items within Neorg files.
- [`core.qol.toc`](https://github.com/nvim-neorg/neorg/wiki/TOC) - Generates a table of contents for a given Norg buffer.
- [`core.qol.todo_items`](https://github.com/nvim-neorg/neorg/wiki/Todo-Items) - Module for implementing todo lists.
- [`core.queries.native`](https://github.com/nvim-neorg/neorg/wiki/Queries-Module) - TS wrapper in order to fetch nodes using a custom table.
- [`core.summary`](https://github.com/nvim-neorg/neorg/wiki/Summary) - Creates links to all files in any workspace.
- [`core.syntax`](https://github.com/nvim-neorg/neorg/wiki/Syntax) - Handles interaction for syntax files for code blocks.
- [`core.tangle`](https://github.com/nvim-neorg/neorg/wiki/Tangling) - An Advanced Code Block Exporter.
- [`core.text-objects`](https://github.com/nvim-neorg/neorg/wiki/Norg-Text-Objects) - A Neorg module for moving and selecting elements of the document.
- [`core.todo-introspector`](https://github.com/nvim-neorg/neorg/wiki/Todo-Introspector) - Module for displaying progress of completed subtasks in the virtual line.
