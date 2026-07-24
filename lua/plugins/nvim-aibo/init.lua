---@type LazySpec
local spec = {
  "lambdalisue/nvim-aibo",
  --lazy = false,
  --ft = require("plugins.nvim-aibo.ft"),
  --cmd = require("plugins.nvim-aibo.cmds"),
  --keys = require("plugins.nvim-aibo.keys"),
  --event = require("plugins.nvim-aibo.events"),
  --dependencies = require("plugins.nvim-aibo.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.nvim-aibo.opts"),
  config = function()
    local opts = require("plugins.nvim-aibo.opts")
    require("aibo").setup(opts)
    --[[
> ```lua
> -- Custom command for Claude with proportional window
> vim.api.nvim_create_user_command('Claude', function(opts)
>   local width = math.floor(vim.o.columns * 2 / 3)
>   vim.cmd(string.format('Aibo -opener="%dvsplit" claude %s', width, opts.args))
> end, { nargs = '*' })
> ```
>
> ```lua
> -- Key mapping for quick access with dynamic sizing
> vim.keymap.set('n', '<leader>ai', function()
>   local width = math.floor(vim.o.columns * 2 / 3)
>   vim.cmd(string.format('Aibo -opener="%dvsplit" claude', width))
> end, { desc = 'Open Claude AI assistant' })
> ```
]]
  end,
  cond = false,
  enabled = false,
}

return spec
