---@type LazySpec
local spec = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  cmd = require("plugins.nvim-treesitter.cmds"),
  config = function()
    local nvim_treesitter = require("nvim-treesitter")

    -- Setup
    nvim_treesitter.setup(require("plugins.nvim-treesitter.opts"))

    -- Install: wait 5 minutes
    nvim_treesitter
      .install(require("plugins.nvim-treesitter.install.languages"), require("plugins.nvim-treesitter.install.options"))
      :wait(300000)

    -- Auto-enable treesitter for all filetypes with an installed parser
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
        if not lang then
          return
        end

        -- syntax highlighting, provided by Neovim
        local ok = pcall(vim.treesitter.start, ev.buf)
        if not ok then
          return
        end
        local opt = vim.opt_local

        -- folds, provided by Neovim
        opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        opt.foldmethod = "expr"
        -- open all folds by default
        opt.foldlevel = 99
        -- indentation, provided by nvim-treesitter
        opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
  cond = false,
  enabled = false,
}

return spec
