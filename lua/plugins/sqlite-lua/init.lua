---@type LazySpec
local spec = {
  "kkharji/sqlite.lua",
  --lazy = false,
  event = require("plugins.sqlite-lua.events"),
  init = function()
    -- TODO: it

    --vim.g.sqlite_clib_path = "path/to/sqlite3.dll"
  end,
  --cond = false,
  --enabled = false,
}

return spec
