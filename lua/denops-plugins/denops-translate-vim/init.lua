---@type LazySpec
local spec = {
  "skanehira/denops-translate.vim",
  --lazy = false,
  cmd = require("denops-plugins.denops-translate-vim.cmds"),
  --event = "VeryLazy",
  dependencies = require("denops-plugins.denops-translate-vim.dependencies"),
  --opts = require("plugins.denops-translate-vim.opts"),
  config = function()
    vim.g.translate_source = "en"
    vim.g.translate_target = "ja"
    -- If you use DeepL, you need to append the authentication key to the following file.
    -- $XDG_CONFIG_HOME/denops_translate/deepl_authkey
    --vim.g.translate_endpoint= 'https://api-free.deepl.com/v2/translate'
    ---@type string "popup" | "buffer" | ""
    vim.g.translate_ui = "popup"
    --vim.g.translate_border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    vim.g.translate_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
  end,
  cond = false,
  enabled = false,
}

return spec
