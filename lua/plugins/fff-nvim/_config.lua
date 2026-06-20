local default_config = {
  base_path = vim.fn.getcwd(),
  prompt = "🪿 ",
  title = "FFFiles",
  max_results = 100,
  max_threads = 4,
  lazy_sync = true, -- set to false if you want file indexing to start on open
  prompt_vim_mode = false, -- set to true to enable vim-mode in the prompt: <Esc> leaves insert for normal mode bindings (also allows <leader>p or <leader>l to jump around) the second <Esc> closes the picker
  wrap_around = false, -- set to true to wrap cursor to the opposite end when reaching the first/last item
  follow_symlinks = false, -- set to true to follow symbolic links during file indexing
  -- Allow fff in the user's $HOME director.
  enable_home_dir_scanning = true,
  -- Allow fff in a filesystem root (e.g. `/`, `C:\`)
  enable_fs_root_scanning = false,
  layout = {
    height = 0.8,
    width = 0.8,
    prompt_position = "bottom", -- or 'top'
    preview_position = "right", -- or 'left', 'right', 'top', 'bottom'
    preview_size = 0.5,
    flex = { -- set to nil to disable flex layout
      size = 130, -- column threshold: if screen width >= size, use preview_position; otherwise use wrap
      wrap = "top", -- position to use when screen is narrower than size
    },
    -- Minimum list height required to render the preview. When the available
    -- list area would drop below this on small terminals, the preview is
    -- auto-hidden so the file list stays usable. Set to 0 to disable.
    min_list_height = 10,
    show_scrollbar = true, -- Show scrollbar for pagination
    -- How to shorten long directory paths in the file list:
    -- 'middle' (default): always uses dots (a/./b, a/../b, a/.../b)
    -- 'middle_number' uses dots for 1-3 hidden (a/./b, a/../b, a/.../b)
    --                 and numbers for 4+ (a/.4./b, a/.5./b)
    -- 'end': truncates from the end, keeps the start (home/user/projects)
    -- 'start': truncates from the start, keeps the end (.../parts/ai_extracted)
    path_shorten_strategy = "middle",
  },
  preview = {
    enabled = true,
    max_size = 10 * 1024 * 1024, -- Do not try to read files larger than 10MB
    chunk_size = 8192, -- Bytes per chunk for dynamic loading (8kb - fits ~100-200 lines)
    binary_file_threshold = 1024, -- amount of bytes to scan for binary content (set 0 to disable)
    imagemagick_info_format_str = "%m: %wx%h, %[colorspace], %q-bit",
    line_numbers = false,
    cursorlineopt = "both",
    wrap_lines = false,
    filetypes = {
      svg = { wrap_lines = true },
      markdown = { wrap_lines = true },
      text = { wrap_lines = true },
    },
  },
  keymaps = {
    close = "<Esc>",
    select = "<CR>",
    select_split = "<C-s>",
    select_vsplit = "<C-v>",
    select_tab = "<C-t>",
    -- you can assign multiple keys to any action
    move_up = { "<Up>", "<C-p>" },
    move_down = { "<Down>", "<C-n>" },
    preview_scroll_up = "<C-u>",
    preview_scroll_down = "<C-d>",
    toggle_debug = "<F2>",
    -- grep mode: cycle between plain text, regex, and fuzzy search
    cycle_grep_modes = "<S-Tab>",
    -- grep mode only: jump cursor to first item of next/prev file group
    grep_jump_to_next_file = { "<C-A-n>", "<A-Down>" },
    grep_jump_to_prev_file = { "<C-A-p>", "<A-Up>" },
    -- goes to the previous query in history
    cycle_previous_query = "<C-Up>",
    -- goes to the next query in history (forward)
    cycle_forward_query = "<C-Down>",
    -- multi-select keymaps for quickfix
    toggle_select = "<Tab>",
    send_to_quickfix = "<C-q>",
    -- this are specific for the normal mode (you can exit it using any other keybind like jj)
    focus_list = "<leader>l",
    focus_preview = "<leader>p",
  },
  hl = {
    border = "FloatBorder",
    normal = "NormalFloat",
    matched = "IncSearch",
    title = "Title",
    prompt = "Question",
    cursor = fallback_hl({ "CursorLine", "Visual" }),
    frecency = "Number",
    debug = "Comment",
    combo_header = "Number",
    scrollbar = "Comment",
    directory_path = "Comment",
    -- Multi-select highlights
    selected = "FFFSelected",
    selected_active = "FFFSelectedActive",
    -- Git text highlights for file names
    git_staged = "FFFGitStaged",
    git_modified = "FFFGitModified",
    git_deleted = "FFFGitDeleted",
    git_renamed = "FFFGitRenamed",
    git_untracked = "FFFGitUntracked",
    git_ignored = "FFFGitIgnored",
    -- Git sign/border highlights
    git_sign_staged = "FFFGitSignStaged",
    git_sign_modified = "FFFGitSignModified",
    git_sign_deleted = "FFFGitSignDeleted",
    git_sign_renamed = "FFFGitSignRenamed",
    git_sign_untracked = "FFFGitSignUntracked",
    git_sign_ignored = "FFFGitSignIgnored",
    -- Git sign selected highlights
    git_sign_staged_selected = "FFFGitSignStagedSelected",
    git_sign_modified_selected = "FFFGitSignModifiedSelected",
    git_sign_deleted_selected = "FFFGitSignDeletedSelected",
    git_sign_renamed_selected = "FFFGitSignRenamedSelected",
    git_sign_untracked_selected = "FFFGitSignUntrackedSelected",
    git_sign_ignored_selected = "FFFGitSignIgnoredSelected",
    -- Grep highlights
    grep_match = "IncSearch", -- Highlight for matched text in grep results
    grep_line_number = "LineNr", -- Highlight for :line:col location
    grep_regex_active = "DiagnosticInfo", -- Highlight for keybind + label when regex is on
    grep_plain_active = "Comment", -- Highlight for keybind + label when regex is off
    grep_fuzzy_active = "DiagnosticHint", -- Highlight for keybind + label when fuzzy is on
    -- Cross-mode suggestion highlights
    suggestion_header = "WarningMsg", -- Highlight for the "No results found. Suggested..." banner
    -- File info panel highlights
    file_info_section = "FFFFileInfoSection", -- Section header label (e.g. "file", "score")
    file_info_separator = "FFFFileInfoSeparator", -- Dash dividers used like a border
    file_info_label = "FFFFileInfoLabel", -- Row labels (Size, Type, Git, ...)
    file_info_value = "FFFFileInfoValue", -- Plain values
    file_info_value_dim = "FFFFileInfoValueDim", -- Tertiary values, separators inside rows
    file_info_size = "FFFFileInfoSize", -- File size value
    file_info_type = "FFFFileInfoType", -- Filetype value
    file_info_path = "FFFFileInfoPath", -- Full path value
    file_info_total_score = "FFFFileInfoTotalScore", -- Total score (bold)
    file_info_match_type = "FFFFileInfoMatchType", -- match_type label (bold)
    file_info_score_pos = "FFFFileInfoScorePos", -- Positive score components
    file_info_score_neg = "FFFFileInfoScoreNeg", -- Negative score components / penalties
    -- Per-window 'winhighlight' overrides. When nil, falls back to a combination of `normal`, `border`, and `title` above.
    -- Accepts either a string applied to every picker window, or a table with optional `prompt`, `list`, `preview`, `file_info` keys.
    -- Example: `winhl = 'Normal:NormalFloat,FloatBorder:FloatBorder,FloatTitle:Title'`
    -- Example: `winhl = { prompt = 'Normal:Pmenu,...', list = 'Normal:NormalFloat,...' }`
    winhl = nil,
  },
  -- Store file open frecency
  frecency = {
    enabled = true,
    db_path = vim.fn.stdpath("cache") .. "/fff_nvim",
  },
  -- Store successfully opened queries with respective matches
  history = {
    enabled = true,
    db_path = vim.fn.stdpath("data") .. "/fff_queries",
    min_combo_count = 3, -- Minimum selections before combo boost applies (3 = boost starts on 3rd selection)
    combo_boost_score_multiplier = 100, -- Score multiplier for combo matches (files repeatedly opened with same query)
  },
  select = {
    --- Returns winid to open the file in. Return nil to open in the invoking
    --- window. Default retargets when the invoking window can't host a file
    --- buffer (special buftype, non-modifiable, or winfixbuf).
    --- @param current_buf integer
    --- @param action FffSelectAction
    --- @return integer|nil
    select_window = function(current_buf, action)
      if action ~= "edit" then
        return nil
      end
      local current_win = vim.api.nvim_get_current_win()
      local buftype = vim.api.nvim_get_option_value("buftype", { buf = current_buf })
      local modifiable = vim.api.nvim_get_option_value("modifiable", { buf = current_buf })
      local winfixbuf = require("fff.utils").window_has_winfixbuf(current_win)
      if buftype == "" and modifiable and not winfixbuf then
        return nil
      end
      return require("fff.utils").find_suitable_window()
    end,
  },
  -- Git integration
  git = {
    status_text_color = false, -- Apply git status colors to filename text (default: false, only sign column)
  },
  debug = {
    enabled = false, -- Show file info panel in preview
    show_scores = false, -- Show scores inline in the UI
    show_file_info = {
      file_info = true, -- Size, type, git status, frecency
      score_breakdown = true, -- Total + match type, bonuses, modifiers, penalty
      -- Modified + accessed timestamps. Pass a boolean to toggle the
      -- whole section, or a table to hide individual rows:
      --   timings = { modified = false, accessed = true }
      timings = true,
      full_path = true, -- Full absolute path at the bottom
    },
  },
  logging = {
    enabled = true,
    -- Path-shape hint: each nvim startup writes a fresh sibling file
    -- `<stem>+<UTC-timestamp>+<pid>.<ext>` next to this path. The literal
    -- path itself is never written to — multiple concurrent nvim instances
    -- get their own per-pid file with no locking.
    log_file = vim.fn.stdpath("log") .. "/fff.log",
    log_level = "info",
    -- How many session log files to retain. Newest are kept, older are
    -- pruned on the next startup. Set to 0 to disable retention.
    retain_runs = 20,
  },
  -- find_files settings
  file_picker = {
    current_file_label = "(current)",
  },
  -- grep settings
  grep = {
    max_file_size = 10 * 1024 * 1024, -- Skip files larger than 10MB
    max_matches_per_file = 100, -- Maximum matches per file (set 0 to unlimited)
    smart_case = true, -- Case-insensitive unless query has uppercase
    time_budget_ms = 150, -- Max search time in ms per call (prevents UI freeze, 0 = no limit)
    modes = { "plain", "regex", "fuzzy" }, -- Available grep modes and their cycling order
    trim_whitespace = false, -- Strip leading whitespace from matched lines (useful for cleaner display)
    -- Treat filename-like tokens (e.g. `score.rs`, `src/main.rs`) in a grep query as a
    -- file-path filter, scoping the content search to matching files. When off, such
    -- tokens are searched as literal text. A token is a filename if it has a valid-looking
    -- extension and no wildcards.
    enable_filename_constraint = false,
    -- Format string for the line/column location prefix in grep results.
    -- Uses vim's printf-style format: %d placeholders for line and column (1-based).
    -- Default ':%d:%d' renders as ':356:1'. Use ':%d' for line-only ':356'.
    location_format = ":%d:%d",
  },
}
