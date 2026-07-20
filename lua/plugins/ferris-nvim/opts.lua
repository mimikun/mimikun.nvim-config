---@type table
local opts = {
  -- If true, will automatically create commands for each LSP method
  ---@type boolean
  create_commands = true,

  -- Handler for URL's (used for opening documentation)
  ---@type string | function(string)
  url_handler = function(_string)
    return "xdg-open"
  end,
}

return opts
