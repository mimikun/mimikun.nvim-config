local oil = require("oil")

-- Toggle state for the file detail view, flipped by the `gd` keymap below
local detail = false

-- Hide gitignored files and show git tracked hidden files
-- helper function to parse output
local function parse_output(proc)
  local result = proc:wait()
  local ret = {}
  if result.code == 0 then
    for line in
      vim.gsplit(result.stdout, "\n", {
        plain = true,
        trimempty = true,
      })
    do
      -- Remove trailing slash
      line = line:gsub("/$", "")
      ret[line] = true
    end
  end
  return ret
end

-- Hide gitignored files and show git tracked hidden files
-- build git status cache
local function new_git_status()
  return setmetatable({}, {
    __index = function(self, key)
      local ignore_proc = vim.system({
        "git",
        "ls-files",
        "--ignored",
        "--exclude-standard",
        "--others",
        "--directory",
      }, {
        cwd = key,
        text = true,
      })
      local tracked_proc = vim.system({
        "git",
        "ls-tree",
        "HEAD",
        "--name-only",
      }, {
        cwd = key,
        text = true,
      })
      local ret = {
        ignored = parse_output(ignore_proc),
        tracked = parse_output(tracked_proc),
      }

      rawset(self, key, ret)
      return ret
    end,
  })
end

-- Hide gitignored files and show git tracked hidden files
local git_status = new_git_status()

-- Hide gitignored files and show git tracked hidden files
-- Clear git status cache on refresh
local refresh = require("oil.actions").refresh
local orig_refresh = refresh.callback
refresh.callback = function(...)
  git_status = new_git_status()
  orig_refresh(...)
end

---@module "oil"
---@type oil.SetupOpts
local opts = {
  -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`).
  -- Set to false if you still want to use netrw.
  ---@type boolean
  default_file_explorer = true,

  -- The columns to display. See :help oil-columns.
  ---@type oil.ColumnSpec[]
  columns = {
    "icon",
    --"permissions",
    --"size",
    --"mtime",
  },

  -- Buffer-local options to use for oil buffers
  ---@type table<string, any>
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },

  -- Window-local options to use for oil buffers
  ---@type table<string, any>
  win_options = {
    wrap = false,
    -- NOTE: oil-git-status.nvim is NEED it
    signcolumn = "yes:2",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
    -- Show CWD in the winbar
    winbar = "%!v:lua.get_oil_winbar()",
  },

  -- Oil has built-in support for using the system trash.
  -- When `delete_to_trash = true`, any deleted files will be sent to the trash instead of being permanently deleted.
  -- You can browse the trash for a directory using the `toggle_trash` action (bound to `g\` by default).
  -- You can view all files in the trash with `:Oil --trash /`.
  -- To restore files, simply move them from the trash to the desired destination, the same as any other file operation.
  -- If you delete files from the trash they will be permanently deleted (purged).
  -- Linux:
  --     Oil supports the FreeDesktop trash specification.
  --     https://specifications.freedesktop.org/trash/1.0/
  --     All features should work.
  -- Mac:
  --     Oil has limited support for MacOS due to the proprietary nature of the implementation.
  --     The trash bin can only be viewed as a single dir (instead of being able to see files that were trashed from a directory).
  -- Windows:
  --     Oil supports the Windows Recycle Bin.
  --     All features should work.
  ---@type boolean
  delete_to_trash = false,

  -- Before performing filesystem operations,
  -- Oil displays a confirmation popup to ensure that all operations are intentional.
  -- When this option is `true`, the popup will be
  -- skipped if the operations:
  --   * contain no deletes
  --   * contain no cross-adapter moves or copies (e.g. from local to ssh)
  --   * contain at most one copy or move
  --   * contain at most five creates
  ---@type boolean
  skip_confirm_for_simple_edits = false,

  -- There are two cases where this option is relevant:
  -- 1. You copy a file to a new location, then you select it and make edits before saving.
  -- 2. You copy a directory to a new location, then you enter the directory and make changes before saving.

  -- In case 1, when you edit the file you are actually editing the original file because oil has not yet moved/copied it to its new location.
  -- This means that the original file will, perhaps unexpectedly, also be changed by any edits you make.

  -- Case 2 is similar; when you edit the directory you are again actually editing the original location of the directory.
  -- If you add new files, those files will be created in both the original location and the copied directory.

  -- When this option is `true`, Oil will prompt you to save before entering a file or directory that is pending within oil, but does not exist on disk.
  ---@type boolean
  prompt_save_on_select_new_entry = true,

  -- Oil will automatically delete hidden buffers after this delay.
  -- You can set the delay to false to disable cleanup entirely.
  -- Note that the cleanup process only starts when none of the oil buffers are currently displayed.
  ---@type integer
  cleanup_delay_ms = 2000,

  -- Configure LSP file operation integration.
  ---@type oil.SetupLspFileMethods
  lsp_file_methods = {
    -- Enable or disable LSP file operations
    ---@type boolean
    enabled = true,

    -- Time to wait for LSP file operations to complete before skipping.
    ---@type integer
    timeout_ms = 1000,

    -- Set to true to autosave buffers that are updated with LSP willRenameFiles.
    -- Set to "unmodified" to only save unmodified buffers.
    ---@type boolean | "unmodified"
    autosave_changes = false,
  },

  -- Constrain the cursor to the editable parts of the oil buffer.
  -- Set to `false` to disable, or "name" to keep it on the file names.
  ---@type false | "name" | "editable"
  constrain_cursor = "editable",

  -- Set to true to watch the filesystem for changes and reload oil.
  ---@type boolean
  watch_for_changes = false,

  ---@type table<string, any>
  keymaps = {
    ["g?"] = {
      "actions.show_help",
      mode = "n",
    },
    ["<CR>"] = "actions.select",
    ["<C-s>"] = {
      "actions.select",
      opts = {
        vertical = true,
      },
    },
    ["<C-h>"] = {
      "actions.select",
      opts = {
        horizontal = true,
      },
    },
    ["<C-t>"] = {
      "actions.select",
      opts = {
        tab = true,
      },
    },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = {
      "actions.close",
      mode = "n",
    },
    ["<C-l>"] = "actions.refresh",
    ["-"] = {
      "actions.parent",
      mode = "n",
    },
    ["_"] = {
      "actions.open_cwd",
      mode = "n",
    },
    ["`"] = {
      "actions.cd",
      mode = "n",
    },
    ["g~"] = {
      "actions.cd",
      opts = {
        scope = "tab",
      },
      mode = "n",
    },
    ["gs"] = {
      "actions.change_sort",
      mode = "n",
    },
    ["gx"] = "actions.open_external",
    ["g."] = {
      "actions.toggle_hidden",
      mode = "n",
    },
    ["g\\"] = {
      "actions.toggle_trash",
      mode = "n",
    },
    -- Toggle file detail view
    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
        detail = not detail
        if detail then
          oil.set_columns({
            "icon",
            "permissions",
            "size",
            "mtime",
          })
        else
          oil.set_columns({
            "icon",
          })
        end
      end,
    },
  },

  -- Set to false to disable all of the above keymaps
  ---@type boolean
  use_default_keymaps = true,

  -- Configure which files are shown and how they are shown.
  ---@type oil.SetupViewOptions
  view_options = {
    -- Show files and directories that start with "."
    ---@type boolean
    show_hidden = false,

    -- Hide gitignored files and show git tracked hidden files
    ---@type fun(name: string, bufnr: integer): boolean
    is_hidden_file = function(name, bufnr)
      local dir = oil.get_current_dir(bufnr)
      local is_dotfile = vim.startswith(name, ".") and name ~= ".."
      -- if no local directory (e.g. for ssh connections), just hide dotfiles
      if not dir then
        return is_dotfile
      end
      -- dotfiles are considered hidden unless tracked
      if is_dotfile then
        return not git_status[dir].tracked[name]
      else
        -- Check if file is gitignored
        return git_status[dir].ignored[name]
      end
    end,

    -- This function defines what will never be shown, even when `show_hidden` is set
    ---@type fun(name: string, bufnr: integer): boolean
    is_always_hidden = function(name, bufnr)
      return false
    end,

    -- Sort file names with numbers in a more intuitive order for humans. Can be slow for large directories.
    ---@type boolean | "fast"
    natural_order = "fast",

    -- Sort file and directory names case insensitive
    ---@type boolean
    case_insensitive = false,

    -- Sort order for the file list
    ---@type oil.SortSpec[]
    sort = {
      {
        "type",
        "asc",
      },
      {
        "name",
        "asc",
      },
    },

    -- Customize the highlight group for the file name
    ---@type fun(entry: oil.Entry, is_hidden: boolean, is_link_target: boolean, is_link_orphan: boolean): string | nil
    highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
      return nil
    end,
  },

  -- Extra arguments to pass to SCP when moving/copying files over SSH
  ---@type string[]
  extra_scp_args = {},

  ---Extra arguments to pass to aws s3 when moving/copying files using aws s3
  ---@type string[]
  extra_s3_args = {},

  -- EXPERIMENTAL support for performing file operations with git
  ---@type oil.SetupGitOptions
  git = {
    -- Return true to automatically git add a new file
    ---@type fun(path: string): boolean
    add = function(path)
      return false
    end,

    -- Return true to automatically git mv a moved file
    ---@type fun(src_path: string, dest_path: string): boolean
    mv = function(src_path, dest_path)
      return false
    end,

    -- Return true to automatically git rm a deleted file
    ---@type fun(path: string): boolean
    rm = function(path)
      return false
    end,
  },

  -- Configuration for the floating window in oil.open_float
  ---@type oil.SetupFloatWindowConfig
  float = {
    ---@type integer
    padding = 2,

    ---@type integer
    max_width = 0,

    ---@type integer
    max_height = 0,

    -- Window border
    ---@type string | string[]
    border = nil,

    ---@type table<string, any>
    win_options = {
      winblend = 0,
    },

    ---@type fun(winid: integer): string
    get_win_title = function(winid)
      return nil
    end,

    -- Direction that the preview command will split the window
    ---@type string | "auto" | "left" | "right" | "above" | "below"
    preview_split = "auto",

    ---@type fun(conf: table): table
    override = function(conf)
      return conf
    end,
  },

  -- Configuration for the file preview window
  ---@type oil.SetupPreviewWindowConfig
  preview_win = {
    -- Whether the preview window is automatically updated when the cursor is moved
    ---@type boolean
    update_on_cursor_moved = true,

    -- How to open the preview window
    -- load: Load the previewed file into a buffer
    -- scratch: Put the text into a scratch buffer to avoid LSP attaching
    -- fast_scratch: Put only the visible text into a scratch buffer
    ---@type oil.PreviewMethod | "load" | "scratch" | "fast_scratch"
    preview_method = "fast_scratch",

    -- A function that returns true to disable preview on a file e.g. to avoid lag
    ---@type fun(filename: string): boolean
    disable_preview = function(filename)
      return false
    end,

    -- Window-local options to use for preview window buffers
    ---@type table<string, any>
    win_options = {},
  },

  -- Configuration for the floating action confirmation window
  ---@type oil.SetupConfirmationWindowConfig
  confirmation = {
    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%).
    -- Can be a single value or a list of mixed integer/float types.
    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
    ---@type oil.WindowDimension
    max_width = 0.9,

    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%).
    -- Can be a single value or a list of mixed integer/float types.
    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
    ---@type oil.WindowDimension
    min_width = {
      40,
      0.4,
    },

    -- Define an integer/float for the exact width of the preview window
    ---@type number
    width = nil,

    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%).
    -- Can be a single value or a list of mixed integer/float types.
    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
    ---@type oil.WindowDimension
    max_height = 0.9,

    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%).
    -- Can be a single value or a list of mixed integer/float types.
    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
    ---@type oil.WindowDimension
    min_height = {
      5,
      0.1,
    },

    -- Define an integer/float for the exact height of the preview window
    ---@type number
    height = nil,

    -- Window border
    ---@type string|string[]
    border = nil,

    ---@type table<string, any>
    win_options = {
      winblend = 0,
    },
  },

  -- Configuration for the floating progress window
  ---@type oil.SetupProgressWindowConfig
  progress = {
    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%).
    -- Can be a single value or a list of mixed integer/float types.
    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
    ---@type oil.WindowDimension
    max_width = 0.9,

    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%).
    -- Can be a single value or a list of mixed integer/float types.
    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
    ---@type oil.WindowDimension
    min_width = {
      40,
      0.4,
    },

    -- Define an integer/float for the exact width of the preview window
    ---@type number
    width = nil,

    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%).
    -- Can be a single value or a list of mixed integer/float types.
    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
    ---@type oil.WindowDimension
    max_height = {
      10,
      0.9,
    },

    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%).
    -- Can be a single value or a list of mixed integer/float types.
    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
    ---@type oil.WindowDimension
    min_height = {
      5,
      0.1,
    },

    -- Define an integer/float for the exact height of the preview window
    ---@type number
    height = nil,

    -- Window border
    ---@type string|string[]
    border = nil,

    ---@type table<string, any>
    win_options = {
      winblend = 0,
    },

    -- The border for the minimized progress window
    ---@type string | string[]
    minimized_border = "none",
  },

  -- Configuration for the floating SSH window
  ---@type oil.SetupSimpleWindowConfig
  ssh = {
    ---@type string | string[]
    border = nil,
  },

  -- Configuration for the floating keymaps help window
  ---@type oil.SetupSimpleWindowConfig
  keymaps_help = {
    -- Window border
    ---@type string | string[]
    border = nil,
  },
}

return opts
