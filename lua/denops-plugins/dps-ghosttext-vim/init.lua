-- denops is gated on host/OS; see lua/config/denops.lua for the allowlist.
local denops_enabled = require("config.denops")

---@type LazySpec
local spec = {
  "gamoutatsumi/dps-ghosttext.vim",
  --lazy = false,
  cmd = require("denops-plugins.dps-ghosttext-vim.cmds"),
  dependencies = require("denops-plugins.dps-ghosttext-vim.dependencies"),
  --opts = require("denops-plugins.dps-ghosttext-vim.opts"),
  config = function()
    --- USER COMMANDS
    vim.api.nvim_create_user_command("GhostTextStatus", function()
      vim.fn["ghosttext#status"]()
    end, {})
    vim.api.nvim_create_user_command("GhostTextStart", function()
      vim.fn["ghosttext#start"]()
    end, {})

    --- VARIABLES
    --vim.g["dps_ghosttext#ftmap"] = {"github.com": "markdown"}
    vim.g["dps_ghosttext#disable_defaultmap"] = 0
    vim.g["dps_ghosttext#enable_autostart"] = 0
  end,
  cond = denops_enabled,
  enabled = denops_enabled,
}

return spec
