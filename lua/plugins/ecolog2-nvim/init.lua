--local build
--build = [[
--  cargo install ecolog-lsp && \
--  cargo install ecolog-provider-doppler --root ~/.local/share/ecolog/providers
--]]
--build = "cargo install ecolog-lsp"

---@type LazySpec
local spec = {
  "ph1losof/ecolog2.nvim",
  lazy = false,
  --build = build,
  cmd = require("plugins.ecolog2-nvim.cmds"),
  keys = require("plugins.ecolog2-nvim.keys"),
  event = require("plugins.ecolog2-nvim.events"),
  dependencies = require("plugins.ecolog2-nvim.dependencies"),
  --opts = require("plugins.ecolog2-nvim.opts"),
  config = function()
    local opts = require("plugins.ecolog2-nvim.opts")
    require("ecolog").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
