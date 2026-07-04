---@type table
local opts = {
  width = 92,
  height = 18,
  preview_width = 86,
  preview_context = 5,
  border = "single",
  title = " peeper-picker.nvim ",
  jump = "tabedit",
  reuse_window = true,
  expanded_match_limit = 50000,
  scan_files_per_tick = 64,
  classify_files_per_tick = 8,
  default_result_filtering = "all",
  history_size = 100,
  default_keymaps = {
    enabled = false,
    find = "<leader>pp",
    history = "<leader>ph",
  },
  ignored_dirs = {},
  ignored_keywords = {},
}

return opts
