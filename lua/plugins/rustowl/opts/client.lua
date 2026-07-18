-- The LSP client config (This can also be set using |vim.lsp.config()|).
---@type rustowl.ClientConfig
local client = {
  ---@type string[]
  cmd = { "rustowl" },

  ---@type fun():string?
  root_dir = function()
    return vim.fs.root(0, { "Cargo.toml", ".git" })
  end,

  on_attach = function(_, buffer)
    vim.keymap.set("n", "<leader>ro", function()
      require("rustowl").toggle(buffer)
    end, { buffer = buffer, desc = "Toggle RustOwl" })

    vim.keymap.set("n", "<leader>re", function()
      require("rustowl").enable(buffer)
    end, { buffer = buffer, desc = "Enable RustOwl" })

    vim.keymap.set("n", "<leader>rd", function()
      require("rustowl").disable(buffer)
    end, { buffer = buffer, desc = "Disable RustOwl" })
  end,
}

return client
