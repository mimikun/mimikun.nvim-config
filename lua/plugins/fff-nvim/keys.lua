---@type LazyKeysSpec[]
local keys = {
  {
    "ff",
    function()
      require("fff").find_files()
    end,
    desc = "FFFind files",
    silent = true,
  },
  {
    "fg",
    function()
      require("fff").live_grep()
    end,
    desc = "LiFFFe grep",
    silent = true,
  },
  {
    "fz",
    function()
      require("fff").live_grep({
        grep = {
          modes = {
            "fuzzy",
            "plain",
          },
        },
      })
    end,
    desc = "Live fffuzy grep",
    silent = true,
  },
  {
    "fc",
    function()
      require("fff").live_grep({
        query = vim.fn.expand("<cword>"),
      })
    end,
    desc = "Search current word",
    silent = true,
  },
}

return keys
