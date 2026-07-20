---@type LazySpec
local spec = {
  "scalameta/nvim-metals",
  --lazy = false,
  ft = require("plugins.nvim-metals.ft"),
  --cmd = require("plugins.nvim-metals.cmds"),
  --keys = require("plugins.nvim-metals.keys"),
  --event = require("plugins.nvim-metals.events"),
  dependencies = require("plugins.nvim-metals.dependencies"),
  opts = function()
    local metals_config = require("metals").bare_config()
    metals_config.on_attach = function(client, bufnr)
      -- your on_attach function
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
  cond = false,
  enabled = false,
}

return spec
