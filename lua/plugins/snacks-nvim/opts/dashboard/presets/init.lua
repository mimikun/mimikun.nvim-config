---@type table
local preset = {
  -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
  ---@type fun(cmd:string, opts:table)|nil
  pick = nil,
  ---@type snacks.dashboard.Item[]
  keys = require("plugins.snacks-nvim.opts.dashboard.presets.keys"),
  -- Used by the `header` section
  header = require("plugins.snacks-nvim.opts.dashboard.presets.headers").neovim_logo,
}

return preset
