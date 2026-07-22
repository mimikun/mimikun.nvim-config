---@type table
local options = {
  -- force installation of already installed parsers
  ---@type boolean
  force = false,

  -- generate `parser.c` from `grammar.json` or `grammar.js` before compiling.
  ---@type boolean
  generate = false,

  -- limit parallel tasks (useful in combination with {generate} on memory-limited systems).
  ---@type integer
  max_jobs = 4,

  -- print summary of successful and total operations for multiple languages.
  ---@type boolean
  summary = false,
}

return options
