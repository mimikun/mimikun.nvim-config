---@type table
local opts = {
  -- :SquixRun hides query name + SQL in the TUI (already shown in the editor)
  hide_query = true,

  -- in-TUI <C-w>hjkl window navigation
  -- false sends keys raw to the TUI
  term_keymaps = true,

  -- set laststatus=0 while the squix TUI is focused (splits have no per-window statusline)
  hide_statusline = true,

  window = require("plugins.squix-nvim.opts.window"),

  -- none mapped by default
  -- set any to a key to enable
  keymaps = require("plugins.squix-nvim.opts.keymaps"),
}

return opts
