---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>nto",
    ":NeovimTips<CR>",
    mode = {
      "n",
    },
    desc = "Neovim tips",
    silent = true,
  },
  {
    "<leader>ntb",
    ":NeovimTipsBookmarks<CR>",
    mode = {
      "n",
    },
    desc = "Bookmarked tips",
    silent = true,
  },
  {
    "<leader>ntr",
    ":NeovimTipsRandom<CR>",
    mode = {
      "n",
    },
    desc = "Show random tip",
    silent = true,
  },
  {
    "<leader>nte",
    ":NeovimTipsEdit<CR>",
    mode = {
      "n",
    },
    desc = "Edit your tips",
    silent = true,
  },
  {
    "<leader>nta",
    ":NeovimTipsAdd<CR>",
    mode = {
      "n",
    },
    desc = "Add your tip",
    silent = true,
  },
  {
    "<leader>ntp",
    ":NeovimTipsPdf<CR>",
    mode = {
      "n",
    },
    desc = "Open tips PDF",
    silent = true,
  },
}

return keys
