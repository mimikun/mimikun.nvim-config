---@type ReviewExportConfig
local export = {
  -- Number of context lines to include around commented line
  ---@type number
  context_lines = 3,

  -- User delivery callback
  ---@type fun(content: string, comments: table[]): boolean | nil
  on_export = nil,
  --on_export = function(content, comments)
  --  local path = vim.fn.stdpath("state") .. "/review-latest.md"
  --  if vim.fn.writefile(vim.split(content, "\n"), path) ~= 0 then
  --    return false
  --  end
  --  vim.system({ "my-agent", "--file", path, "--count", tostring(#comments) })
  --  return true
  --end,
}

return export
