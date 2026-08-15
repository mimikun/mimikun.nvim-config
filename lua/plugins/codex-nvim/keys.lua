---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ax",
    function()
      require("codex").focus()
    end,
    desc = "Focus or hide Codex",
  },
  {
    "<leader>ab",
    "<cmd>CodexAdd<cr>",
    desc = "Add current buffer to Codex",
  },
  {
    "<leader>as",
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
