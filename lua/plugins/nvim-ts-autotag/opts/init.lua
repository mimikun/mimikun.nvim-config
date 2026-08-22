---@type nvim-ts-autotag.PluginSetup
local opts = {
  -- General setup options
  ---@type nvim-ts-autotag.Opts
  opts = require("plugins.nvim-ts-autotag.opts.options"),

  -- Aliases a filetype to an existing filetype tag config
  ---@type { [string]: string }
  aliases = require("plugins.nvim-ts-autotag.opts.aliases"),

  -- Per filetype config overrides
  ---@type { [string]: nvim-ts-autotag.Opts }
  per_filetype = require("plugins.nvim-ts-autotag.opts.per_filetype"),
}

return opts
