---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>-",
    ":Triptych<CR>",
    -- TODO: it
    -- function()
    -- end,
    mode = "n",
    desc = "Toggle Triptych",
    --expr = true,
    --noremap = true,
    silent = true,
  },
}

return keys
