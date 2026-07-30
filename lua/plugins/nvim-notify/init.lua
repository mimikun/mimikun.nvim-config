---@type LazySpec
local spec = {
  "rcarriga/nvim-notify",
  --lazy = false,
  cmd = require("plugins.nvim-notify.cmds"),
  event = require("plugins.nvim-notify.events"),
  dependencies = require("plugins.nvim-notify.dependencies"),
  init = function()
    vim.opt.termguicolors = true
  end,
  --opts = require("plugins.nvim-notify.opts"),
  config = function()
    local opts = require("plugins.nvim-notify.opts")
    require("notify").setup(opts)

    -- setup() alone changes nothing: the built-in vim.notify never consults
    -- notify's config, so opts.level is ignored and DEBUG-level messages from
    -- plugins still get echoed to the message area. Taking over vim.notify is
    -- what actually applies the level gate.
    vim.notify = require("notify")

    require("telescope").load_extension("notify")
  end,
  --cond = false,
  --enabled = false,
}

return spec
