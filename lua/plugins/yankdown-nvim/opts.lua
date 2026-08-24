---@type table
local opts = {
  -- override p/P in Markdown buffers
  auto_intercept = false,

  -- warn once on paste fallback/conversion failure
  notify = true,

  -- cache dependency check on first Markdown paste
  check = "lazy",
}

return opts
