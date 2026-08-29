---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>gg",
    function()
      require("neogit").open({
        -- open a specific popup
        --"commit",
        -- open with different project
        --cwd = "~",
        -- open as a split
        --kind = "split",
      })
    end,
    mode = {
      "n",
    },
    desc = "Open Neogit UI",
    silent = true,
  },
}

return keys
