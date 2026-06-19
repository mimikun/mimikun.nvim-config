---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ti",
    function()
      local indent = require("blink.indent")
      indent.enable(not indent.is_enabled())
    end,
    mode = "n",
    desc = "Toggle indent guides",
    --expr = true,
    --noremap = true,
    silent = true,
  },
}

return keys
