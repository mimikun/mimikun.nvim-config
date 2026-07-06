---@type LazySpec
local spec = {
  "kremovtort/tabterm.nvim",
  --lazy = false,
  cmd = require("plugins.tabterm-nvim.cmds"),
  keys = require("plugins.tabterm-nvim.keys"),
  event = require("plugins.tabterm-nvim.events"),
  --opts = require("plugins.tabterm-nvim.opts"),
  config = function()
    local opts = require("plugins.tabterm-nvim.opts")
    require("tabterm").setup(opts)

    -- Notify when a shell command finishes while tabterm is hidden.
    vim.api.nvim_create_autocmd("User", {
      pattern = "TabtermShellCommandFinished",
      callback = function(ev)
        local data = ev.data or {}
        if data.workspace_visible then
          return
        end

        local label = data.command_label or data.terminal_label or "shell command"
        local level = data.success and vim.log.levels.INFO or vim.log.levels.ERROR
        vim.notify(("%s finished"):format(label), level)
      end,
    })
  end,
  --cond = false,
  --enabled = false,
}

return spec
