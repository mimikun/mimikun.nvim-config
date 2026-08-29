---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ct",
    "<cmd>CamouflageToggle<cr>",
    mode = {
      "n",
    },
    desc = "Toggle Camouflage",
    silent = true,
  },
  {
    "<leader>cr",
    "<cmd>CamouflageReveal<cr>",
    mode = {
      "n",
    },
    desc = "Reveal Line",
    silent = true,
  },
  {
    "<leader>cy",
    "<cmd>CamouflageYank<cr>",
    mode = {
      "n",
    },
    desc = "Yank Value",
    silent = true,
  },
  {
    "<leader>cY",
    "<cmd>CamouflageYank!<cr>",
    mode = {
      "n",
    },
    desc = "Yank Value (Picker)",
    silent = true,
  },
  {
    "<leader>cf",
    "<cmd>CamouflageFollowCursor<cr>",
    mode = {
      "n",
    },
    desc = "Follow Cursor",
    silent = true,
  },
  {
    "<leader>cs",
    "<cmd>CamouflageStatus<cr>",
    mode = {
      "n",
    },
    desc = "Camouflage Status",
    silent = true,
  },
  {
    "<leader>ca",
    "<cmd>CamouflageAudit<cr>",
    mode = {
      "n",
    },
    desc = "Audit Workspace",
    silent = true,
  },
  {
    "<leader>cw",
    "<cmd>CamouflageWeakSecretToggle<cr>",
    mode = {
      "n",
    },
    desc = "Toggle Weak Secret Check",
    silent = true,
  },
  -- Have I Been Pwned
  {
    "<leader>cp",
    function()
      require("camouflage.pwned").check_current()
    end,
    mode = {
      "n",
    },
    desc = "Check if value under cursor is pwned",
    silent = true,
  },
  {
    "<leader>cP",
    function()
      require("camouflage.pwned").check_buffer()
    end,
    mode = {
      "n",
    },
    desc = "Check all values in buffer",
    silent = true,
  },
  {
    "<leader>cx",
    function()
      require("camouflage.pwned").clear()
    end,
    mode = {
      "n",
    },
    desc = "Clear pwned indicators from buffer",
    silent = true,
  },
}

return keys
