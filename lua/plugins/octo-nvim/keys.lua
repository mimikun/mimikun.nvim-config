---@type LazyKeysSpec[]
local keys = {
  --{
  --  -- TODO: it
  --  "<lhs>",
  --  function()
  --    -- TODO: it
  --  end,
  --  mode = "n",
  --  desc = "",
  --  { silent = true },
  --},
  {
    "<leader>oi",
    "<CMD>Octo issue list<CR>",
    desc = "List GitHub Issues",
  },
  {
    "<leader>op",
    "<CMD>Octo pr list<CR>",
    desc = "List GitHub PullRequests",
  },
  {
    "<leader>od",
    "<CMD>Octo discussion list<CR>",
    desc = "List GitHub Discussions",
  },
  {
    "<leader>on",
    "<CMD>Octo notification list<CR>",
    desc = "List GitHub Notifications",
  },
  {
    "<leader>os",
    function()
      require("octo.utils").create_base_search_command({ include_current_repo = true })
    end,
    desc = "Search GitHub",
  },
}

return keys
