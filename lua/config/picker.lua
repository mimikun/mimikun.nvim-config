-- Picker backend router.
--
-- Two general-purpose pickers are kept side by side and switched at will:
--
--   snacks    - better integrated, more sources, matches the rest of the folke
--               plugins already in this config
--   telescope - far better maintained, and it is not going away regardless:
--               18 plugins here pull it in through `dependencies.lua`
--
-- Neither wins outright, so the `<leader>F` keymaps dispatch through this
-- module and `<leader>uf` flips the backend. The choice is session-local
-- (`vim.g.picker_backend`); it is not persisted across restarts.

local M = {}

M.default = "snacks"

-- snacks source -> telescope builtin
local sources = {
  files = { snacks = "files", telescope = "find_files" },
  grep = { snacks = "grep", telescope = "live_grep" },
  grep_word = { snacks = "grep_word", telescope = "grep_string" },
  buffers = { snacks = "buffers", telescope = "buffers" },
  recent = { snacks = "recent", telescope = "oldfiles" },
  lines = { snacks = "lines", telescope = "current_buffer_fuzzy_find" },
  help = { snacks = "help", telescope = "help_tags" },
  diagnostics = { snacks = "diagnostics", telescope = "diagnostics" },
  lsp_symbols = { snacks = "lsp_symbols", telescope = "lsp_document_symbols" },
  keymaps = { snacks = "keymaps", telescope = "keymaps" },
  pickers = { snacks = "pickers", telescope = "builtin" },
  resume = { snacks = "resume", telescope = "resume" },
}

M.sources = sources

---@return "snacks"|"telescope"
function M.backend()
  return vim.g.picker_backend == "telescope" and "telescope" or "snacks"
end

---@param name "snacks"|"telescope"
function M.set(name)
  vim.g.picker_backend = name
end

-- Both pickers are lazy-loaded plugins, so they may not be on the runtimepath
-- yet when a keymap fires.
---@param plugin string
local function load(plugin)
  local ok, lazy = pcall(require, "lazy")
  if ok then
    pcall(lazy.load, { plugins = { plugin } })
  end
end

---@param source string key of `M.sources`
function M.pick(source)
  local entry = sources[source]
  if not entry then
    return vim.notify("Unknown picker source: " .. source, vim.log.levels.ERROR)
  end

  local backend = M.backend()
  if backend == "telescope" then
    load("telescope.nvim")
    require("telescope.builtin")[entry.telescope]()
  else
    load("snacks.nvim")
    require("snacks").picker[entry.snacks]()
  end
end

---@param source string
---@return fun()
function M.fn(source)
  return function()
    M.pick(source)
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    pcall(function()
      require("which-key").add({ { "<leader>F", group = "Find" } })
    end)
  end,
})

return M
