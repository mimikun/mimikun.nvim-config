---@type table
local opts = {
  -- default configuration
  quit_on_unmapped_keys = true,
  divisions = 3,
  keymaps = require("plugins.hamal-nvim.opts.keymaps"),
  highlights = require("plugins.hamal-nvim.opts.highlights"),
}

return opts
