---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>re",
    function()
      return require("refactoring").extract_func()
    end,
    mode = {
      "n",
      "x",
    },
    {
      desc = "Extract Function",
      expr = true,
      --noremap = true,
      silent = true,
    },
  },
  {
    -- `_` is the default textobject for "current line"
    "<leader>ree",
    function()
      return require("refactoring").extract_func() .. "_"
    end,
    mode = "n",
    {
      desc = "Extract Function (line)",
      expr = true,
      --noremap = true,
      silent = true,
    },
  },
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = "n",
    {
      desc = "",
      --expr = true,
      --noremap = true,
      silent = true,
    },
  },
}

return keys
