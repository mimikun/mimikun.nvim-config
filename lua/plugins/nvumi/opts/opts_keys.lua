---@type nvumi.Keys
local opts_keys = {
  -- run/refresh calculations
  ---@type string
  run = "<CR>",

  -- reset buffer
  ---@type string
  reset = "R",

  -- yank output of current line
  ---@type string
  yank = "<leader>y",

  -- yank all outputs
  ---@type string
  yank_all = "<leader>Y",
}

return opts_keys
