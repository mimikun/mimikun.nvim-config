---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>cc",
    ":Convy<CR>",
    mode = {
      "n",
      "v",
    },
    desc = "Convert (interactive selection)",
    silent = true,
  },
  {
    "<leader>cd",
    ":Convy auto dec<CR>",
    mode = {
      "n",
      "v",
    },
    desc = "Convert to decimal",
    silent = true,
  },
  {
    "<leader>cs",
    ":ConvySeparator<CR>",
    mode = {
      "v",
    },
    desc = "Set conversion separator (visual selection)",
    silent = true,
  },
}

return keys
