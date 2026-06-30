---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>Rs",
    -- TODO: it
    --function()
    --end,
    mode = "n",
    desc = "Send request",
    --expr = true,
    --noremap = true,
    silent = true,
  },
  {
    "<leader>Ra",
    -- TODO: it
    --function()
    --end,
    mode = "n",
    desc = "Send all requests",
    --expr = true,
    --noremap = true,
    silent = true,
  },
  {
    "<leader>Rb",
    -- TODO: it
    --function()
    --end,
    mode = "n",
    desc = "Open scratchpad",
    --expr = true,
    --noremap = true,
    silent = true,
  },
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
}

return keys
