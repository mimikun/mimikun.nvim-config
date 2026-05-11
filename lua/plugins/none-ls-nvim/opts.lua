local null_ls = require("null-ls")

---@type table
local opts = {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
    -- requires none-ls-extras.nvim
    --require("none-ls.diagnostics.eslint"),
  },
}

return opts
