---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>No",
    ":NeovimTips<CR>",
    mode = {
      "n",
    },
    desc = "Neovim tips",
    silent = true,
  },
  {
    "<leader>Nb",
    ":NeovimTipsBookmarks<CR>",
    mode = {
      "n",
    },
    desc = "Bookmarked tips",
    silent = true,
  },
  {
    "<leader>Nr",
    ":NeovimTipsRandom<CR>",
    mode = {
      "n",
    },
    desc = "Show random tip",
    silent = true,
  },
  {
    "<leader>Ne",
    ":NeovimTipsEdit<CR>",
    mode = {
      "n",
    },
    desc = "Edit your tips",
    silent = true,
  },
  {
    "<leader>Na",
    ":NeovimTipsAdd<CR>",
    mode = {
      "n",
    },
    desc = "Add your tip",
    silent = true,
  },
  {
    "<leader>Np",
    ":NeovimTipsPdf<CR>",
    mode = {
      "n",
    },
    desc = "Open tips PDF",
    silent = true,
  },
}

return keys
