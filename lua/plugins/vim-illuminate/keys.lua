---@type LazyKeysSpec[]
local keys = {
  {
    "<a-n>",
    function()
      require("illuminate").goto_next_reference()
    end,
    mode = "n",
    desc = "Move to next reference",
    { silent = true },
  },
  {
    "<a-p>",
    function()
      require("illuminate").goto_prev_reference()
    end,
    mode = "n",
    desc = "Move to previous reference",
    { silent = true },
  },
  {
    "<a-i>",
    function()
      require("illuminate").textobj_select()
    end,
    mode = "o",
    desc = "",
    { silent = true },
  },
  {
    "<a-i>",
    function()
      require("illuminate").textobj_select()
    end,
    mode = "x",
    desc = "",
    { silent = true },
  },
}

return keys
