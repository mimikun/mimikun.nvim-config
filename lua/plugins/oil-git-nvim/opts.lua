---@type table
local opts = {
  debounce_ms = 50,
  show_file_highlights = true,
  show_directory_highlights = true,
  show_file_symbols = true,
  show_directory_symbols = true,
  -- Show ignored file status
  show_ignored_files = true,

  -- Show ignored directory status
  show_ignored_directories = false,

  ---@type string | "eol" | "signcolumn" | "none"
  symbol_position = "eol",

  -- Optional callback(bufnr): nil|bool|string
  ---@type nil | boolean | string
  can_use_signcolumn = nil,

  -- Ignore GitSignsUpdate events (fallback for flickering)
  ignore_gitsigns_update = false,

  -- false, "minimal", or "verbose"
  ---@type false | "minimal" | "verbose"
  debug = false,

  symbols = {
    file = {
      added = "+",
      modified = "~",
      renamed = "->",
      deleted = "D",
      copied = "C",
      conflict = "!",
      untracked = "?",
      ignored = "o",
    },
    directory = {
      added = "*",
      modified = "*",
      renamed = "*",
      deleted = "*",
      copied = "*",
      conflict = "!",
      untracked = "*",
      ignored = "o",
    },
  },

  -- Colors (only applied if highlight groups don't exist)
  highlights = {
    OilGitAdded = { fg = "#a6e3a1" },
    OilGitModifiedStaged = { fg = "#f9e2af" },
    OilGitModifiedUnstaged = { fg = "#e5c890" },
    OilGitRenamed = { fg = "#cba6f7" },
    OilGitDeleted = { fg = "#f38ba8" },
    OilGitCopied = { fg = "#cba6f7" },
    OilGitConflict = { fg = "#fab387" },
    OilGitUntracked = { fg = "#89b4fa" },
    OilGitIgnored = { fg = "#6c7086" },
  },
}

return opts
