# Creating Directories

Use the "Create File Or Directory" mapping, default `a`, appending a trailing slash.

e.g. `foo/` to create a directory `foo`

You can create many e.g. `foo/bar/baz` to create directories `foo` and `bar` containing a file `baz`

# Colors And Highlights Look Strange

Your color or highlight plugin may have a specific nvim-tree configuration.

See [Color Schemes](./Integrations-And-Extension-Plugins#color-schemes)

# Customisations Have Broken After An Update

Please ensure that your customisations all go through the public API, including:

`:help nvim-tree-api`

`:help nvim-tree-mappings` for `on_attach`

`:help nvim-tree-events`

`:help nvim-tree-decorators`

## Example: nvim-tree.view

Internal API `nvim-tree.view` will break as it is subject to change without notice, undergoing significant refactoring and rewriting at time of writing: 2025 07

See `:help nvim-tree-api.tree` for public API for window and buffer related functionality.

# Why Do I See Spelling Highlights?

The following highlight groups use the standard `Spell*` highlight groups when highlighting files:

Clipboard:
```
NvimTreeCopiedHL    SpellRare
NvimTreeCutHL       SpellBad
```

Bookmarks:
```
NvimTreeBookmarkHL  SpellLocal
```

File Text:
```
NvimTreeExecFile    SpellCap
NvimTreeImageFile   SpellCap
NvimTreeSpecialFile	SpellCap
NvimTreeSymlink     SpellCap
```

You can reset the above to pre 2024-01-20 values or others e.g.
```lua
vim.cmd([[
    :hi NvimTreeExecFile    gui=bold           guifg=#ffa0a0
    :hi NvimTreeSymlink     gui=bold           guifg=#ffff60
    :hi NvimTreeSpecialFile gui=bold,underline guifg=#ff80ff
    :hi NvimTreeImageFile   gui=bold           guifg=#ff80ff
]])
```

