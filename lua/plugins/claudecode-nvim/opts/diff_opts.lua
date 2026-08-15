---@type ClaudeCodeDiffOptions
local diff_opts = {
  -- "unified": VS Code-style unified diff in a single buffer with deleted (red/strikethrough) and added (green) lines interleaved.
  -- Requires Neovim >= 0.9.0.
  -- Highlight groups are customizable:
  -- ClaudeCodeInlineDiffAdd,
  -- ClaudeCodeInlineDiffDelete,
  -- ClaudeCodeInlineDiffAddSign,
  -- ClaudeCodeInlineDiffDeleteSign.
  ---@type ClaudeCodeDiffLayout | string | "vertical" | "horizontal" | "unified"
  layout = "vertical",

  -- Open diff in a new tab (false = use current tab)
  ---@type boolean
  open_in_new_tab = false,

  -- If true, moves focus back to terminal after diff opens (including floating terminals)
  -- Keep focus in terminal after opening diff
  ---@type boolean
  keep_terminal_focus = false,

  -- If true and opening in a new tab, do not show Claude terminal there
  -- Hide Claude terminal in newly created diff tab
  ---@type boolean
  hide_terminal_in_new_tab = false,

  -- Let the plugin resize the Claude terminal across the diff lifecycle (default true);
  -- set false to own width via the ClaudeCodeDiffOpened/Closed User autocmds
  ---@type boolean
  auto_resize_terminal = true,

  -- "keep_empty" leaves an empty buffer; "close_window" closes the placeholder split
  -- Behavior when rejecting a new-file diff
  ---@type ClaudeCodeNewFileRejectBehavior | string | "keep_empty" | "close_window"
  on_new_file_reject = "keep_empty",
}

return diff_opts
