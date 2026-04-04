---@type PaintOptions
local opts = {
  ---@type PaintHighlight[]
  highlights = {
    {
      -- filter can be a table of buffer options that should match,
      -- or a function called with buf as param that should return true.
      -- The example below will paint @something in comments with Constant
      ---@type PaintFilter
      filter = {
        filetype = "lua",
      },
      ---@type string
      pattern = "%s*%-%-%-%s*(@%w+)",
      ---@type string
      hl = "Constant",
    },
  },
}

return opts
