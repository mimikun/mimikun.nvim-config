-- Preview generation configuration
---@type IWE.Config.Preview
local preview = {
  -- Directory for generated preview files
  ---@type string
  output_dir = vim.fn.expand("~/tmp/preview"),

  -- Directory for temporary files during preview generation
  ---@type string
  temp_dir = vim.fn.expand("/tmp"),

  -- Whether to automatically open generated previews
  ---@type boolean
  auto_open = false,
}

return preview
