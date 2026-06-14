---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>e",
    function()
      require("fyler").open({
        --kind = "split_left_most",
      })
    end,
    mode = "n",
    desc = "Fyler.nvim - Open",
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
