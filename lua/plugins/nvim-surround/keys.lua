---@type LazyKeysSpec[]
local keys = {
  {
    "<C-g>s",
    "<Plug>(nvim-surround-insert)",
    mode = "i",
    desc = "Add a surrounding pair around the cursor (insert mode)",
    { silent = true },
  },
  {
    "<C-g>S",
    "<Plug>(nvim-surround-insert-line)",
    mode = "i",
    desc = "Add a surrounding pair around the cursor, on new lines (insert mode)",
    { silent = true },
  },
  {
    "ys",
    "<Plug>(nvim-surround-normal)",
    mode = "n",
    desc = "Add a surrounding pair around a motion (normal mode)",
    { silent = true },
  },
  {
    "yss",
    "<Plug>(nvim-surround-normal-cur)",
    mode = "n",
    desc = "Add a surrounding pair around the current line (normal mode)",
    { silent = true },
  },
  {
    "yS",
    "<Plug>(nvim-surround-normal-line)",
    mode = "n",
    desc = "Add a surrounding pair around a motion, on new lines (normal mode)",
    { silent = true },
  },
  {
    "ySS",
    "<Plug>(nvim-surround-normal-cur-line)",
    mode = "n",
    desc = "Add a surrounding pair around the current line, on new lines (normal mode)",
    { silent = true },
  },
  {
    "S",
    "<Plug>(nvim-surround-visual)",
    mode = "x",
    desc = "Add a surrounding pair around a visual selection",
    { silent = true },
  },
  {
    "gS",
    "<Plug>(nvim-surround-visual-line)",
    mode = "x",
    desc = "Add a surrounding pair around a visual selection, on new lines",
    { silent = true },
  },
  {
    "ds",
    "<Plug>(nvim-surround-delete)",
    mode = "n",
    desc = "Delete a surrounding pair",
    { silent = true },
  },
  {
    "cs",
    "<Plug>(nvim-surround-change)",
    mode = "n",
    desc = "Change a surrounding pair",
    { silent = true },
  },
  {
    "cS",
    "<Plug>(nvim-surround-change-line)",
    mode = "n",
    desc = "Change a surrounding pair, putting replacements on new lines",
    { silent = true },
  },
}

return keys
