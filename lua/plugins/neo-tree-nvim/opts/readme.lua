---@module 'neo-tree'
---@type neotree.Config
local readme = {
  -- Close Neo-tree if it is the last window left in the tab
  close_if_last_window = false,
  -- or "" to use 'winborder' on Neovim v0.11+
  popup_border_style = "NC",
  clipboard = {
    -- or "global"/"universal" to share a clipboard for each/all Neovim instance(s), respectively
    sync = "none",
  },
  enable_git_status = true,
  enable_diagnostics = true,
  -- when opening files, do not use windows containing these filetypes or buftypes
  open_files_do_not_replace_types = {
    "terminal",
    "trouble",
    "qf",
  },
  open_files_using_relative_paths = false,
  -- used when sorting files and directories in the tree
  sort_case_insensitive = false,
  -- use a custom function for sorting files and directories in the tree
  -- this sorts files and directories descendantly
  sort_function = function(a, b)
    --if a.type == b.type then
    --    return a.path > b.path
    --else
    --    return a.type > b.type
    --end
    return nil
  end,
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      indent_size = 2,
      -- extra padding on left hand side
      padding = 1,
      -- indent guides
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      -- expander config, needed for nesting files
      -- if nil and file nesting is enabled, will enable expanders
      with_expanders = nil,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "󰜌",
      -- default icon provider utilizes nvim-web-devicons if available
      provider = function(icon, node, state)
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
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there then these will never be used.
      default = "*",
      highlight = "NeoTreeFileIcon",
      -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
      use_filtered_colors = true,
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
      use_filtered_colors = true,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        -- or "✚"
        added = "",
        -- or ""
        modified = "",
        -- this can only be used in the git_status source
        deleted = "✖",
        -- this can only be used in the git_status source
        renamed = "󰁕",
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
      -- width of the column
      width = 12,
      -- min width of window required to show this column
      required_width = 64,
    },
    type = {
      enabled = true,
      -- width of the column
      width = 10,
      -- min width of window required to show this column
      required_width = 122,
    },
    last_modified = {
      enabled = true,
      -- width of the column
      width = 20,
      -- min width of window required to show this column
      required_width = 88,
    },
    created = {
      enabled = true,
      -- width of the column
      width = 20,
      -- min width of window required to show this column
      required_width = 110,
    },
    symlink_target = {
      enabled = false,
    },
  },
  -- A list of functions, each representing a global custom command that will be available in all sources (if not overridden in `opts[source_name].commands`)
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
        -- disable `nowait` if you have existing combos starting with this char that you want to use
        nowait = false,
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      -- close preview or floating neo-tree window
      ["<esc>"] = "cancel",
      ["P"] = {
        "toggle_preview",
        config = {
          use_float = false,
          --use_float = true,
          --use_snacks_image = true,
          --use_image_nvim = true,
          --title = "Neo-tree Preview",
        },
      },
      -- Read `# Preview Mode` for more information
      ["l"] = "focus_preview",
      ["S"] = "open_split",
      --["S"] = "split_with_window_picker",
      ["s"] = "open_vsplit",
      --["s"] = "vsplit_with_window_picker",
      ["t"] = "open_tabnew",
      --["t"] = "open_tab_drop",
      --["<cr>"] = "open_drop",
      ["w"] = "open_with_window_picker",
      -- enter preview mode, which shows the current node without focusing
      --["P"] = "toggle_preview",
      ["C"] = "close_node",
      --['C'] = 'close_all_subnodes',
      ["z"] = "close_all_nodes",
      --["Z"] = "expand_all_nodes",
      --["Z"] = "expand_all_subnodes",
      ["a"] = {
        "add",
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc).
        -- see `:h neo-tree-file-actions` for details some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          -- "none", "relative", "absolute"
          show_path = "none",
        },
      },
      -- also accepts the optional config.show_path option like "add".
      -- this also supports BASH style brace expansion.
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["b"] = "rename_basename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["<C-r>"] = "clear_clipboard",
      -- takes text input for destination, also accepts the optional config.show_path option like "add":
      ["c"] = "copy",
      --["c"] = {
      --  "copy",
      --  config = {
      --    -- "none", "relative", "absolute"
      --    show_path = "none",
      --  },
      --},
      -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ["m"] = "move",
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
      ["i"] = "show_file_details",
      --["i"] = {
      --  "show_file_details",
      --  -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
      --  -- both options accept a string or a function that takes in the date in seconds and returns a string to display
      --  config = {
      --    created_format = "%Y-%m-%d %I:%M %p",
      --    modified_format = function(seconds)
      --      local modified_format
      --      modified_format = "relative"
      --      modified_format = require("neo-tree.utils").relative_date(seconds)
      --      return modified_format
      --    end,
      --  },
      --},
    },
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      -- when true, they will just be displayed differently than normal items
      visible = false,
      hide_dotfiles = true,
      hide_gitignored = true,
      -- hide files that are ignored by other gitignore-like files
      hide_ignored = true,
      -- other gitignore-like files, in descending order of precedence.
      ignore_files = {
        ".neotreeignore",
        ".ignore",
        --".rgignore"
      },
      -- only works on Windows for hidden files/directories
      hide_hidden = true,
      hide_by_name = {
        --"node_modules"
      },
      -- uses glob style patterns
      hide_by_pattern = {
        --"*.meta",
        --"*/src/*/tsconfig.json",
      },
      -- remains visible even if other settings would normally hide it
      always_show = {
        --".gitignored",
      },
      -- uses glob style patterns
      always_show_by_pattern = {
        --".env*",
      },
      -- remains hidden even if visible is toggled to true, this overrides always_show
      never_show = {
        --".DS_Store",
        --"thumbs.db"
      },
      -- uses glob style patterns
      never_show_by_pattern = {
        --".null-ls_*",
      },
    },
    follow_current_file = {
      -- This will find and focus the file in the active buffer every time
      enabled = false,
      -- the current file is changed while the tree is open.
      -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      leave_dirs_open = false,
    },
    -- when true, empty folders will be grouped together
    group_empty_dirs = false,
    -- netrw disabled, opening a directory opens neo-tree
    -- "open_default", in whatever position is specified in window.position
    -- "open_current", netrw disabled, opening a directory opens within the window like netrw would, regardless of window.position
    -- "disabled", netrw left alone, neo-tree does not handle opening dirs
    hijack_netrw_behavior = "open_default",
    -- This will use the OS level file watchers to detect changes
    use_libuv_file_watcher = false,
    -- instead of relying on nvim autocmd events.
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        -- fuzzy sorting using the fzy algorithm
        ["#"] = "fuzzy_sorter",
        --["D"] = "fuzzy_sorter_directory",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
        ["o"] = {
          "show_help",
          nowait = false,
          config = {
            title = "Order by",
            prefix_key = "o",
          },
        },
        ["oc"] = {
          "order_by_created",
          nowait = false,
        },
        ["od"] = {
          "order_by_diagnostics",
          nowait = false,
        },
        ["og"] = {
          "order_by_git_status",
          nowait = false,
        },
        ["om"] = {
          "order_by_modified",
          nowait = false,
        },
        ["on"] = {
          "order_by_name",
          nowait = false,
        },
        ["os"] = {
          "order_by_size",
          nowait = false,
        },
        ["ot"] = {
          "order_by_type",
          nowait = false,
        },
        --["<key>"] = function(state)
        --  --...
        --end,
      },
      -- define keymaps for filter popup window in fuzzy_finder_mode
      fuzzy_finder_mappings = {
        ["<down>"] = "move_cursor_down",
        ["<C-n>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
        ["<C-p>"] = "move_cursor_up",
        ["<esc>"] = "close",
        ["<S-CR>"] = "close_keep_filter",
        ["<C-CR>"] = "close_clear_filter",
        ["<C-w>"] = {
          "<C-S-w>",
          raw = true,
        },
        {
          -- normal mode mappings
          n = {
            ["j"] = "move_cursor_down",
            ["k"] = "move_cursor_up",
            ["<S-CR>"] = "close_keep_filter",
            ["<C-CR>"] = "close_clear_filter",
            ["<esc>"] = "close",
          },
        },
        -- if you want to use normal mode
        ["<esc>"] = "noop",
        --["key"] = function(state, scroll_padding)
        --  --...
        --end,
      },
    },

    -- Add a custom command or override a global one using the same function name
    commands = {},
  },
  buffers = {
    follow_current_file = {
      -- This will find and focus the file in the active buffer every time
      -- the current file is changed while the tree is open.
      enabled = true,
      -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      leave_dirs_open = false,
    },
    -- when true, empty folders will be grouped together
    group_empty_dirs = true,
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
          config = {
            title = "Order by",
            prefix_key = "o",
          },
        },
        ["oc"] = {
          "order_by_created",
          nowait = false,
        },
        ["od"] = {
          "order_by_diagnostics",
          nowait = false,
        },
        ["om"] = {
          "order_by_modified",
          nowait = false,
        },
        ["on"] = {
          "order_by_name",
          nowait = false,
        },
        ["os"] = {
          "order_by_size",
          nowait = false,
        },
        ["ot"] = {
          "order_by_type",
          nowait = false,
        },
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
          config = {
            title = "Order by",
            prefix_key = "o",
          },
        },
        ["oc"] = {
          "order_by_created",
          nowait = false,
        },
        ["od"] = {
          "order_by_diagnostics",
          nowait = false,
        },
        ["om"] = {
          "order_by_modified",
          nowait = false,
        },
        ["on"] = {
          "order_by_name",
          nowait = false,
        },
        ["os"] = {
          "order_by_size",
          nowait = false,
        },
        ["ot"] = {
          "order_by_type",
          nowait = false,
        },
      },
    },
  },
}

return readme
