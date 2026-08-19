-- Or pass a table to customize specific configuration options
local bracket_nav = {
  enabled = true,

  mappings = {
    d = {
      prev = vim.diagnostic.goto_prev,
      next = vim.diagnostic.goto_next,
      desc = "Diagnostic",
    },
    q = {
      prev = "<cmd>cprev<cr>",
      next = "<cmd>cnext<cr>",
      desc = "Quickfix",
    },
    Q = {
      prev = "<cmd>cfirst<cr>",
      next = "<cmd>clast<cr>",
      desc = "First/Last Quickfix Item",
    },
    l = {
      prev = "<cmd>lprev<cr>",
      next = "<cmd>lnext<cr>",
      desc = "Location Item",
    },
    L = {
      prev = "<cmd>lfirst<cr>",
      next = "<cmd>llast<cr>",
      desc = "First/Last Location Item",
    },
    b = {
      prev = "<cmd>bprev<cr>",
      next = "<cmd>bnext<cr>",
      desc = "Buffer",
    },
    B = {
      prev = "<cmd>bfirst<cr>",
      next = "<cmd>blast<cr>",
      desc = "First/Last Buffer",
    },
    w = {
      prev = "<C-w>p",
      next = "<C-w>w",
      desc = "Window",
    },
    j = {
      prev = "<C-o>",
      next = "<C-i>",
      desc = "Jump",
    },
  },

  -- Disable [Space / ]Space mappings?
  blank_lines = true,

  git_conflicts = true,
}

return bracket_nav
