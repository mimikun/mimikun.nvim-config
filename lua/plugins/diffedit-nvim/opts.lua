---@type table
local opts = {
  -- Enable treesitter-based code highlighting
  hl_code = true,
  -- Build the highlight group from a capture + language
  hl_group = function(capture, lang)
    return "@" .. capture .. "." .. lang
  end,
}

return opts
