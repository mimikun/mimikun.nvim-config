---@type LazyKeysSpec[]
local mode_nxo = {
  "n",
  "x",
  "o",
}

-- All bindings use the <Cmd>...<CR> string form rather than a Lua function.
-- Upstream does the same for operator-pending mode, where a plain function
-- breaks dot-repeat (see CODES lua/mini/jump2d.lua, neovim/neovim#23406).
--
-- builtin_opts.query is deliberately left unbound: it is a search-first jump
-- driven by vim.fn.input, which duplicates leap.nvim's "s" and feels nothing
-- like it.

---@type LazyKeysSpec[]
local keys = {
  {
    -- The 2-hop jump flash.nvim used to provide on <leader>lh. <leader>l
    -- belongs to leap.nvim now, so jump2d has its own <leader>j namespace.
    "<leader>jj",
    "<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<CR>",
    mode = mode_nxo,
    desc = "Jump2d word start",
    silent = true,
  },
  {
    "<leader>jl",
    "<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.line_start)<CR>",
    mode = mode_nxo,
    desc = "Jump2d line start",
    silent = true,
  },
  {
    "<leader>jc",
    "<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
    mode = mode_nxo,
    desc = "Jump2d single character",
    silent = true,
  },
}

return keys
