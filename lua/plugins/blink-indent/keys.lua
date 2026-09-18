---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ui",
    function()
      local indent = require("blink.indent")
      indent.enable(not indent.is_enabled())
    end,
    mode = {
      "n",
    },
    desc = "Toggle indent guides",
    silent = true,
  },
}

return keys
