---@type LazySpec
local spec = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  --lazy = false,
  cmd = require("plugins.indent-blankline-nvim.cmds"),
  event = require("plugins.indent-blankline-nvim.events"),
  dependencies = require("plugins.indent-blankline-nvim.dependencies"),
  --opts = require("plugins.indent-blankline-nvim.opts"),
  config = function()
    local ibl = require("ibl")
    local hooks = require("ibl.hooks")
    local opts = require("plugins.indent-blankline-nvim.opts")
    local rainbow_delimiters_opts = require("plugins.indent-blankline-nvim.opts.rainbow-delimiters")

    -- create the highlight groups in the highlight setup hook,
    -- so they are reset every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    -- rainbow-delimiters.nvim integration
    vim.g.rainbow_delimiters = rainbow_delimiters_opts

    ibl.setup(opts)

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
  --cond = false,
  --enabled = false,
}

return spec
