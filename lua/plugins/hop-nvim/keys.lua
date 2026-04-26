---@type LazyKeysSpec[]
local keys = {
  {
    "f",
    function()
      require("hop").hint_char1({
        direction = require("hop.hint").HintDirection.AFTER_CURSOR,
        current_line_only = true,
      })
    end,
    mode = {
      "n",
    },
    desc = "",
    remap = true,
    silent = true,
  },
  {
    "F",
    function()
      require("hop").hint_char1({
        direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
        current_line_only = true,
      })
    end,
    mode = {
      "n",
    },
    desc = "",
    remap = true,
    silent = true,
  },
  {
    "t",
    function()
      require("hop").hint_char1({
        direction = require("hop.hint").HintDirection.AFTER_CURSOR,
        current_line_only = true,
        hint_offset = -1,
      })
    end,
    mode = {
      "n",
    },
    desc = "",
    remap = true,
    silent = true,
  },
  {
    "T",
    function()
      require("hop").hint_char1({
        direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
        current_line_only = true,
        hint_offset = 1,
      })
    end,
    mode = {
      "n",
    },
    desc = "",
    remap = true,
    silent = true,
  },
}

return keys
