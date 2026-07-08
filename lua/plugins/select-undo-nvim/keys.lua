---@type LazyKeysSpec[]
local keys = {
  {
    "gu",
    function()
      require("select-undo").undo_selection("line")
    end,
    mode = {
      "x",
    },
    desc = "Selective undo: newest change in selection",
    noremap = true,
    silent = true,
  },
  {
    "gU",
    function()
      require("select-undo").undo_selection("sweep")
    end,
    mode = {
      "x",
    },
    desc = "Selective undo: last change of every selected line",
    noremap = true,
    silent = true,
  },
  {
    "gC",
    function()
      require("select-undo").undo_selection("partial")
    end,
    mode = {
      "x",
    },
    desc = "Selective undo for character selection",
    noremap = true,
    silent = true,
  },
}

return keys
