local lsp = {
  progress = {
    enabled = true,
    -- Lsp Progress is formatted using the builtins for lsp_progress.
    -- See config.format.builtin
    -- See the section on formatting for more details on how to customize.
    --- @type NoiceFormat|string
    format = "lsp_progress",

    --- @type NoiceFormat|string
    format_done = "lsp_progress_done",

    -- frequency to update lsp progress message
    throttle = 1000 / 10,

    view = "mini",
  },

  override = {
    -- override the default lsp markdown formatter with Noice
    ["vim.lsp.util.convert_input_to_markdown_lines"] = false,

    -- override the lsp markdown formatter with Noice
    ["vim.lsp.util.stylize_markdown"] = false,

    -- override cmp documentation with Noice (needs the other options to work)
    ["cmp.entry.get_documentation"] = false,
  },

  hover = {
    enabled = true,

    -- set to true to not show a message if hover is not available
    silent = false,

    -- when nil, use defaults from documentation
    view = nil,

    -- merged with defaults from documentation
    ---@type NoiceViewOptions
    opts = {},
  },

  signature = {
    enabled = true,
    auto_open = {
      enabled = true,

      -- Automatically show signature help when typing a trigger character from the LSP
      trigger = true,

      -- Will open signature help when jumping to Luasnip insert nodes
      luasnip = true,

      -- Will open when jumping to placeholders in snippets (Neovim builtin snippets)
      snipppets = true,

      -- Debounce lsp signature help request by 50ms
      throttle = 50,
    },

    -- when nil, use defaults from documentation
    view = nil,

    -- merged with defaults from documentation
    ---@type NoiceViewOptions
    opts = {},
  },

  message = {
    -- Messages shown by lsp servers
    enabled = true,

    view = "notify",
    opts = {},
  },

  -- defaults for hover and signature help
  documentation = {
    view = "hover",

    ---@type NoiceViewOptions
    opts = {
      replace = true,
      render = "plain",
      format = {
        "{message}",
      },
      win_options = {
        concealcursor = "n",
        conceallevel = 3,
      },
    },
  },
}

return lsp
