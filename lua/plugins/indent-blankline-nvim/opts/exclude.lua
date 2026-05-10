---@type ibl.config.exclude
local exclude = {
  -- List of `filetypes` for which indent-blankline is disabled
  ---@type string[]
  filetypes = {
    "lspinfo",
    "packer",
    "checkhealth",
    "help",
    "man",
    "gitcommit",
    "TelescopePrompt",
    "TelescopeResults",
    "",
  },

  -- List of `buftypes` for which indent-blankline is disabled
  ---@type string[]
  buftypes = {
    "terminal",
    "nofile",
    "quickfix",
    "prompt",
  },
}

return exclude
