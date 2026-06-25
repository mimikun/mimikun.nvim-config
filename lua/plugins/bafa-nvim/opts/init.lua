---@type BafaUserConfig
local opts = {
  ---@type BafaConfigNotify | nil
  notify = {
    --- Notification provider
    ---@type string | BafaConfigNotifyProvider | "vim.notify" | "print" | "juu.notify" | "telescope.notify"
    provider = "vim.notify",
  },
  ---@type BafaUserConfigUi | nil
  ui = require("plugins.bafa-nvim.opts.ui"),
}

return opts
