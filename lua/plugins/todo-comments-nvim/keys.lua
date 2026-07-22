---@type LazyKeysSpec[]
local keys = {
  {
    "]t",
    function()
      require("todo-comments").jump_next({
        --[[
        keywords = {
          "ERROR",
          "WARNING",
        },
        ]]
      })
    end,
    mode = {
      "n",
    },
    desc = "Next todo comment",
    --desc = "Next error/warning todo comment",
    silent = true,
  },
  {
    "[t",
    function()
      require("todo-comments").jump_prev()
    end,
    mode = {
      "n",
    },
    desc = "Previous todo comment",
    silent = true,
  },
}

return keys
