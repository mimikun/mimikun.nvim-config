---@type table
local opts = {
  -- Pass a boolean to enable a module with default options
  highlighter = true, -- Enable ColorHighlighterToggle command
  copy = true, -- Enable clipboard copy utilities (including CopyGitUrl)
  md_preview = true, -- Enable MDPreview command
  pairs = true, -- Enable zero-dependency autopairs
  replace = true, -- Enable project search & replace
  runner = true, -- Enable async code runner command
  terminal = true, -- Enable Snacks-based terminal commands (needs snacks.nvim)
  tmux = true, -- Enable seamless vim/tmux navigation
  dir = true, -- Enable RootDir, RangerPicker, and background Git commands

  -- Or pass a table to customize specific configuration options
  bracket_nav = {
    enabled = true,
    -- Disable [Space / ]Space mappings
    blank_lines = false,
    mappings = {
      d = { prev = vim.diagnostic.goto_prev, next = vim.diagnostic.goto_next, desc = "Diagnostic" },
      q = { prev = "<cmd>cprev<cr>", next = "<cmd>cnext<cr>", desc = "Quickfix" },
      Q = { prev = "<cmd>cfirst<cr>", next = "<cmd>clast<cr>", desc = "First/Last Quickfix Item" },
      l = { prev = "<cmd>lprev<cr>", next = "<cmd>lnext<cr>", desc = "Location Item" },
      L = { prev = "<cmd>lfirst<cr>", next = "<cmd>llast<cr>", desc = "First/Last Location Item" },
      b = { prev = "<cmd>bprev<cr>", next = "<cmd>bnext<cr>", desc = "Buffer" },
      B = { prev = "<cmd>bfirst<cr>", next = "<cmd>blast<cr>", desc = "First/Last Buffer" },
      w = { prev = "<C-w>p", next = "<C-w>w", desc = "Window" },
      j = { prev = "<C-o>", next = "<C-i>", desc = "Jump" },
    },
    git_conflicts = true,
  },
  tiling = {
    enabled = true,
    split_ratio = 1.8, -- Override default split ratio of 2.0
  },
  runner = {
    enabled = true,
    interpreters = {
      rust = "cargo run", -- Add support for Rust code execution
      python = "python3",
      ruby = "ruby",
      lua = "lua",
      javascript = "node",
      typescript = "ts-node",
      sh = "bash",
      bash = "bash",
      go = "go run",
      elixir = "elixir",
      java = "java",
    },
  },
  pairs = {
    enabled = true,
    self_closing_tags = {
      area = true,
      base = true,
      br = true,
      col = true,
      embed = true,
      hr = true,
      img = true,
      input = true,
      keygen = true,
      link = true,
      meta = true,
      param = true,
      source = true,
      track = true,
      wbr = true,
    },
    tag_filetypes = {
      astro = true,
      heex = true,
      html = true,
      javascriptreact = true,
      jinja = true,
      markdown = true,
      php = true,
      svelte = true,
      typescriptreact = true,
      vue = true,
      xhtml = true,
      -- Enable tag-closing in XML files
      xml = true,
    },
  },
}

return opts
