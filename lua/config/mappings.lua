vim.keymap.set(
  {
    "n",
  },
  "<Esc><Esc>",
  function()
    vim.cmd("nohlsearch")
  end,
  {
    silent = true,
  }
)

-- Picker keymaps.
-- Backend-agnostic:
-- `config.picker` dispatches to whichever of snacks / telescope is active, and `<leader>uf` flips it (see the snacks `toggles.lua`).
local Picker = require("config.picker")

---@type table<string, { [1]: string, [2]: string | string[] }>
local picker_keys = {
  ["<leader>tf"] = {
    "files",
    "Find files",
  },
  ["<leader>tg"] = {
    "grep",
    "Live grep",
  },
  ["<leader>tb"] = {
    "buffers",
    "Find buffers",
  },
  ["<leader>tr"] = {
    "recent",
    "Recent files",
  },
  ["<leader>tl"] = {
    "lines",
    "Fuzzy find in buffer",
  },
  ["<leader>th"] = {
    "help",
    "Help pages",
  },
  ["<leader>td"] = {
    "diagnostics",
    "Diagnostics",
  },
  ["<leader>ts"] = {
    "lsp_symbols",
    "LSP document symbols",
  },
  ["<leader>tk"] = {
    "keymaps",
    "Keymaps",
  },
  ["<leader>tp"] = {
    "pickers",
    "All picker sources",
  },
  ["<leader>tR"] = {
    "resume",
    "Resume last picker",
  },
}

for lhs, spec in pairs(picker_keys) do
  vim.keymap.set(
    {
      "n",
    },
    lhs,
    Picker.fn(spec[1]),
    {
      desc = spec[2],
      silent = true,
    }
  )
end

vim.keymap.set(
  {
    "n",
    "x",
  },
  "<leader>tw",
  Picker.fn("grep_word"),
  {
    desc = "Grep word/selection",
    silent = true,
  }
)
