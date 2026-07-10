---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ct",
    "<cmd>CamouflageToggle<cr>",
    --function()
    --end,
    mode = {
      "n",
    },
    desc = "Toggle Camouflage",
    silent = true,
  },
  {
    "<leader>cr",
    "<cmd>CamouflageReveal<cr>",
    --function()
    --end,
    mode = {
      "n",
    },
    desc = "Reveal Line",
    silent = true,
  },
  --    { '<leader>cy', '<cmd>CamouflageYank<cr>', desc = 'Yank Value' },
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = {
      "n",
      -- TODO: it
      --"x",
      --"v",
    },
    desc = "",
    -- TODO: it
    --expr = true,
    --noremap = true,
    silent = true,
  },
  --    { '<leader>cY', '<cmd>CamouflageYank!<cr>', desc = 'Yank Value (Picker)' },
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = {
      "n",
      -- TODO: it
      --"x",
      --"v",
    },
    desc = "",
    -- TODO: it
    --expr = true,
    --noremap = true,
    silent = true,
  },
  --    { '<leader>cf', '<cmd>CamouflageFollowCursor<cr>', desc = 'Follow Cursor' },
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = {
      "n",
      -- TODO: it
      --"x",
      --"v",
    },
    desc = "",
    -- TODO: it
    --expr = true,
    --noremap = true,
    silent = true,
  },
  --vim.keymap.set('n', '<leader>cs', '<cmd>CamouflageStatus<cr>', { desc = 'Camouflage Status' })
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = {
      "n",
      -- TODO: it
      --"x",
      --"v",
    },
    desc = "",
    -- TODO: it
    --expr = true,
    --noremap = true,
    silent = true,
  },
  --vim.keymap.set('n', '<leader>ca', '<cmd>CamouflageAudit<cr>', { desc = 'Audit Workspace' })
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = {
      "n",
      -- TODO: it
      --"x",
      --"v",
    },
    desc = "",
    -- TODO: it
    --expr = true,
    --noremap = true,
    silent = true,
  },
  --vim.keymap.set('n', '<leader>cw', '<cmd>CamouflageWeakSecretToggle<cr>', { desc = 'Toggle Weak Secret Check' })
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = {
      "n",
      -- TODO: it
      --"x",
      --"v",
    },
    desc = "",
    -- TODO: it
    --expr = true,
    --noremap = true,
    silent = true,
  },
  -- Have I Been Pwned
  --    { '<leader>cp', '<cmd>CamouflagePwnedCheck<cr>', desc = 'Check Pwned' },
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = {
      "n",
      -- TODO: it
      --"x",
      --"v",
    },
    desc = "",
    -- TODO: it
    --expr = true,
    --noremap = true,
    silent = true,
  },
  --vim.keymap.set('n', '<leader>cp', '<cmd>CamouflagePwnedCheck<cr>', { desc = 'Check Pwned' })
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = {
      "n",
      -- TODO: it
      --"x",
      --"v",
    },
    desc = "",
    -- TODO: it
    --expr = true,
    --noremap = true,
    silent = true,
  },
  --vim.keymap.set('n', '<leader>cP', '<cmd>CamouflagePwnedCheckBuffer<cr>', { desc = 'Check All Pwned' })
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = {
      "n",
      -- TODO: it
      --"x",
      --"v",
    },
    desc = "",
    -- TODO: it
    --expr = true,
    --noremap = true,
    silent = true,
  },
  --vim.keymap.set('n', '<leader>cx', '<cmd>CamouflagePwnedClear<cr>', { desc = 'Clear Pwned' })
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = {
      "n",
      -- TODO: it
      --"x",
      --"v",
    },
    desc = "",
    -- TODO: it
    --expr = true,
    --noremap = true,
    silent = true,
  },
}

return keys
