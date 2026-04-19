---@type Edgy.Config
local opts = {
  ---@type (Edgy.View.Opts|string)[]
  left = require("plugins.edgy-nvim.opts.left"),

  ---@type (Edgy.View.Opts|string)[]
  bottom = require("plugins.edgy-nvim.opts.bottom"),

  ---@type (Edgy.View.Opts|string)[]
  right = require("plugins.edgy-nvim.opts.right"),

  ---@type (Edgy.View.Opts|string)[]
  top = require("plugins.edgy-nvim.opts.top"),

  ---@alias Edgy.Pos "bottom"|"top"|"left"|"right"
  ---@type table<Edgy.Pos, {size:integer | fun():integer, wo?:vim.wo}>
  options = require("plugins.edgy-nvim.opts.options"),

  -- edgebar animations
  animate = require("plugins.edgy-nvim.opts.animate"),

  -- enable this to exit Neovim when only edgy windows are left
  exit_when_last = false,

  -- close edgy when all windows are hidden instead of opening one of them
  -- disable to always keep at least one edgy split visible in each open section
  close_when_all_hidden = true,

  -- global window options for edgebar windows
  ---@type vim.wo
  wo = require("plugins.edgy-nvim.opts.wo"),

  -- buffer-local keymaps to be added to edgebar buffers.
  -- Existing buffer-local keymaps will never be overridden.
  -- Set to false to disable a builtin.
  ---@type table<string, fun(win:Edgy.Window)|false>
  keys = require("plugins.edgy-nvim.opts.keys"),

  icons = {
    closed = " ",
    open = " ",
  },

  -- enable this on Neovim <= 0.10.0 to properly fold edgebar windows.
  -- Not needed on a nightly build >= June 5, 2023.
  fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
}

return opts
