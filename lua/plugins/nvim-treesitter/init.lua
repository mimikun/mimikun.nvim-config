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

      -- indentation, provided by nvim-treesitter (buffer-local)
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

      -- folds, provided by Neovim
      -- (window-local: apply to every window currently displaying this buffer)
      for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[win].foldmethod = "expr"

        -- open all folds by default
        vim.wo[win].foldlevel = 99
      end
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
