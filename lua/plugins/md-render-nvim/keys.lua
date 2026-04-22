---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>mp",
    "<Plug>(md-render-preview)",
    desc = "Markdown preview (toggle)",
    { silent = true },
  },
  {
    "<leader>mt",
    "<Plug>(md-render-preview-tab)",
    desc = "Markdown preview in tab (toggle)",
    { silent = true },
  },
  {
    "<leader>md",
    "<Plug>(md-render-demo)",
    desc = "Markdown render demo",
    { silent = true },
  },
}

return keys
