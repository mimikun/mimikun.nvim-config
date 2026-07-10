---@type WindConfig
local opts = {
  ---@type WindWindowsConfig
  windows = require("plugins.wind-nvim.opts.windows"),

  ---@type WindBreathsConfig
  breaths = require("plugins.wind-nvim.opts.breaths"),

  ---@type WindRevealConfig
  reveal = require("plugins.wind-nvim.opts.reveal"),

  ---@type WindKeymaps | false
  keymaps = require("plugins.wind-nvim.opts.keymaps"),
}

return opts
