-- Keys in what modes are disabled.
---@type table
local disabled_keys = {
  ["<Up>"] = { "", "i" },
  ["<Down>"] = { "", "i" },
  ["<Left>"] = { "", "i" },
  ["<Right>"] = { "", "i" },
  -- NOTE: Examples

  --["<Up>"] = false, -- Allow <Up> key
  --["<Space>"] = { "n", "x" }, -- Disable <Space> key in normal and visual mode
}

return disabled_keys
