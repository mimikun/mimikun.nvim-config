---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ca",
    function()
      require("tiny-code-action").code_action()
    end,
    mode = {
      "n",
      "x",
    },
    desc = "tiny-code-action",
    noremap = true,
    silent = true,
  },
}

return keys
