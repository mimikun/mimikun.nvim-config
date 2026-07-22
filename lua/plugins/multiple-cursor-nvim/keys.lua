---@type LazyKeysSpec[]
local keys = {
  {
    "<C-n>",
    function()
      require("multiple-cursor").start_or_add_next()
    end,
    mode = {
      "n",
    },
    desc = "Start multi-cursor mode on word under cursor",
    silent = true,
  },
  {
    "<C-x>",
    mode = {
      "n",
    },
    desc = "MC: Skip current match",
    silent = true,
  },
  {
    "<C-j>",
    mode = {
      "n",
    },
    desc = "MC: Go to next match",
    silent = true,
  },
  {
    "<C-k>",
    mode = {
      "n",
    },
    desc = "MC: Go to previous match",
    silent = true,
  },
  {
    "<C-a>",
    --function()
    --  if state.is_active() then
    --    state.select_all()
    --    ui.update_highlights()
    --    ui.notify("Selected all matches", vim.log.levels.INFO)
    --  else
    --    ui.notify("Start multi-cursor mode first", vim.log.levels.WARN)
    --  end
    --end,
    mode = {
      "n",
    },
    desc = "MC: Select all matches",
    silent = true,
  },
  {
    "<Esc>",
    function()
      require("multiple-cursor").exit_mode()
    end,
    mode = {
      "n",
    },
    desc = "Clear all cursors and exit multi-cursor mode",
    silent = true,
  },
}

return keys
