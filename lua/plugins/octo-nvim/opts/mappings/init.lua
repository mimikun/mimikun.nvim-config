---@type { [OctoMappingsWindow]: OctoMappingsList}
local mappings = {
  discussion = require("plugins.octo-nvim.opts.mappings.discussion"),
  runs = require("plugins.octo-nvim.opts.mappings.runs"),
  issue = require("plugins.octo-nvim.opts.mappings.issue"),
  pull_request = require("plugins.octo-nvim.opts.mappings.pull_request"),
  review_thread = require("plugins.octo-nvim.opts.mappings.review_thread"),
  submit_win = require("plugins.octo-nvim.opts.mappings.submit_win"),
  review_diff = require("plugins.octo-nvim.opts.mappings.review_diff"),
  file_panel = require("plugins.octo-nvim.opts.mappings.file_panel"),
  notification = require("plugins.octo-nvim.opts.mappings.notification"),
  repo = require("plugins.octo-nvim.opts.mappings.repo"),
  release = require("plugins.octo-nvim.opts.mappings.release"),
}

return mappings
