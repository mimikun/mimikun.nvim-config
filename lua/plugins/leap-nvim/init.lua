---@type LazySpec
local spec = {
  url = "https://codeberg.org/andyg/leap.nvim",
  lazy = false,
  -- mirror
  --url = "https://git.disroot.org/andyg/leap.nvim",
  dependencies = require("plugins.leap-nvim.dependencies"),
  config = function()
    -- Leap has no setup(); options are assigned onto `require("leap").opts`.
    local opts = require("plugins.leap-nvim.opts")
    local leap = require("leap")
    for key, value in pairs(opts) do
      leap.opts[key] = value
    end

    vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)", { desc = "Leap (current window)" })
    -- The README suggests `S` here, but surround-ui.nvim already owns it
    -- (see lua/plugins/surround-ui-nvim/opts.lua, root_key = "S").
    vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)", { desc = "Leap (other windows)" })
  end,
  --cond = false,
  --enabled = false,
}

return spec
