---@type LazySpec
local spec = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  cmd = require("plugins.nvim-treesitter.cmds"),
  config = function()
    local opts = require("plugins.nvim-treesitter.opts")
    local install_languages = require("plugins.nvim-treesitter.install.languages")
    local install_options = require("plugins.nvim-treesitter.install.options")

    local nvim_treesitter = require("nvim-treesitter")

    -- Setup
    nvim_treesitter.setup(opts)

    -- Enable treesitter features for a buffer, if a parser is available
    ---@param buf integer
    local function enable_treesitter(buf)
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end

      local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
      if not lang then
        return
      end

      -- syntax highlighting, provided by Neovim
      local ok = pcall(vim.treesitter.start, buf)
      if not ok then
        return
      end

      vim.api.nvim_buf_call(buf, function()
        local opt = vim.opt_local

        -- folds, provided by Neovim
        opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        opt.foldmethod = "expr"

        -- open all folds by default
        opt.foldlevel = 99

        -- indentation, provided by nvim-treesitter
        opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end)
    end

    -- Auto-enable treesitter for all filetypes with an installed parser
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        enable_treesitter(ev.buf)
      end,
    })

    -- Install parsers in the background: do not block startup.
    -- Buffers opened before the install finishes are retried in the callback.
    nvim_treesitter.install(install_languages, install_options):await(vim.schedule_wrap(function(err)
      if err then
        vim.notify("nvim-treesitter: parser install failed: " .. tostring(err), vim.log.levels.WARN)
        return
      end

      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
          enable_treesitter(buf)
        end
      end
    end))
  end,
  --cond = false,
  --enabled = false,
}

return spec
