## `:bd[elete]` makes the tree spans the whole window. How do I prevent it?
Besides deleting the buffer, the vim's `:bd[delete]` commands also closes any window containing that buffer as long as this closing leaves at least one window. As a result, if there is a Neo-tree window alongside the primary one, `:bd`-ing this buffer also closes this main window and makes the Neo-tree window spans the whole screen. 

This could sometimes be an unwanted behavior, especially when `close_if_last_window = true`, which means that `:bd` could quit neovim completely. However, as this is the intended behavior of `:bd`, we do not consider this a bug and do not plan to fix this. For users that want to prevent this behavior, there are several ways to do this:

#### No extra plugins
A common workaround to the default `:bd` is to use `:bp | bd #` instead. This first switches from the current buffer (let us call it `A`) to another buffer (we call it `B`), and then delete `A`. `A` is no longer in the current window, so the current window is not deleted.

#### Using plugins
There are a several options to choose from, among those are:
- The [vim-bbye](https://github.com/moll/vim-bbye) plugin introduces `:Bdelete` that is analogous to `:bp | bd#`, but with additional handlers for edge cases.
- [vim-sayonara](https://github.com/mhinz/vim-sayonara) is a similar plugin to vim-bbye
- [mini.bufremove](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bufremove.md) is a lua alternative to the above 2 plugins.
