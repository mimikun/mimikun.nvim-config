---@type LazyKeysSpec[]
local keys = {
  {
    "<C-j>",
    --function()
    "<Cmd>MultipleCursorsAddDown<CR>",
    --end,
    mode = { "n", "x" },
    desc = "Add cursor and move down",
    silent = true,
  },
  {
    "<C-k>",
    --function()
    "<Cmd>MultipleCursorsAddUp<CR>",
    --end,
    mode = { "n", "x" },
    desc = "Add cursor and move up",
    silent = true,
  },
  {
    "<C-Up>",
    --function()
    "<Cmd>MultipleCursorsAddUp<CR>",
    --end,
    mode = { "n", "i", "x" },
    desc = "Add cursor and move up",
    silent = true,
  },
  {
    "<C-Down>",
    --function()
    "<Cmd>MultipleCursorsAddDown<CR>",
    --end,
    mode = { "n", "i", "x" },
    desc = "Add cursor and move down",
    silent = true,
  },

  {
    "<C-LeftMouse>",
    --function()
    "<Cmd>MultipleCursorsMouseAddDelete<CR>",
    --end,
    mode = { "n", "i" },
    desc = "Add or remove cursor on mouse click",
    silent = true,
  },
  {
    "<C-Return>",
    --function()
    "<Cmd>MultipleCursorsAddDelete<CR>",
    --end,
    mode = { "n" },
    desc = "Add a locked cursor or remove an existing cursor",
    silent = true,
  },
  {
    "<Leader>m",
    --function()
    "<Cmd>MultipleCursorsAddVisualArea<CR>",
    --end,
    mode = { "x" },
    desc = "Add cursors to the lines of the visual area",
    silent = true,
  },
  { "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" }, desc = "Add cursors to cword" },
  {
    "<Leader>A",
    --function()
    "<Cmd>MultipleCursorsAddMatchesV<CR>",
    --end,
    mode = { "n", "x" },
    desc = "Add cursors to cword in previous area",
    silent = true,
  },
  {
    "<Leader>d",
    --function()
    "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
    --end,
    mode = { "n", "x" },
    desc = "Add cursor and jump to next cword",
    silent = true,
  },
  {
    "<Leader>D",
    --function()
    "<Cmd>MultipleCursorsJumpNextMatch<CR>",
    --end,
    mode = { "n", "x" },
    desc = "Jump to next cword",
    silent = true,
  },
  {
    "<Leader>l",
    --function()
    "<Cmd>MultipleCursorsLock<CR>",
    --end,
    mode = { "n", "x" },
    desc = "Lock virtual cursors",
    silent = true,
  },
}

return keys
