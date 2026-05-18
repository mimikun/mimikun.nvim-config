## Installation

There are also some optional plugins that work with Neo-tree:

### lazy.nvim example:

```lua
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
cmd="Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", 
      "folke/snacks.nvim",
"3rd/image.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()

  ---@module 'neo-tree'
  ---@type neotree.Config
  local opts = {
    -- options go here
  }
require('neo-tree').setup({
  -- options go here
})
end,
  }
}
```

<details>
  <summary>
    lazy.nvim example with all optional plugins:
  </summary>

```lua
return {
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
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
  },
}
```


<details>
  <summary>
    Example configuration featuring many interesting settings:
  </summary>

```lua
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>")

require("neo-tree").setup({
  close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = "NC", -- or "" to use 'winborder' on Neovim v0.11+
  clipboard = {
    sync = "none", -- or "global"/"universal" to share a clipboard for each/all Neovim instance(s), respectively
  },
  enable_git_status = true,
  enable_diagnostics = true,
  open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
  open_files_using_relative_paths = false,
  sort_case_insensitive = false, -- used when sorting files and directories in the tree
  sort_function = nil, -- use a custom function for sorting files and directories in the tree
  -- sort_function = function (a,b)
  --       if a.type == b.type then
  --           return a.path > b.path
  --       else
  --           return a.type > b.type
  --       end
  --   end , -- this sorts files and directories descendantly
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      -- indent guides
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      -- expander config, needed for nesting files
      with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "󰜌",
      provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
        if node.type == "file" or node.type == "terminal" then
          local success, web_devicons = pcall(require, "nvim-web-devicons")
          local name = node.type == "terminal" and "terminal" or node.name
          if success then
            local devicon, hl = web_devicons.get_icon(name)
            icon.text = devicon or icon.text
            icon.highlight = hl or icon.highlight
          end
        end
      end,
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = "*",
      highlight = "NeoTreeFileIcon",
      use_filtered_colors = true, -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_filtered_colors = true, -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added = "", -- or "✚"
        modified = "", -- or ""
        deleted = "✖", -- this can only be used in the git_status source
        renamed = "󰁕", -- this can only be used in the git_status source
        -- Status type
        untracked = "",
        ignored = "",
        unstaged = "󰄱",
        staged = "",
        conflict = "",
      },
    },
    -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
    file_size = {
      enabled = true,
      width = 12, -- width of the column
      required_width = 64, -- min width of window required to show this column
    },
    type = {
      enabled = true,
      width = 10, -- width of the column
      required_width = 122, -- min width of window required to show this column
    },
    last_modified = {
      enabled = true,
      width = 20, -- width of the column
      required_width = 88, -- min width of window required to show this column
    },
    created = {
      enabled = true,
      width = 20, -- width of the column
      required_width = 110, -- min width of window required to show this column
    },
    symlink_target = {
      enabled = false,
    },
  },
  -- A list of functions, each representing a global custom command
  -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
  -- see `:h neo-tree-custom-commands-global`
  commands = {},
  window = {
    position = "left",
    width = 40,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = {
        "toggle_node",
        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "cancel", -- close preview or floating neo-tree window
      ["P"] = {
        "toggle_preview",
        config = {
          use_float = true,
          use_snacks_image = true,
          use_image_nvim = true,
        },
      },
      -- Read `# Preview Mode` for more information
      ["l"] = "focus_preview",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      -- ["S"] = "split_with_window_picker",
      -- ["s"] = "vsplit_with_window_picker",
      ["t"] = "open_tabnew",
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ["w"] = "open_with_window_picker",
      --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
      ["C"] = "close_node",
      -- ['C'] = 'close_all_subnodes',
      ["z"] = "close_all_nodes",
      --["Z"] = "expand_all_nodes",
      --["Z"] = "expand_all_subnodes",
      ["a"] = {
        "add",
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "none", -- "none", "relative", "absolute"
        },
      },
      ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
      ["d"] = "delete",
      ["r"] = "rename",
      ["b"] = "rename_basename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["<C-r>"] = "clear_clipboard",
      ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
      -- ["c"] = {
      --  "copy",
      --  config = {
      --    show_path = "none" -- "none", "relative", "absolute"
      --  }
      --}
      ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
      ["i"] = "show_file_details",
      -- ["i"] = {
      --   "show_file_details",
      --   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
      --   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
      --   -- config = {
      --   --   created_format = "%Y-%m-%d %I:%M %p",
      --   --   modified_format = "relative", -- equivalent to the line below
      --   --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
      --   -- }
      -- },
    },
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_ignored = true, -- hide files that are ignored by other gitignore-like files
      -- other gitignore-like files, in descending order of precedence.
      ignore_files = {
        ".neotreeignore",
        ".ignore",
        -- ".rgignore"
      },
      hide_hidden = true, -- only works on Windows for hidden files/directories
      hide_by_name = {
        --"node_modules"
      },
      hide_by_pattern = { -- uses glob style patterns
        --"*.meta",
        --"*/src/*/tsconfig.json",
      },
      always_show = { -- remains visible even if other settings would normally hide it
        --".gitignored",
      },
      always_show_by_pattern = { -- uses glob style patterns
        --".env*",
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        --".DS_Store",
        --"thumbs.db"
      },
      never_show_by_pattern = { -- uses glob style patterns
        --".null-ls_*",
      },
    },
    follow_current_file = {
      enabled = false, -- This will find and focus the file in the active buffer every time
      --               -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    group_empty_dirs = false, -- when true, empty folders will be grouped together
    hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
    -- in whatever position is specified in window.position
    -- "open_current",  -- netrw disabled, opening a directory opens within the
    -- window like netrw would, regardless of window.position
    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        -- ["D"] = "fuzzy_sorter_directory",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
        ["o"] = {
          "show_help",
          nowait = false,
          config = { title = "Order by", prefix_key = "o" },
        },
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["og"] = { "order_by_git_status", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
        -- ['<key>'] = function(state) ... end,
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ["<down>"] = "move_cursor_down",
        ["<C-n>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
        ["<C-p>"] = "move_cursor_up",
        ["<esc>"] = "close",
        ["<S-CR>"] = "close_keep_filter",
        ["<C-CR>"] = "close_clear_filter",
        ["<C-w>"] = { "<C-S-w>", raw = true },
        {
          -- normal mode mappings
          n = {
            ["j"] = "move_cursor_down",
            ["k"] = "move_cursor_up",
            ["<S-CR>"] = "close_keep_filter",
            ["<C-CR>"] = "close_clear_filter",
            ["<esc>"] = "close",
          }
        }
        -- ["<esc>"] = "noop", -- if you want to use normal mode
        -- ["key"] = function(state, scroll_padding) ... end,
      },
    },

    commands = {}, -- Add a custom command or override a global one using the same function name
  },
  buffers = {
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
      --              -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    group_empty_dirs = true, -- when true, empty folders will be grouped together
    show_unloaded = true,
    window = {
      mappings = {
        ["d"] = "buffer_delete",
        ["bd"] = "buffer_delete",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["o"] = {
          "show_help",
          nowait = false,
          config = { title = "Order by", prefix_key = "o" },
        },
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
      },
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["A"] = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["gU"] = "git_undo_last_commit",
        ["ga"] = "git_add_file",
        ["gt"] = "git_toggle_file_stage",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
        ["o"] = {
          "show_help",
          nowait = false,
          config = { title = "Order by", prefix_key = "o" },
        },
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
      },
    },
  },
})
```

</details>

See `:h neo-tree` for full documentation. You can also preview that online at
[doc/neo-tree.txt](doc/neo-tree.txt), although it's best viewed within Neovim.

To see all of the default config options with commentary, you can view it online
at [lua/neo-tree/defaults.lua](lua/neo-tree/defaults.lua). You can also paste it
into a buffer after installing Neo-tree by running:

```
:lua require("neo-tree").paste_default_config()
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

For older versions of Neovim:

```lua
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
```

</details>

## The `:Neotree` Command

The single `:Neotree` command accepts a range of arguments that give you full
control over the details of what and where it will show. For example, the following
command will open a file browser on the right hand side, "revealing" the currently
active file:

```
:Neotree filesystem reveal right
```

Arguments can be specified as either a key=value pair or just as the value. The
key=value form is more verbose but may help with clarity. For example, the command
above can also be specified as:

```
:Neotree source=filesystem reveal=true position=right
```

All arguments are optional and can be specified in any order. If you issue the command
without any arguments, it will use default values for everything. For example:

```
:Neotree
```

will open the filesystem source on the left hand side and focus it, if you are using
the default config.

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
