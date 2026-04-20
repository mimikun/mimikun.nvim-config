---@type virtcolumn.config
local opts = {
  -- Enables or disables virt-column
  ---@type boolean
  enabled = true,

  -- Each character has to have a display width of 0 or 1
  ---@type string | string[]
  char = "┃",

  -- comma-separated list of screen columns, same as `colorcolumn`
  ---@type string
  virtcolumn = "",

  -- Highlight group, or list of highlight groups, that get applied to the virtual column
  ---@type string | string[]
  highlight = "NonText",

  -- Configures what is excluded from virt-column
  ---@type virtcolumn.config.exclude
  exclude = {
    -- List of `filetypes` for which virt-column is disabled
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
    },

    -- List of `buftypes` for which virt-column is disabled
    ---@type string[]
    buftypes = {
      "nofile",
      "quickfix",
      "terminal",
      "prompt",
    },
  },
}

return opts
