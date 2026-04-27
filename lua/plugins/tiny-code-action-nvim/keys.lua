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
    "<leader>ca",
    function()
      require("tiny-code-action").code_action()
    end,
    mode = { "n", "x" },
    desc = "",
    { noremap = true, silent = true },
  },
}

return keys
