-- Diff view behavior
local diff = {
  -- Diff layout
  ---@type string | "side-by-side" | "inline"
  layout = "side-by-side",

  -- Disable inlay hints in diff windows for cleaner view
  disable_inlay_hints = true,

  -- Maximum time for diff computation (5 seconds, VSCode default)
  max_computation_time_ms = 5000,

  -- Ignore leading/trailing whitespace changes (like diffopt+=iwhite)
  ignore_trim_whitespace = false,

  -- Hide merge tool temp files (*.orig, *.BACKUP.*, *.BASE.*, *.LOCAL.*, *.REMOTE.*)
  hide_merge_artifacts = false,

  -- Position of original (old) content: "left" or "right"
  ---@type string | "left" | "right"
  original_position = "left",

  -- Position of ours (:2) in conflict view: "left" or "right" (independent of original_position)
  ---@type string | "left" | "right"
  conflict_ours_position = "right",

  -- Position of result buffer in conflict view: "bottom" or "center"
  ---@type string | "bottom" | "center"
  conflict_result_position = "bottom",

  -- Height of result buffer in bottom layout (percentage of total height)
  conflict_result_height = 30,

  -- Width ratio for center layout panes {left, center, right} (e.g., {1, 2, 1} for wider result)
  conflict_result_width_ratio = {
    1,
    1,
    1,
  },

  -- Wrap around when navigating hunks (]c/[c): true = cycle, false = stop at first/last
  cycle_next_hunk = true,

  -- Wrap around when navigating files (]f/[f): true = cycle, false = stop at first/last
  cycle_next_file = true,

  -- ]c/[c at file boundary jumps to first/last hunk of next/prev file (explorer/history mode)
  cycle_hunks_across_files = false,

  -- Auto-scroll to first change when opening a diff: true = jump to first hunk, false = stay at same line
  jump_to_first_change = true,

  -- Priority for line-level diff highlights (increase to override LSP highlights)
  highlight_priority = 100,

  -- Detect moved code blocks (opt-in, may increase diff computation time)
  compute_moves = false,

  -- Number of context lines around hunks in compact mode
  compact_context_lines = 3,

  -- Sync fold open/close across panes in compact mode (mirrors Vim diff mode behavior)
  compact_sync_folds = true,
}

return diff
