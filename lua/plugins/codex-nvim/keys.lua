---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>axx",
    function()
      require("codex").focus()
    end,
    desc = "Focus or hide Codex",
  },
  {
    "<leader>axb",
    "<cmd>CodexAdd<cr>",
    desc = "Add current buffer to Codex",
  },
  {
    "<leader>axs",
    function()
      require("codex").send_visual()
    end,
    mode = {
      "v",
    },
    desc = "Send selection to Codex",
  },
}

return keys
