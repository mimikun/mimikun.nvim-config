---@type LazySpec
local spec = {
  "stevearc/stickybuf.nvim",
  --lazy = false,
  cmd = require("plugins.stickybuf-nvim.cmds"),
  event = require("plugins.stickybuf-nvim.events"),
  --opts = require("plugins.stickybuf-nvim.opts"),
  config = function()
    local opts = require("plugins.stickybuf-nvim.opts")
    local stickybuf = require("stickybuf")
    stickybuf.setup(opts)

    --[[
    vim.api.nvim_create_autocmd("BufEnter", {
      desc = "Pin the buffer to any window that is fixed width or height",
      callback = function(args)
        if not stickybuf.is_pinned() and (vim.wo.winfixwidth or vim.wo.winfixheight) then
          stickybuf.pin()
        end
      end,
    })
    ]]
  end,
  cond = false,
  enabled = false,
}

return spec
