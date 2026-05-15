# Create A Directory

You can add a directory by adding a `/` at the end of the path.

Entering multiple directories `BASE/foo/bar/baz` will add directory foo, then bar and add a file baz to it.

# Change Window Options

You can update tree local window options for the tree by setting

```lua
require("nvim-tree.view").View.winopts.MY_OPTION = MY_OPTION_VALUE
```

# Open On The Left

If you `:set nosplitright`, the files will open on the left side of the tree, placing the tree window in the right side of the file you opened.

# Hide .git Directory

You can hide the `.git` folder via a custom filter, see `:help nvim-tree.filters.custom`

```lua
filters = { custom = { "^.git$" } }
```

# Disable Icons

To disable the display of icons see `:help nvim-tree.renderer.icons.show`

# Netrw Keeps Popping Up

Eagerly disable Netrw: `:help nvim-tree.disable_netrw`

# Fixing vertical split in windows terminal

Windows terminal uses `ctrl-v` for paste which conflicts with the default mapping for vertical split in nvim-tree resulting in the following error: `Error executing lua: vim/_editor.lua:0: Vim:E21: Cannot make changes, 'modifiable' is off^@stack traceback:^@^I[C]: in function 'nvim_put'^@^Ivim/_editor.lua: in function <vim/_editor.lua:0>` when trying to perform a vertical split. This can be fixed by remapping paste in windows terminal.

Go to Windows Terminal Settings -> Actions and then change the mapping for paste from `ctrl-v` to `ctrl-shift-v`.

# Open finder for selected file at MacOS

By default for file, not directory, `open` command at MacOS use **TextEditor**, not **Finder**. To open file at **Finder** set `system_open` to command `open` with option `-R`:

```lua
{
  system_open = {
    cmd = "open",
    args = { "-R" },
  },
}
```

From `man open`:
```
 -R  Reveals the file(s) in the Finder instead of opening them.
```

According [answer](https://github.com/nvim-tree/nvim-tree.lua/discussions/3112#discussioncomment-12952677), to setup for different OS use next config:

```lua
  ---
  },
  system_open =
    -- identify OS and set OS-specific cmd with args
    vim.fn.has("mac") == 1
    and {
      cmd = "open",
      args = { "-R" },
    }
    or nil,
  ---
```
