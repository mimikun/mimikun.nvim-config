---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ff",
    function()
      require("telescope.builtin").find_files()
    end,
    mode = "n",
    desc = "Telescope find files",
    { silent = true },
  },
  {
    "<leader>fg",
    function()
      require("telescope.builtin").live_grep()
    end,
    mode = "n",
    desc = "Telescope live grep",
    { silent = true },
  },
  {
    "<leader>fb",
    function()
      require("telescope.builtin").buffers()
    end,
    mode = "n",
    desc = "Telescope buffers",
    { silent = true },
  },
  {
    "<leader>fh",
    "<lhs>",
    function()
      require("telescope.builtin").help_tags()
    end,
    mode = "n",
    desc = "Telescope help tags",
    { silent = true },
  },
}

return keys
