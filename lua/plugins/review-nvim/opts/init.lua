---@type ReviewConfig
local opts = {
  ---@type ReviewKeymaps
  keymaps = require("plugins.review-nvim.opts.keymaps"),

  ---@type ReviewDiffConfig
  diff = require("plugins.review-nvim.opts.diff"),

  ---@type ReviewUIConfig
  ui = require("plugins.review-nvim.opts.ui"),

  ---@type ReviewTmuxConfig
  tmux = require("plugins.review-nvim.opts.tmux"),

  ---@type ReviewQuickCommentsConfig
  quick_comments = require("plugins.review-nvim.opts.quick_comments"),

  ---@type ReviewExportConfig
  export = require("plugins.review-nvim.opts.export"),

  ---@type ReviewAutoRefreshConfig
  auto_refresh = require("plugins.review-nvim.opts.auto_refresh"),

  ---@type ReviewPersistenceConfig
  persistence = require("plugins.review-nvim.opts.persistence"),

  -- Log level: DEBUG, INFO, WARN, ERROR
  ---@type string
  log_level = "WARN",

  -- Override the log file path (defaults to a file under the system temp dir)
  ---@type string | nil
  log_file = nil,

  ---@type ReviewTemplate[]
  templates = require("plugins.review-nvim.opts.templates"),
}

return opts
