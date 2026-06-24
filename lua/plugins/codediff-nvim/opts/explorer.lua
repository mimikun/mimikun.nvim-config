-- Explorer panel configuration
local explorer = {
  ---@type string| "left" | "bottom"
  position = "left",

  -- Initial visibility state
  hidden = false,

  -- Width when position is "left" (columns)
  width = 40,

  -- Height when position is "bottom" (lines)
  height = 15,

  -- Enable automatic explorer refresh (BufEnter + git watcher)
  auto_refresh = true,

  -- list: flat file list
  -- tree: directory tree
  ---@type string | "list" | "tree"
  view_mode = "list",

  -- Show indent markers in tree view (│, ├, └)
  indent_markers = true,

  -- Initial focus
  ---@type string | "explorer" | "original" | "modified"
  initial_focus = "explorer",

  icons = {
    -- Nerd Font: folder
    folder_closed = "\u{e5ff}",

    -- Nerd Font: folder-open
    folder_open = "\u{e5fe}",
  },

  file_filter = {
    -- Glob patterns to hide (e.g., {"*.lock", "dist/*"})
    ignore = {
      ".git/**",
      ".jj/**",
    },
  },

  -- Jump to modified pane after selecting a file (default: stay in explorer)
  focus_on_select = false,

  -- Rebind j/k/Down/Up in the explorer to also open the file under the cursor
  auto_open_on_cursor = false,

  -- Flatten single-child directory chains in tree view (e.g., src/components/ui/)
  flatten_dirs = true,

  -- Trailing cells between the status symbol (M/A/D) and the right edge; increase if Nerd Font icons clip it
  status_right_margin = 1,

  -- Which groups to show in explorer (can be toggled at runtime)
  visible_groups = {
    staged = true,
    unstaged = true,
    conflicts = true,
  },
}

return explorer
