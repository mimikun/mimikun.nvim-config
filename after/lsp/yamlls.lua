---@type vim.lsp.Config
local config = {
  settings = {
    yaml = {
      -- NOTE: the built-in schema store must be disabled to use SchemaStore.nvim
      schemaStore = {
        enable = false,
        -- NOTE: empty url avoids a TypeError in yaml-language-server
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}

return config
