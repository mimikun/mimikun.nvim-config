---@type lockfile.Config
local opts = {
  ---@type lockfile.WindowConfig
  window = require("plugins.lockfile-nvim.opts.window"),

  -- git ref to diff working tree against
  ---@type string
  default_diff_base = "HEAD",

  ---@type lockfile.AnalysisConfig
  analysis = require("plugins.lockfile-nvim.opts.analysis"),

  ---@type lockfile.Icons
  icons = require("plugins.lockfile-nvim.opts.icons"),

  -- Each plugin highlight group links (with default = true) to the target below.
  -- map of plugin hl group -> linked group
  ---@type table<string,string>
  highlights = require("plugins.lockfile-nvim.opts.highlights"),
}

return opts
