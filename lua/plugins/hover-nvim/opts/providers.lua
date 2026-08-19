-- List of modules names to load as providers.
---@type (string | Hover.Config.Provider)[]
local providers = {
  -- NOTE: "hover.providers.diagnostic",
  {
    module = "hover.providers.diagnostic",
    priority = 900,
    name = "Diagnostics",
  },

  -- NOTE: "hover.providers.lsp",
  {
    module = "hover.providers.lsp",
    priority = 1000,
    name = "LSP",
  },

  -- NOTE: "hover.providers.dap",
  {
    module = "hover.providers.dap",
    priority = 1002,
    name = "DAP",
  },

  -- NOTE: "hover.providers.man",
  {
    module = "hover.providers.man",
    priority = 150,
    name = "Man",
  },

  -- NOTE: "hover.providers.dictionary",
  -- Disabled: sends the word under the cursor to api.dictionaryapi.dev via curl.
  --{
  --  module = "hover.providers.dictionary",
  --  priority = 100,
  --  name = "Dictionary",
  --},

  -- NOTE: Optional, disabled by default:

  -- NOTE: "hover.providers.gh",
  {
    module = "hover.providers.gh",
    priority = 200,
    name = "Github: Issues and PR's",
  },

  -- NOTE: "hover.providers.gh_user",
  {
    module = "hover.providers.gh_user",
    priority = 200,
    name = "Github: Users",
  },

  -- NOTE: "hover.providers.jira",
  {
    module = "hover.providers.jira",
    priority = 175,
    name = "Jira",
  },

  -- NOTE: "hover.providers.fold_preview",
  {
    module = "hover.providers.fold_preview",
    priority = 1003,
    name = "Fold Previewing",
  },

  -- NOTE: "hover.providers.highlight",
  {
    module = "hover.providers.highlight",
    -- NOTE: `enabled` is true in almost any highlighted buffer,
    -- so a high priority would always shadow the LSP hover.
    priority = 50,
    name = "Highlight",
  },
}

return providers
