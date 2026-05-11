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
  --  --expr = true,
  --  --noremap = true,
  --  silent = true,
  --},
  {
    "<Leader>m",
    --function()
    -- TODO: it
    "<cmd>MCstart<cr>",
    --end,
    mode = { "v", "n" },
    desc = "Create a selection for selected text or word under the cursor",
    silent = true,
  },
}

return keys
