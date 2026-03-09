---@type LazySpec
local spec = {
  "Omochice/dps-translate-vim",
  --lazy = false,
  cmd = require("denops-plugins.dps-translate-vim.cmds"),
  dependencies = require("denops-plugins.dps-translate-vim.dependencies"),
  --opts = require("denops-plugins.dps-translate-vim.opts"),
  config = function()
    vim.g.dps_translate_source = "en"
    vim.g.dps_translate_target = "ja"
    vim.g.dps_translate_engine = "google"
    --vim.g.dps_translate_deepl_token= ""
    vim.g.dps_translate_deepl_is_pro = false
    vim.g.dps_translate_border = {
      topLeft = "┌",
      top = "─",
      topRight = "┐",
      left = "│",
      right = "│",
      bottomLeft = "└",
      bottom = "─",
      bottomRight = "┘",
    }
  end,
  cond = false,
  enabled = false,
}

return spec
