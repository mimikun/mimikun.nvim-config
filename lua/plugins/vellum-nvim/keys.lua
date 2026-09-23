---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>mp",
    function()
      require("vellum").toggle()
    end,
    mode = {
      "n",
    },
    desc = "Markdown preview",
    silent = true,
  },
}

return keys
