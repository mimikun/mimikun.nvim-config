-- :TSStatus - one screen answering "is every tree-sitter parser installed and
-- current?", which nvim-treesitter itself only answers through its log.
--
-- Deliberately read-only, and deliberately free of any dependency on the rest
-- of this config: it talks to nvim-treesitter through its public API only, so
-- moving this directory into a standalone plugin is a copy, not a rewrite.

local M = {}

---Install the progress hooks. Call it as early as possible -- before the first
---install starts -- if the live view should cover the startup run too.
---@return boolean ok
function M.setup()
  return require("tsstatus.track").setup()
end

function M.open()
  require("tsstatus.ui").open()
end

---@return TSStatusReport
function M.report()
  return require("tsstatus.data").collect()
end

return M
