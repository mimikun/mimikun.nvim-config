---@type table
local opts = {
  base_path = vim.fn.getcwd(),
  prompt = "> ",
  title = "FFFiles",
  max_results = 100,
  max_threads = 4,
  lazy_sync = true,
  prompt_vim_mode = false,
  follow_symlinks = false,
  -- Allow indexing the user's $HOME directory.
  -- Enabled by default.
  -- Disable if you strictly sure you don't want this, as it makes whole fff error hard
  enable_home_dir_scanning = true,
  -- Allow indexing a filesystem root (e.g. `/`, `C:\`). Disabled by default
  enable_fs_root_scanning = false,
  layout = {
    height = 0.8,
    width = 0.8,
    prompt_position = "bottom", -- or 'top'
    preview_position = "right", -- 'left' | 'right' | 'top' | 'bottom'
    preview_size = 0.5,
    flex = { size = 130, wrap = "top" },
    min_list_height = 10, --  do not display anything except the list below this threshold
    show_scrollbar = true,
    path_shorten_strategy = "middle_number", -- 'middle_number' | 'middle' | 'end' | 'start'
    anchor = "center",
  },
  preview = {
    enabled = true,
    max_size = 10 * 1024 * 1024,
    chunk_size = 8192,
    binary_file_threshold = 1024,
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
    move_up = { "<Up>", "<C-p>" },
    move_down = { "<Down>", "<C-n>" },
    preview_scroll_up = "<C-u>",
    preview_scroll_down = "<C-d>",
    toggle_debug = "<F2>",
    cycle_grep_modes = "<S-Tab>",
    -- grep mode only: jump cursor to first match of next/prev file group
    grep_jump_to_next_file = { "<C-A-n>", "<A-Down>" },
    grep_jump_to_prev_file = { "<C-A-p>", "<A-Up>" },
    cycle_previous_query = "<C-Up>",
    toggle_select = "<Tab>",
    send_to_quickfix = "<C-q>",
    focus_list = "<leader>l",
    focus_preview = "<leader>p",
  },
  frecency = {
    enabled = true,
    db_path = vim.fn.stdpath("cache") .. "/fff_nvim",
  },
  history = {
    enabled = true,
    db_path = vim.fn.stdpath("data") .. "/fff_queries",
    min_combo_count = 3,
    combo_boost_score_multiplier = 100,
  },
  git = {
    status_text_color = false, -- true to color filenames by git status
  },
  select = {
    -- Return winid to open the chosen file in, or nil to open in the original window
    select_window = function(current_buf, action) --[[ default impl ]]
      return nil
    end,
  },
  grep = {
    max_file_size = 10 * 1024 * 1024,
    max_matches_per_file = 100,
    smart_case = true,
    time_budget_ms = 150,
    modes = { "plain", "regex", "fuzzy" },
    trim_whitespace = false,
    enable_filename_constraint = false, -- treat filename-like tokens (e.g. `score.rs`) in a grep query as a file-path filter scoping the search; off = searched as literal text
    location_format = ":%d:%d", -- printf format for line:col prefix in grep results, e.g. ':%d' for line-only
  },
  debug = {
    enabled = true, -- show the file info panel next to the preview
    show_scores = true, -- inline scores in the file list
    -- Per-section toggles for the file info panel. Accepts a boolean shorthand
    -- (`show_file_info = true|false`) to flip everything at once. The panel
    -- adapts to width: narrow renders sections vertically, wide renders them
    -- as a two-column grid. Disable a section to also shrink the panel.
    show_file_info = {
      file_info = true, -- size, type, git status, frecency
      score_breakdown = true, -- total + match type, bonuses, modifiers, penalty
      -- modified + accessed timestamps; pass a table to hide individual rows:
      --   timings = { modified = false, accessed = true }
      timings = true,
      full_path = true, -- relative path at the bottom (wraps if too long)
    },
  },
  logging = {
    -- logs will be written in a parent directory of this file path in files like
    -- `<stem>+<UTC-timestamp>+<pid>.<ext>`. Run :FFFOpenLog to open current one
    log_file = vim.fn.stdpath("log") .. "/fff.log",
    log_level = "info",
    retain_runs = 20,
  },
}

return opts
