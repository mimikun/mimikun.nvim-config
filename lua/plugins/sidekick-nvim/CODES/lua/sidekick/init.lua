local M = {}

---@param opts? sidekick.Config
function M.setup(opts)
  require("sidekick.config").setup(opts)
end

function M.clear()
  require("sidekick.nes").clear()
end

--- Jump to or apply the next edit, if any
---@return boolean true if jumped or applied
function M.nes_jump_or_apply()
  local Nes = require("sidekick.nes")
  if Nes.have() and (Nes.jump() or Nes.apply()) then
    return true
  end
  return false
end

return M
