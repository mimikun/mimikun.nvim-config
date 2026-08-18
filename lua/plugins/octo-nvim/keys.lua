---@type LazyKeysSpec[]
local keys = {
  --{
  --  -- TODO: it
  --  "<lhs>",
  --  function()
  --    -- TODO: it
  --  end,
  --  mode = {
  --    "n",
  --    -- TODO: it
  --    --"x",
  --    --"v",
  --  },
  --  desc = "",
  --  -- TODO: it
  --  --expr = true,
  --  --noremap = true,
  --  silent = true,
  --},
  {
    "<leader>oi",
    "<CMD>Octo issue list<CR>",
    desc = "List GitHub Issues",
    silent = true,
  },
  {
    "<leader>op",
    "<CMD>Octo pr list<CR>",
    desc = "List GitHub PullRequests",
    silent = true,
  },
  {
    "<leader>od",
    "<CMD>Octo discussion list<CR>",
    desc = "List GitHub Discussions",
    silent = true,
  },
  {
    "<leader>on",
    "<CMD>Octo notification list<CR>",
    desc = "List GitHub Notifications",
    silent = true,
  },
  {
    "<leader>os",
    function()
      require("octo.utils").create_base_search_command({
        include_current_repo = true,
      })
    end,
    desc = "Search GitHub",
    silent = true,
  },
}

return keys
