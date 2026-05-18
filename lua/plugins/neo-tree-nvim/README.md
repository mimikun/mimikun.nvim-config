```lua
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    config = function()
      require("window-picker").setup({
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix" },
          },
        },
      })
    end,
  }
```


<details>
  <summary>Diagnostics icons:</summary>

If you want icons for diagnostic errors, you'll need to define them somewhere.
In Neovim v0.10+, you can configure them in vim.diagnostic.config(), like:

```lua
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
  }
})
```
### Tab Completion

Neotree supports tab completion for all arguments. Once a given argument has a value,
it will stop suggesting those completions. It will also offer completions for paths.
The simplest way to disambiguate a path from another type of argument is to start
them with `/` or `./`.

### Arguments

Here is the full list of arguments you can use:

#### `action`

What to do. Can be one of:

| Option | Description |
|--------|-------------|
| focus | Show and/or switch focus to the specified Neotree window. DEFAULT |
| show  | Show the window, but keep focus on your current window. |
| close | Close the window(s) specified. Can be combined with "position" and/or "source" to specify which window(s) to close. |

#### `source`

What to show. Can be one of:

| Option | Description |
|--------|-------------|
| filesystem | Show a file browser. DEFAULT |
| buffers    | Show a list of currently open buffers. |
| git_status | Show the output of `git status` in a tree layout. |
| last       | Equivalent to the last source used |

#### `position`

Where to show it, can be one of:

| Option  | Description |
|---------|-------------|
| left     | Open as left hand sidebar. DEFAULT |
| right    | Open as right hand sidebar. |
| top      | Open as top window. |
| bottom   | Open as bottom window. |
| float    | Open as floating window. |
| current  | Open within the current window, like netrw or vinegar would. |

#### `toggle`

This is a boolean flag. Adding this means that the window will be closed if it
is already open.

#### `dir`

The directory to set as the root/cwd of the specified window. If you include a
directory as one of the arguments, it will be assumed to be this option, you
don't need the full dir=/path. You may use any value that can be passed to the
'expand' function, such as `%:p:h:h` to specify two directories up from the
current file. For example:

```
:Neotree ./relative/path
:Neotree /home/user/relative/path
:Neotree dir=/home/user/relative/path
:Neotree position=current dir=relative/path
```

#### `git_base`

The base that is used to calculate the git status for each dir/file.
By default it uses `HEAD`, so it shows all changes that are not yet committed.
You can for example work on a feature branch, and set it to `main`. It will
show all changes that happened on the feature branch and main since you
branched off.

Any git ref, commit, tag, or sha will work.

```
:Neotree main
:Neotree v1.0
:Neotree git_base=8fe34be
:Neotree git_base=HEAD
```

#### `reveal`

This is a boolean flag. Adding this will make Neotree automatically find and
focus the current file when it opens.

#### `reveal_file`

A path to a file to reveal. This supersedes the "reveal" flag so there is no
need to specify both. Use this if you want to reveal something other than the
current file. If you include a path to a file as one of the arguments, it will
be assumed to be this option. Like "dir", you can pass any value that can be
passed to the 'expand' function. For example:

```
:Neotree reveal_file=/home/user/my/file.text
:Neotree position=current dir=%:p:h:h reveal_file=%:p
:Neotree current %:p:h:h %:p
```

One neat trick you can do with this is to open a Neotree window which is
focused on the file under the cursor using the `<cfile>` keyword:

```
nnoremap gd :Neotree float reveal_file=<cfile> reveal_force_cwd<cr>
```

#### `reveal_force_cwd`

This is a boolean flag. Normally, if you use one of the reveal options and the
given file is not within the current working directory, you will be asked if you
want to change the current working directory. If you include this flag, it will
automatically change the directory without prompting. This option implies
"reveal", so you do not need to specify both.

#### `selector`

This is a boolean flag. When you specifically set this to false (`selector=false`)
neo-tree will disable the [source selector](#source-selector) for that neo-tree
instance. Otherwise, the source selector will depend on what you specified in
the configuration (`config.source_selector.{winbar,statusline}`).

See `:h neo-tree-commands` for details and a full listing of available arguments.

### File Nesting

See `:h neo-tree-file-nesting` for more details about file nesting.

### Netrw Hijack

```
:edit .
:[v]split .
```

If `"filesystem.window.position"` is set to `"current"`, or if you have specified
`filesystem.hijack_netrw_behavior = "open_current"`, then any command
that would open a directory will open neo-tree in the specified window.

## Sources

Neo-tree is built on the idea of supporting various sources. Sources are
basically interface implementations whose job it is to provide a list of
hierarchical items to be rendered, along with commands that are appropriate to
those items.

### filesystem
The default source is `filesystem`, which displays your files and folders. This
is the default source in commands when none is specified.

This source can be used to:
- Browse the filesystem
- Control the current working directory of nvim
- Add/Copy/Delete/Move/Rename files and directories
- Search the filesystem
- Monitor git status and lsp diagnostics for the current working directory

### buffers
![Neo-tree buffers](https://github.com/nvim-neo-tree/resources/raw/main/images/Neo-tree-buffers.png)

Another available source is `buffers`, which displays your open buffers. This is
the same list you would see from `:ls`. To show with the `buffers` list, use:

```
:Neotree buffers
```

### git_status
This view take the results of the `git status` command and display them in a
tree. It includes commands for adding, unstaging, reverting, and committing.

The screenshot below shows the result of `:Neotree float git_status` while the
filesystem is open in a sidebar:

![Neo-tree git_status](https://github.com/nvim-neo-tree/resources/raw/main/images/Neo-tree-git_status.png)

You can specify a different git base here as well. But be aware that it is not
possible to unstage / revert a file that is already committed.

```
:Neotree float git_status git_base=main
```

### document_symbols

![Neo-tree document_symbols](https://github.com/nvim-neo-tree/resources/raw/main/images/neo-tree-document-symbols.png)
The document_symbols source lists the symbols in the current document obtained
by the LSP request "textDocument/documentSymbols". It currently supports the
following features:
- [x] UI:
	- [x] Display all symbols in the current file with symbol kinds
	- [x] Symbols nesting
	- [x] Configurable kinds' name and icon
	- [x] Auto-refresh symbol list
        - [x] Follow cursor
- [ ] Commands
	- [x] Jump to symbols, open symbol in split,... (`open_split` and friends)
	- [x] Rename symbols (`rename`)
	- [x] Preview symbol (`preview` and friends)
	- [ ] Hover docs
	- [ ] Call hierarchy
- [x] LSP
   - [x] LSP Support
   - [x] LSP server selection (ignore, allow_only, use first, use all, etc.)
- [ ] CoC Support

See #879 for the tracking issue of these features.

This source is currently experimental, so in order to use it, you need to first
add `"document_symbols"` to `config.sources` and open it with the command
```
:Neotree document_symbols
```

### External Sources

There are more sources available as extensions that are managed outside of this
repository. See the
[wiki](https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/External-Sources) for
more information.

### Source Selector

![Neo-tree source
selector](https://github.com/nvim-neo-tree/resources/raw/main/images/Neo-tree-source-selector.png)

You can enable a clickable source selector in either the winbar (requires neovim
0.8+) or the statusline. To do so, set one of these options to `true`:

```lua
    require("neo-tree").setup({
        source_selector = {
            winbar = false,
            statusline = false
        }
    })
```

There are many configuration options to change the style of these tabs.
See [lua/neo-tree/defaults.lua](lua/neo-tree/defaults.lua) for details.

### Preview Mode

`:h neo-tree-preview-mode`

Preview mode will temporarily show whatever file the cursor is on without
switching focus from the Neo-tree window. By default, files will be previewed
in a new floating window. This can also be configured to automatically choose
an existing split by configuring the command like this:

```lua
require("neo-tree").setup({
  window = {
    mappings = {
      ["P"] = {
        "toggle_preview",
        config = {
          use_float = false,
          -- use_image_nvim = true,
          -- use_snacks_image = true,
          -- title = 'Neo-tree Preview',
        },
      },
    }
  }
})
```

Anything that causes Neo-tree to lose focus will end preview mode. When
`use_float = false`, the window that was taken over by preview mode will revert
back to whatever was shown in that window before preview mode began.

You can choose a custom title for the floating window by setting the `title`
option in its config.

If you want to work with the floating preview mode window in autocmds or other
custom code, the window will have the `neo-tree-preview` filetype.

When preview mode is not using floats, the window will have the window local
variable `neo_tree_preview` set to `1` to indicate that it is being used as a
preview window. You can refer to this in statusline and winbar configs to mark a
window as being used as a preview.




