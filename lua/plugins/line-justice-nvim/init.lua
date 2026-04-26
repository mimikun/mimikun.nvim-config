---@type LazySpec
local spec = {
  "zaakiy/line-justice.nvim",
  lazy = false,
  event = require("plugins.line-justice-nvim.events"),
  dependencies = require("plugins.line-justice-nvim.dependencies"),
  --opts = require("plugins.line-justice-nvim.opts"),
  config = function()
    local lj = require("line-justice")
    lj.setup()

    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      relculright = true,
      segments = {
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        { sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1, auto = true }, click = "v:lua.ScSa" },
        { sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true }, click = "v:lua.ScSa" },
        { sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true }, click = "v:lua.ScSa" },
        { text = { lj.segment }, click = "v:lua.ScLa" },
      },
    })
  end,
  cond = false,
  enabled = false,
}

return spec
