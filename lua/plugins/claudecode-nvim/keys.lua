---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ac",
    "<cmd>ClaudeCode<cr>",
    desc = "Toggle Claude",
    silent = true,
  },
  {
    "<leader>af",
    "<cmd>ClaudeCodeFocus<cr>",
    desc = "Focus Claude",
    silent = true,
  },
  {
    "<leader>ar",
    "<cmd>ClaudeCode --resume<cr>",
    desc = "Resume Claude",
    silent = true,
  },
  {
    "<leader>aC",
    "<cmd>ClaudeCode --continue<cr>",
    desc = "Continue Claude",
    silent = true,
  },
  {
    "<leader>am",
    "<cmd>ClaudeCodeSelectModel<cr>",
    desc = "Select Claude model",
    silent = true,
  },
  {
    "<leader>ab",
    "<cmd>ClaudeCodeAdd %<cr>",
    desc = "Add current buffer",
    silent = true,
  },
  {
    "<leader>as",
    "<cmd>ClaudeCodeSend<cr>",
    mode = {
      "v",
    },
    desc = "Send to Claude",
    silent = true,
  },
  {
    "<leader>as",
    "<cmd>ClaudeCodeTreeAdd<cr>",
    desc = "Add file",
    ft = {
      "NvimTree",
      "neo-tree",
      "oil",
      "minifiles",
      "netrw",
      "snacks_picker_list",
    },
    silent = true,
  },

  -- Diff management
  {
    "<leader>aa",
    "<cmd>ClaudeCodeDiffAccept<cr>",
    desc = "Accept diff",
    silent = true,
  },
  {
    "<leader>ad",
    "<cmd>ClaudeCodeDiffDeny<cr>",
    desc = "Deny diff",
    silent = true,
  },
  --{
  --  -- TODO: it
  --  "<lhs>",
  --  function()
  --    -- TODO: it
  --  end,
  --  mode = {
  --    "n",
  --    -- TODO: it
  --    --"x",
  --    --"v",
  --  },
  --  desc = "",
  --  -- TODO: it
  --  --expr = true,
  --  --noremap = true,
  --  silent = true,
  --},
}

return keys
