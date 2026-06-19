---@type blink.indent.BlockedConfig
local blocked = {
  -- default: 'terminal', 'quickfix', 'nofile', 'prompt'
  --- @type blink.indent.ListWithDefaults
  buftypes = {
    include_defaults = true,
  },

  -- default: 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'dashboard', ''
  --- @type blink.indent.ListWithDefaults
  filetypes = {
    include_defaults = true,
  },
}

return blocked
