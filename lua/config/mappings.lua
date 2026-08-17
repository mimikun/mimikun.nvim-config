vim.keymap.set("n", "<Esc><Esc>", function()
  vim.cmd("nohlsearch")
end, { silent = true })

-- Picker keymaps. Backend-agnostic: `config.picker` dispatches to whichever of
-- snacks / telescope is active, and `<leader>uf` flips it (see the snacks
-- `toggles.lua`).
local Picker = require("config.picker")

---@type table<string, {[1]: string, [2]: string|string[]}>
local picker_keys = {
  ["<leader>Ff"] = { "files", "Find files" },
  ["<leader>Fg"] = { "grep", "Live grep" },
  ["<leader>Fb"] = { "buffers", "Find buffers" },
  ["<leader>Fr"] = { "recent", "Recent files" },
  ["<leader>Fl"] = { "lines", "Fuzzy find in buffer" },
  ["<leader>Fh"] = { "help", "Help pages" },
  ["<leader>Fd"] = { "diagnostics", "Diagnostics" },
  ["<leader>Fs"] = { "lsp_symbols", "LSP document symbols" },
  ["<leader>Fk"] = { "keymaps", "Keymaps" },
  ["<leader>Fp"] = { "pickers", "All picker sources" },
  ["<leader>FR"] = { "resume", "Resume last picker" },
}

for lhs, spec in pairs(picker_keys) do
  vim.keymap.set("n", lhs, Picker.fn(spec[1]), { desc = spec[2], silent = true })
end

vim.keymap.set({ "n", "x" }, "<leader>Fw", Picker.fn("grep_word"), {
  desc = "Grep word/selection",
  silent = true,
})
