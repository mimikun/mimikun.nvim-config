---@type WebOrigamiConfig
local opts = {
  ---@type WebOrigamiServerConfig
  server = {
    -- Whether to auto-install npm dependencies (`npm install` in server dir)
    ---@type boolean
    auto_install = true,

    ---@type string[]
    -- Command to run Node.js
    cmd = {
      "node",
    },
  },

  ---@type WebOrigamiLspConfig
  lsp = {
    -- Additional LSP capabilities to merge (eg, from nvim-cmp)
    ---@type table | nil
    capabilities = nil,

    -- Callback invoked when LSP attaches to a buffer
    -- Custom on_attach
    ---@type function | nil
    on_attach = function(_client, bufnr)
      -- Keymaps
      local bufopts = {
        buffer = bufnr,
        noremap = true,
        silent = true,
      }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    end,

    -- Root directory markers used to detect project root
    ---@type string[]
    root_markers = {
      ".git",
      "package.json",
      "config.ori",
      "site.ori",
    },
  },

  ---@type WebOrigamiFiletypeConfig
  filetypes = {
    ---@type string
    origami = "origami",

    ---@type string
    origami_html = "origamihtml",

    ---@type string
    origami_markdown = "origamimarkdown",
  },
}

return opts
