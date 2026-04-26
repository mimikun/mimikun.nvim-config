---@module 'snacks'

local M = {}

---@type snacks.picker.Action.fn
function M.send(picker)
  local Util = require("sidekick.util")
  Util.deprecate('require("sidekick.cli.snacks").send()', 'require("sidekick.cli.picker.snacks").send()')
  require("sidekick.cli.picker.snacks").send(picker)
end

return M
