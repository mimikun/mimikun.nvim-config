---@type LazyKeysSpec[]
local keys = {
  {
    -- Label-first jump to word starts: the 2-hop jump that flash.nvim used
    -- to provide on <leader>lh. <leader>l now belongs to leap.nvim, so
    -- jump2d gets its own <leader>j namespace.
    --
    -- Uses the <Cmd> form rather than a Lua function because that is what
    -- upstream does for operator-pending mode, where a plain function
    -- breaks dot-repeat (see CODES lua/mini/jump2d.lua, neovim/neovim#23406).
    "<leader>jj",
    "<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<CR>",
    mode = {
      "n",
      "x",
      "o",
    },
    desc = "Jump2d word start",
    silent = true,
  },
}

return keys
