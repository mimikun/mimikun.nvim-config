---@type OctoConfigFilePanel
local file_panel = {
  -- changed files panel rows
  ---@type number
  size = 10,

  -- true = nvim-web-devicons
  -- false = disabled
  -- function = custom provider
  ---@type boolean | fun(name: string, ext: string): string?, string?
  icons = function(_name, _ext)
    --return require("mini.icons").get("file", name)
    return true
  end,
}

return file_panel
