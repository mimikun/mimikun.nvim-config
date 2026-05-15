<div align="center">

# Welcome to the Neorg wiki!
Want to know how to properly use Neorg? Your answers are contained here.

</div>

# Kickstart

If you would like a Neovim setup that has Neorg configured out of the box look no further than the [kickstart guide](https://github.com/nvim-neorg/neorg/wiki/Kickstart)!

# Using Neorg

Neorg depends on a number of other technologies, all of which have to be correctly configured to keep Neorg running smoothly.
For some help on understanding how your terminal, Neovim, colourschemes, tree-sitter and more come together to produce your Neorg experience (or Neorg problems), see [this document on understanding Neorg dependencies](Dependencies).

At first configuring Neorg might be rather scary. I have to define what modules I want to use in the `require('neorg').setup()` function?
I don't even know what the default available values are!
Don't worry, there are guides you are free to check out. The [tutorial](https://github.com/nvim-neorg/neorg/wiki/Tutorial) guides you through what Neorg is and its basics.
Afterwards, feel free to check out the [configuration guide](https://github.com/nvim-neorg/neorg/wiki/Setup-Guide) as well as the [cookbook](https://github.com/nvim-neorg/neorg/wiki/Cookbook).

# Broken Installation

Having issues when installing Neorg, specifically past the `8.0.0` version? Check out the [following page](https://github.com/pysan3/Norg-Tutorial/blob/main/MIGRATION-v8.md) where you can troubleshoot your issue from start to finish.

# Contributing to Neorg

Neorg is a very big and powerful tool behind the scenes - way bigger than it may initially seem.
Modules are its core foundation, and building modules is like building lego bricks to form a massive structure.
There's an in-the-works tutorial dedicated to making modules [right here](https://github.com/andreadev-it/neorg-module-tutorials/blob/main/introduction.md)!

# Module naming convention

Neorg provides default modules, and users can extend Neorg by creating community modules.
We agreed on a module naming convention, and it should be used as is.
This convention should help users know at a glance what function the module serves in the grand scheme of things.
- Core modules: `core.*`
- Integrations with 3rd party software that are embedded in neorg: `core.integrations.*`
- External modules: `external.*`
- Integrations with 3rd party software that aren't embedded in neorg: `external.integrations.*`

# Default Modules

Neorg comes with some default modules that will be automatically loaded if you require the [`core.defaults`](https://github.com/nvim-neorg/neorg/wiki/Defaults) module:

- [`core.clipboard.code-blocks`](https://github.com/nvim-neorg/neorg/wiki/Clipboard-Code-Blocks) - Removes beginning whitespace from text copied from code blocks.
- [`core.esupports.hop`](https://github.com/nvim-neorg/neorg/wiki/Esupports-Hop) - "Hop" between Neorg links, following them with a single keypress.
- [`core.esupports.indent`](https://github.com/nvim-neorg/neorg/wiki/Indent) - A set of instructions for Neovim to indent Neorg documents.
- [`core.esupports.metagen`](https://github.com/nvim-neorg/neorg/wiki/Metagen) - A Neorg module for generating document metadata automatically.
- [`core.itero`](https://github.com/nvim-neorg/neorg/wiki/Itero) - Module designed to continue lists, headings and other iterables.
- [`core.journal`](https://github.com/nvim-neorg/neorg/wiki/Journal) - Easily track a journal within Neorg.
- [`core.keybinds`](https://github.com/nvim-neorg/neorg/wiki/User-Keybinds) - Module for managing keybindings with Neorg mode support.
- [`core.looking-glass`](https://github.com/nvim-neorg/neorg/wiki/Looking-Glass) - Allows for editing of code blocks within a separate buffer.
- [`core.pivot`](https://github.com/nvim-neorg/neorg/wiki/Pivot) - Toggles the type of list currently under the cursor.
- [`core.promo`](https://github.com/nvim-neorg/neorg/wiki/Promo) - Promotes or demotes nestable items within Neorg files.
- [`core.qol.toc`](https://github.com/nvim-neorg/neorg/wiki/TOC) - Generates a table of contents for a given Norg buffer.
- [`core.qol.todo_items`](https://github.com/nvim-neorg/neorg/wiki/Todo-Items) - Module for implementing todo lists.
- [`core.tangle`](https://github.com/nvim-neorg/neorg/wiki/Tangling) - An Advanced Code Block Exporter.
- [`core.todo-introspector`](https://github.com/nvim-neorg/neorg/wiki/Todo-Introspector) - Module for displaying progress of completed subtasks in the virtual line.
- [`core.ui.calendar`](https://github.com/nvim-neorg/neorg/wiki/Calendar) - Opens an interactive calendar for date-related tasks.

# Other Modules

Some modules are not included by default as they require some manual configuration or are merely extra bells and whistles
and are not critical to editing `.norg` files. Below is a list of all modules that are not required by default:

- [`core.completion`](https://github.com/nvim-neorg/neorg/wiki/Completion) - A wrapper to interface with several different completion engines.
- [`core.concealer`](https://github.com/nvim-neorg/neorg/wiki/Concealer) - Enhances the basic Neorg experience by using icons instead of text.
- [`core.dirman`](https://github.com/nvim-neorg/neorg/wiki/Dirman) - This module is be responsible for managing directories full of .norg files.
- [`core.export`](https://github.com/nvim-neorg/neorg/wiki/Exporting-Files) - Exports Neorg documents into any other supported filetype.
- [`core.export.html`](https://github.com/nvim-neorg/neorg/wiki/HTML-Export) - Interface for `core.export` to allow exporting to HTML.
- [`core.export.markdown`](https://github.com/nvim-neorg/neorg/wiki/Markdown-Export) - Interface for `core.export` to allow exporting to markdown.
- [`core.latex.renderer`](https://github.com/nvim-neorg/neorg/wiki/Core-Latex-Renderer) - An experimental module for rendering latex images inline.
- [`core.presenter`](https://github.com/nvim-neorg/neorg/wiki/Core-Presenter) - Neorg module to create gorgeous presentation slides.
- [`core.summary`](https://github.com/nvim-neorg/neorg/wiki/Summary) - Creates links to all files in any workspace.
- [`core.text-objects`](https://github.com/nvim-neorg/neorg/wiki/Norg-Text-Objects) - A Neorg module for moving and selecting elements of the document.

# Developer modules

These are modules that are only meant for developers. They are generally required in other modules:

- [`core.autocommands`](https://github.com/nvim-neorg/neorg/wiki/Autocommands) - Handles the creation and management of Neovim's autocommands.
- [`core.clipboard`](https://github.com/nvim-neorg/neorg/wiki/Clipboard) - A module to manipulate and interact with the user's clipboard.
- [`core.defaults`](https://github.com/nvim-neorg/neorg/wiki/Defaults) - Metamodule for storing the most necessary modules.
- [`core.dirman.utils`](https://github.com/nvim-neorg/neorg/wiki/Dirman-Utils) - A set of utilities for the `core.dirman` module.
- [`core.fs`](https://github.com/nvim-neorg/neorg/wiki/Filesystem) - A cross-platform set of utilities to traverse filesystems.
- [`core.highlights`](https://github.com/nvim-neorg/neorg/wiki/Core-Highlights) - Manages your highlight groups with this module.
- [`core.integrations.coq_nvim`](https://github.com/nvim-neorg/neorg/wiki/Coq_nvim) - A module for integrating coq_nvim with Neorg.
- [`core.integrations.nvim-cmp`](https://github.com/nvim-neorg/neorg/wiki/Nvim-Cmp) - A module for integrating nvim-cmp with Neorg.
- [`core.integrations.nvim-compe`](https://github.com/nvim-neorg/neorg/wiki/Nvim-Compe) - A module for integrating nvim-compe with Neorg.
- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.
- [`core.neorgcmd`](https://github.com/nvim-neorg/neorg/wiki/Neorgcmd-Module) - This module deals with handling everything related to the `:Neorg` command.
- [`core.neorgcmd.commands.return`](https://github.com/nvim-neorg/neorg/wiki/Neorgcmd-return) - Return to last location before entering Neorg.
- [`core.queries.native`](https://github.com/nvim-neorg/neorg/wiki/Queries-Module) - TS wrapper in order to fetch nodes using a custom table.
- [`core.scanner`](https://github.com/nvim-neorg/neorg/wiki/Scanner-Module) - This module is an implementation of a scanner that can be used anywhere TS can't be used.
- [`core.storage`](https://github.com/nvim-neorg/neorg/wiki/Storage) - Deals with storing persistent data across Neorg sessions.
- [`core.syntax`](https://github.com/nvim-neorg/neorg/wiki/Syntax) - Handles interaction for syntax files for code blocks.
- [`core.tempus`](https://github.com/nvim-neorg/neorg/wiki/Tempus) - Parses and handles dates in Neorg.
- [`core.ui`](https://github.com/nvim-neorg/neorg/wiki/Core-UI) - A set of public functions to help developers create and manage UI (selection popups, prompts...) in their modules.
