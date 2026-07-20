---@type LazySpec
local spec = {
  "nvim-java/nvim-java",
  --lazy = false,
  --ft = require("plugins.nvim-java.ft"),
  cmd = require("plugins.nvim-java.cmds"),
  --keys = require("plugins.nvim-java.keys"),
  --event = require("plugins.nvim-java.events"),
  --dependencies = require("plugins.nvim-java.dependencies"),
  --opts = require("plugins.nvim-java.opts"),
  config = function()
    local opts = require("plugins.nvim-java.opts")
    require("java").setup(opts)
    -- Use `vim.lsp.config()` to override the default JDTLS settings:
    vim.lsp.config("jdtls", {
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-21",
                path = "/opt/jdk-21",
                default = true,
              },
            },
          },
        },
      },
    })
    vim.lsp.enable("jdtls")
  end,
  cond = false,
  enabled = false,
}

return spec
