-- decided against, see above
-- tabterm-nvim
---@type snacks.terminal.Config
local terminal = {
  ---@type snacks.win.Config | {}
  win = {
    style = "terminal",
  },

  -- The shell to use. Defaults to `vim.o.shell`
  ---@type string | string[]
  --shell

  -- Use this to use a different terminal implementation
  ---@type fun(cmd?: string|string[], opts?: snacks.terminal.Opts)
  --override = function(_cmd, _opts)
  --end,
}

return terminal
