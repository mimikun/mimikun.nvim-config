---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>acc",
    "<cmd>ClaudeCode<cr>",
    desc = "Toggle Claude",
    silent = true,
  },
  {
    "<leader>acf",
    "<cmd>ClaudeCodeFocus<cr>",
    desc = "Focus Claude",
    silent = true,
  },
  {
    "<leader>acr",
    "<cmd>ClaudeCode --resume<cr>",
    desc = "Resume Claude",
    silent = true,
  },
  {
    "<leader>acC",
    "<cmd>ClaudeCode --continue<cr>",
    desc = "Continue Claude",
    silent = true,
  },
  {
    "<leader>acm",
    "<cmd>ClaudeCodeSelectModel<cr>",
    desc = "Select Claude model",
    silent = true,
  },
  {
    "<leader>acb",
    "<cmd>ClaudeCodeAdd %<cr>",
    desc = "Add current buffer",
    silent = true,
  },
  {
    "<leader>acs",
    "<cmd>ClaudeCodeSend<cr>",
    mode = {
      "v",
    },
    desc = "Send to Claude",
    silent = true,
  },
  {
    "<leader>acs",
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
    "<leader>aca",
    "<cmd>ClaudeCodeDiffAccept<cr>",
    desc = "Accept diff",
    silent = true,
  },
  {
    "<leader>acd",
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
