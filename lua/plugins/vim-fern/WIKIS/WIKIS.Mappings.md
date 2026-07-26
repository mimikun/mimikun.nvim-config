**Hit `?` on a fern window to see actual mappings.**

## Core

The following mappings/actions are core feature so cannot be disabled by `g:fern#disable_default_mappings`

| Mapping | Action   | Description                                        |
| ------- | -------- | -------------------------------------------------- |
| `a`     | `choice` | Open a prompt to input an action name to perform   |
| `.`     | `repeat` | Repeat previous action invoked from a prompt       |
| `?`     | `help`   | Output mappings/actions to a pseudo buffer as help |

## Scheme less

The following mappings/actions are available among any fern buffer

| Mapping             | Action                 | Description                                                                           |
| ------------------- | ---------------------- | ------------------------------------------------------------------------------------- |
| `<C-c>`             | `cancel`               | Cancel any operation under processing                                                 |
| `<C-l>`             | `redraw`               | Redraw content of the buffer                                                          |
|                     | `debug`                | Show a debug information of a node under the cursor                                   |
| `<F5>`              | `reload`               | Reload node itself and descendent nodes of a node under the cursor                    |
|                     | `expand`               | Expand (open) a node under the cursor                                                 |
| `-`                 | `mark-toggle`          | (Un)select a node                                                                     |
| `h`                 | `collapse`             | Collapse (close) a node under the cursor                                              |
| `i`                 | `reveal`               | Reveal (recursively focus and expand) a node which input by user                      |
|                     | `enter`                | Enter a new tree which root node is a node under the cursor                           |
| `<BS>`, `<C-h>`     | `leave`                | Leave to a new tree which root is the parent node of a current root node              |
| `s`                 | `open:select`          | Select window to open a node under the cursor (like [t9md/vim-choosewin][])           |
| `e`                 | `open`                 | An alias of `open:edit` action                                                        |
| `E`                 | `open:side`            | Open a node under the cursor on right side of the fern buffer                         |
|                     | `open:edit`            | An alias of `open:edit-or-error` action                                               |
|                     | `open:split`           | Open a node under the cursor with `split`                                             |
|                     | `open:vsplit`          | Open a node under the cursor with `vsplit`                                            |
| `t`                 | `open:tabedit`         | Open a node under the cursor with `tabedit`                                           |
|                     | `open:above`           | Open a node under the cursor with `leftabove split`                                   |
|                     | `open:left`            | Open a node under the cursor with `leftabove vsplit`                                  |
|                     | `open:below`           | Open a node under the cursor with `rightbelow split`                                  |
|                     | `open:right`           | Open a node under the cursor with `rightbelow vsplit`                                 |
|                     | `open:top`             | Open a node under the cursor with `topleft split`                                     |
|                     | `open:leftest`         | Open a node under the cursor with `topleft vsplit`                                    |
|                     | `open:bottom`          | Open a node under the cursor with `botright split`                                    |
|                     | `open:rightest`        | Open a node under the cursor with `botright vsplit`                                   |
|                     | `open:edit-or-error`   | Open a node under the cursor with `edit` or throw error when the buffer is `modified` |
|                     | `open:edit-or-split`   | Open a node under the cursor with `edit` or `split` when the buffer is `modified`     |
|                     | `open:edit-or-vsplit`  | Open a node under the cursor with `edit` or `vsplit` when the buffer is `modified`    |
|                     | `open:edit-or-tabedit` | Open a node under the cursor with `edit` or `tabedit` when the buffer is `modified`   |
| `<Return>`, `<C-m>` |                        | Invoke `open` when a node under the cursor is leaf. Otherwise invoke `enter`          |
| `l`                 |                        | Invoke `open` when a node under the cursor is leaf. Otherwise invoke `expand`         |
| `z`                 | `zoom`                 | An alias of `zoom:half` action                                                        |
|                     | `zoom:half`            | Temporary increase the width of a project drawer. It does nothing on split windows    |
|                     | `zoom:full`            | Temporary increase the width of a project drawer. It does nothing on split windows    |

[t9md/vim-choosewin]: https://github.com/t9md/vim-choosewin

## file scheme (file:///)

| Mapping | Action            | Description                                                                                                       |
| ------- | ----------------- | ----------------------------------------------------------------------------------------------------------------- |
|         | `cd`              | Change directory to the root node of the tree with `cd` command                                                   |
|         | `lcd`             | Change directory to the root node of the tree with `lcd` command                                                  |
|         | `tcd`             | Change directory to the root node of the tree with `tcd` command                                                  |
| `x`     | `open:system`     | Open a node under the cursor with a system program                                                                |
| `N`     | `new-file`        | Create a new file under a node under the cursor                                                                   |
| `K`     | `new-dir`         | Create a new directory under a node under the cursor                                                              |
| `c`     | `copy`            | Copy files/directories of selected nodes to new locations sequentially                                            |
| `m`     | `move`            | Move files/directories of selected nodes to new locations sequentially                                            |
| `C`     | `clipboard-copy`  | Save files/directories of selected nodes to the internal clipboard to copy                                        |
| `M`     | `clipboard-move`  | Save files/directories of selected nodes to the internal clipboard to move                                        |
| `P`     | `clipboard-pate`  | Paste files/directories to a node under the cursor from the internal clipboard                                    |
|         | `clipboard-clear` | Clear the internal clipboard                                                                                      |
| `D`     | `trash`           | Move files/directories of selected nodes to the system trash-bin                                                   |
|         | `remove`          | Remove files/directories of selected nodes                                                                         |
| `R`     | `rename`          | Start renamer to rename multiple files/directories by using Vim buffer (like exrename in [Shougo/vimfiler.vim][]) |
|         | `terminal`        | Start `:term` on the parent path of the cursor node                                                               |

[shougo/vimfiler.vim]: https://github.com/Shougo/vimfiler.vim
