---@type LazySpec
local spec = {
  "pogyomo/submode.nvim",
  --lazy = false,
  --version = "6.0.0",
  --keys = require("plugins.submode-nvim.keys"),
  event = require("plugins.submode-nvim.events"),
  dependencies = require("plugins.submode-nvim.dependencies"),
  config = function()
    local submode = require("submode")
    local resize = require("winresize").resize

    -- Submode to switch to lsp-related keymaps.
    submode.create("LspOperator", {
      mode = "n",
      enter = "<Space>l",
      leave = {
        "q",
        "<ESC>",
      },
      default = function(register)
        register("d", vim.lsp.buf.definition)
        register("D", vim.lsp.buf.declaration)
        register("H", vim.lsp.buf.hover)
        register("i", vim.lsp.buf.implementation)
        register("r", vim.lsp.buf.references)
      end,
    })

    -- winresize.nvim
    submode.create("WinResize", {
      mode = "n",
      enter = "<Leader>r",
      leave = {
        "q",
        "<ESC>",
      },
      default = function(register)
        register("h", function()
          resize(0, 2, "left")
        end)
        register("j", function()
          resize(0, 1, "down")
        end)
        register("k", function()
          resize(0, 1, "up")
        end)
        register("l", function()
          resize(0, 2, "right")
        end)
      end,
    })

    -- Enable keymaps which is appropriate for reading help when open help.
    submode.create("DocReader", {
      mode = "n",
      default = function(register)
        register("<Enter>", "<C-]>")
        register("u", "<cmd>po<cr>")
        register("r", "<cmd>ta<cr>")
        register("U", "<cmd>ta<cr>")
        register("q", "<cmd>q<cr>")
      end,
    })

    vim.api.nvim_create_augroup("DocReaderAugroup", {})
    vim.api.nvim_create_autocmd("BufEnter", {
      group = "DocReaderAugroup",
      callback = function()
        if vim.opt.ft:get() == "help" and not vim.bo.modifiable then
          submode.enter("DocReader")
        end
      end,
    })

    vim.api.nvim_create_autocmd({
      "BufLeave",
      "CmdwinEnter",
    }, {
      group = "DocReaderAugroup",
      callback = function()
        if submode.mode() == "DocReader" then
          submode.leave()
        end
      end,
    })
  end,
  cond = false,
  enabled = false,
}

return spec
