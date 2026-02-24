---@type LazySpec
local spec = {
  "stevearc/oil.nvim",
  lazy = false,
  cmd = require("plugins.oil-nvim.cmds"),
  keys = require("plugins.oil-nvim.keys"),
  dependencies = require("plugins.oil-nvim.dependencies"),
  --opts = require("plugins.oil-nvim.opts"),
  config = function()
    local oil = require("oil")
    local opts = require("plugins.oil-nvim.opts")

    -- Toggle file detail view
    local detail = false

    -- Declare a global function to retrieve the current directory
    function _G.get_oil_winbar()
      local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
      local dir = oil.get_current_dir(bufnr)
      if dir then
        return vim.fn.fnamemodify(dir, ":~")
      else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
      end
    end

    -- Setup
    oil.setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
