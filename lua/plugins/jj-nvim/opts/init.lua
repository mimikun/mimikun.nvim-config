---@type table
local opts = {
  -- TODO: it

  -- Setup snacks as a picker
  picker = {
    -- Here you can pass the options as you would for snacks.
    -- It will be used when using the picker
    snacks = {},
  },
  -- Configure editor behavior for describe/commit buffers
  editor = {
    -- When true, automatically enter insert mode only if the description is empty.
    -- If a description already exists, stay in normal mode.
    auto_insert = false,

    -- Configure the describe/commit editor buffer window
    window = {
      -- Type of window (hsplit/vsplit/floating/tab)
      type = "hsplit",

      -- Size % of split (height for hsplit, width for vsplit)
      split_size = 0.5,

      -- Width % for floating window (0.1 to 1.0)
      floating_width = 0.99,

      -- Height % for floating window (0.1 to 1.0)
      floating_height = 0.95,
    },
  },
  -- Customize syntax highlighting colors for the describe buffer
  -- Note: added, modified, deleted use Neovim's built-in highlight groups (Added, Changed, Removed)
  -- Only renamed has a custom default since Neovim doesn't have a built-in group for it
  highlights = {
    editor = {
      -- added = { fg = "#3fb950", ctermfg = "Green" },   -- Optional: override Added highlight
      -- modified = { fg = "#56d4dd", ctermfg = "Cyan" }, -- Optional: override Changed highlight
      -- deleted = { fg = "#f85149", ctermfg = "Red" },   -- Optional: override Removed highlight
      renamed = { fg = "#d29922", ctermfg = "Yellow" }, -- Renamed files (custom default)
    },
    log = {
      selected = { bg = "#3d2c52", ctermbg = "DarkMagenta" },
      targeted = { fg = "#5a9e6f", ctermfg = "Green" },
    },
  },
  -- Configure terminal behavior
  terminal = {
    -- Cursor render delay in milliseconds (default: 10)
    -- If cursor column is being reset to 0 when refreshing commands, try increasing this value
    -- This delay allows the terminal emulator to complete rendering before restoring cursor position
    cursor_render_delay = 10,

    -- Configure terminal window
    window = {
      type = "hsplit", -- Type of window the terminal is displayed in (hsplit/vsplit/floating/tab)
      split_size = 0.5, -- Size % of the split window, either height (hsplit) or width (vsplit) (between 0.1 and 1.0)
      floating_width = 0.99, -- Width % of the floating window (between 0.1 and 1.0)
      floating_height = 0.95, -- Height % of the floating window (between 0.1 and 1.0)
    },
  },
  -- Configure diff module
  diff = {
    -- Default backend for viewing diffs
    -- "native" - Built-in split diff using Neovim's diff mode (default)
    -- "diffview" - Use diffview.nvim plugin (requires diffview.nvim)
    -- "codediff" - Use codediff.nvim plugin (requires codediff.nvim)
    -- Or any custom backend name you've registered
    backend = "native",
    --backend = "codediff",
  },

  -- Configure cmd module (describe editor, keymaps)
  cmd = {

    -- Configure describe editor
    describe = {
      editor = {
        -- Choose the editor mode for describe command
        -- "buffer" - Opens a Git-style commit message buffer with syntax highlighting (default)
        -- "input" - Uses a simple vim.ui.input prompt
        type = "buffer",
        -- Customize keymaps for the describe editor buffer
        keymaps = {
          close = { "<C-c>", "q" }, -- Keys to close editor without saving
          --close = { "q", "<Esc>", "<C-c>" }, -- Enable <Esc> in the editor
        },
      },
    },

    -- Configure log command behavior
    log = {
      close_on_edit = false, -- Close log buffer after editing a change
    },

    -- Optional resolve strategy picker shared across cmd integrations
    resolve_strategies = {
      {
        name = "Meld",
        args = { "--tool", "meld" },
        external = true,
      },
      {
        name = "Mergiraf",
        args = { "--tool", "mergiraf" },
        external = true,
      },
    },

    -- Configure bookmark command
    bookmark = {
      prefix = "",
      --prefix = "feat/",
    },

    -- Configure keymaps for command buffers
    keymaps = {
      -- Log buffer keymaps (set to nil to disable)
      log = {
        edit = "<CR>", -- Edit revision under cursor
        edit_immutable = "<S-CR>", -- Edit revision (ignore immutability)
        describe = "d", -- Describe revision under cursor
        diff = "<S-d>", -- Diff revision under cursor
        edit = "e", -- Edit revision under cursor
        new = "n", -- Create new change branching off
        new_after = "<C-n>", -- Create new change after revision
        new_after_immutable = "<S-n>", -- Create new change after (ignore immutability)
        undo = "<S-u>", -- Undo last operation
        redo = "<S-r>", -- Redo last undone operation
        abandon = "a", -- Abandon revision under cursor
        --    abandon = "<S-a>",
        bookmark = "b", -- Create or move bookmark to revision under cursor
        bookmark_del = "B", -- Delete bookmark of revision under cursor
        fetch = "f", -- Fetch from remote
        --    fetch = "<S-f>",
        push = "p", -- Push bookmark of revision under cursor
        push_all = "<S-p>", -- Push all changes to remote
        open_pr = "o", -- Open PR/MR for revision under cursor
        open_pr_list = "<S-o>", -- Open PR/MR by selecting from all bookmarks
        rebase = "r", -- Enter rebase mode targeting revision under cursor or selected revisions
        rebase_mode = {
          onto = { "<CR>", "o" }, -- Select revision under cursor as rebase onto destination
          after = "a", -- Rebase after revision under cursor
          before = "b", -- Rebase before revision under cursor
          onto_immutable = { "<S-CR>", "<S-o>" }, -- Select revision  as a rebase onto destination (ignore immutability)
          after_immutable = "<S-a>", -- Rebase after revision under cursor (ignore immutability)
          before_immutable = "<S-b>", -- Rebase before revision under cursor (ignore immutability)
          exit_mode = { "<Esc>", "<C-c>" }, -- Exit rebase mode
        },
        duplicate = "<C-y>", -- Enter duplicate mode targeting revision under cursor or selected revisions
        duplicate_mode = {
          onto = { "<CR>", "o" }, -- Select revision under cursor as duplicate onto destination
          after = "a", -- Duplicate after revision under cursor
          before = "b", -- Duplicate before revision under cursor
          onto_immutable = { "<S-CR>", "<S-o>" }, -- Duplicate onto revision under cursor (ignore immutability)
          after_immutable = "<S-a>", -- Duplicate after revision under cursor (ignore immutability)
          before_immutable = "<S-b>", -- Duplicate before revision under cursor (ignore immutability)
          exit_mode = { "<Esc>", "<C-c>" }, -- Exit duplicate mode
        },
        squash = "s", -- Enter squash mode targeting revision under cursor or selected revisions
        squash_mode = {
          into = "<CR>", -- Squash into revision under cursor
          into_immutable = "<S-CR>", -- Squash into revision under cursor (ignore immutability)
          exit_mode = { "<Esc>", "<C-c>" }, -- Exit squash mode
        },
        quick_squash = "<S-s>", -- Quick squash revision under cursor into its parent (ignore immutability)
        split = "<C-s>", -- Split the revision under cursor
        resolve = "gr", -- Resolve conflicts for revision under cursor
        history = "<S-h>", -- Show a history-aware diff for the selected revision range
        change_revset = "<C-r>", -- Change the revset(s) being viewed in the log buffer
        tag_set = "<S-t>", -- Create a tag on the revision under cursor
        summary = "<S-k>", -- Show summary tooltip for revision under cursor
        select_next_revision = "gj", -- Move cursor to the next revision in the log
        select_prev_revision = "gk", -- Move cursor to the previous revision in the log
        summary_tooltip = {
          diff = "<S-d>", -- Diff file at this revision
          edit = "<CR>", -- Edit revision and open file
          edit_immutable = "<S-CR>", -- Edit revision (ignore immutability) and open file
          edit_file = "o", -- Open the file under cursor in a new tab like `:Jtabedit` would
        },
      },
      -- Status buffer keymaps (set to nil to disable)
      status = {
        open_file = "<CR>", -- Open file under cursor
        restore_file = "<S-x>", -- Restore file under cursor
      },
      -- Close keymaps (shared across all buffers)
      close = { "q", "<Esc>" },
      -- Floating buffer keymaps
      floating = {
        close = "q", -- Close floating buffer
        hide = "<Esc>", -- Hide floating buffer
      },
    },
  },
}

return opts
