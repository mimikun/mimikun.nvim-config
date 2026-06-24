-- Keymaps
local keymaps = {
  view = {
    -- Close diff tab
    quit = "q",

    -- Toggle explorer visibility (explorer mode only)
    toggle_explorer = "<leader>b",

    -- Focus explorer panel (explorer mode only)
    focus_explorer = "<leader>e",
    next_hunk = "]c",
    prev_hunk = "[c",
    next_file = "]f",
    prev_file = "[f",
    diff_get = "do",

    -- Put change to other buffer (like vimdiff)
    diff_put = "dp",

    -- Open current buffer in previous tab (or new tab before current)
    open_in_prev_tab = "gf",

    -- Close codediff tab after opening in previous tab
    close_on_open_in_prev_tab = false,

    -- Stage/unstage current file (works in explorer and diff buffers)
    toggle_stage = "-",

    -- Stage the hunk under cursor to git index
    stage_hunk = "<leader>hs",

    -- Unstage the hunk under cursor from git index
    unstage_hunk = "<leader>hu",

    -- Discard the hunk under cursor (working tree only)
    discard_hunk = "<leader>hr",

    -- Textobject for hunk (vih to select, yih to yank, etc.)
    hunk_textobject = "ih",

    -- Temporarily align other pane to show paired moved code
    align_move = "gm",

    -- Toggle diff layout for the current codediff session
    toggle_layout = "t",

    -- Toggle compact mode (fold unchanged regions, show only hunks + context)
    toggle_compact = "gc",

    -- Show floating window with available keymaps
    show_help = "g?",
  },
  explorer = {
    select = "<CR>",
    hover = "K",
    refresh = "R",

    -- Toggle between 'list' and 'tree' views
    toggle_view_mode = "i",

    -- Stage all files
    stage_all = "S",

    -- Unstage all files
    unstage_all = "U",

    -- Discard changes to file (restore to index/HEAD)
    restore = "X",

    -- Toggle Changes (unstaged) group visibility
    toggle_changes = "gu",

    -- Toggle Staged Changes group visibility
    toggle_staged = "gs",

    -- Fold keymaps (Vim-style)
    -- Open fold (expand current node)
    fold_open = "zo",

    -- Open fold recursively (expand current node and all descendants)
    fold_open_recursive = "zO",

    -- Close fold (collapse current node)
    fold_close = "zc",

    -- Close fold recursively (collapse current node and all descendants)
    fold_close_recursive = "zC",

    -- Toggle fold (expand/collapse current node)
    fold_toggle = "za",

    -- Toggle fold recursively
    fold_toggle_recursive = "zA",

    -- Open all folds in tree
    fold_open_all = "zR",

    -- Close all folds in tree
    fold_close_all = "zM",
  },
  history = {
    -- Select commit/file or toggle expand
    select = "<CR>",

    -- Toggle between 'list' and 'tree' views
    toggle_view_mode = "i",

    -- Refresh history (re-fetch commits)
    refresh = "R",

    -- Fold keymaps (Vim-style, apply to directory nodes only)
    fold_open = "zo",
    fold_open_recursive = "zO",
    fold_close = "zc",
    fold_close_recursive = "zC",
    fold_toggle = "za",
    fold_toggle_recursive = "zA",
    fold_open_all = "zR",
    fold_close_all = "zM",
  },
  -- Conflict mode keymaps (only active in merge conflict views)
  conflict = {
    -- Accept incoming (theirs/left) change
    accept_incoming = "<leader>ct",

    -- Accept current (ours/right) change
    accept_current = "<leader>co",

    -- Accept both changes (incoming first)
    accept_both = "<leader>cb",

    -- Discard both, keep base
    discard = "<leader>cx",

    -- Accept all (whole file) - uppercase versions like diffview
    -- Accept ALL incoming changes
    accept_all_incoming = "<leader>cT",

    -- Accept ALL current changes
    accept_all_current = "<leader>cO",

    -- Accept ALL both changes
    accept_all_both = "<leader>cB",

    -- Discard ALL, reset to base
    discard_all = "<leader>cX",

    -- Jump to next conflict
    next_conflict = "]x",

    -- Jump to previous conflict
    prev_conflict = "[x",

    -- Vimdiff-style numbered diffget (from result buffer)
    -- Get hunk from incoming (left/theirs) buffer
    diffget_incoming = "2do",

    -- Get hunk from current (right/ours) buffer
    diffget_current = "3do",
  },
}

return keymaps
