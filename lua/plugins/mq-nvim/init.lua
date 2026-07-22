---@type LazySpec
local spec = {
  "harehare/mq",
  --lazy = false,
  ft = require("plugins.mq-nvim.ft"),
  cmd = require("plugins.mq-nvim.cmds"),
  event = require("plugins.mq-nvim.events"),
  --opts = require("plugins.mq-nvim.opts"),
  config = function()
    -- The Neovim plugin lives in a subdirectory of the harehare/mq monorepo.
    -- lazy.nvim only adds the repo root to runtimepath, so append the plugin subdirectory manually before requiring its Lua modules.
    vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/mq/editors/neovim")
    vim.cmd("runtime plugin/mq.lua")

    local opts = require("plugins.mq-nvim.opts")

    -- mq's dap.setup() emits an INFO notification on every startup;
    -- silence just that message by filtering vim.notify for the duration of setup().
    local original_notify = vim.notify
    vim.notify = function(msg, level, notify_opts)
      if msg == "mq: DAP adapter configured successfully" then
        return
      end
      return original_notify(msg, level, notify_opts)
    end
    local ok, err = pcall(require("mq").setup, opts)
    vim.notify = original_notify
    if not ok then
      error(err)
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "mq",
      callback = function()
        -- Run selected text
        vim.keymap.set("v", "<leader>mr", function()
          require("mq.commands").run_selected_text()
        end, {
          buffer = true,
          noremap = true,
          silent = true,
          desc = "Run selected text as mq query",
          range = true,
        })

        -- Execute query
        vim.keymap.set("n", "<leader>mq", function()
          require("mq.commands").execute_query()
        end, {
          buffer = true,
          noremap = true,
          silent = true,
          desc = "Execute mq query on current file",
        })

        -- Execute file
        vim.keymap.set("n", "<leader>mf", function()
          require("mq.commands").execute_file()
        end, {
          buffer = true,
          noremap = true,
          silent = true,
          desc = "Execute mq file on current file",
        })

        -- Debug file
        vim.keymap.set("n", "<leader>md", function()
          require("mq.commands").debug_current_file()
        end, {
          buffer = true,
          noremap = true,
          silent = true,
          desc = "Debug current mq file",
        })

        -- LSP commands
        vim.keymap.set("n", "<leader>ms", function()
          require("mq.commands").start_lsp()
        end, {
          buffer = true,
          noremap = true,
          silent = true,
          desc = "Start mq LSP server",
        })

        vim.keymap.set("n", "<leader>mS", function()
          require("mq.commands").stop_lsp()
        end, {
          buffer = true,
          noremap = true,
          silent = true,
          desc = "Stop mq LSP server",
        })
      end,
    })
  end,
  --cond = false,
  --enabled = false,
}

return spec
