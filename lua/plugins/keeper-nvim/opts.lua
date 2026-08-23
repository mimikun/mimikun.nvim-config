---@type KeeperConfig
local opts = {
  -- register the :Keeper command
  ---@type boolean
  enabled = true,

  ---@type KeeperSaveNRestoreConfig
  save_n_restore = {
    -- save the buffer list on exit and restore it on start
    ---@type boolean
    enabled = true,

    -- path of the JSON file buffer lists are saved to
    ---@type string
    save_file = vim.fn.stdpath("data") .. "/keeper/buffers.json",
  },
}

return opts
