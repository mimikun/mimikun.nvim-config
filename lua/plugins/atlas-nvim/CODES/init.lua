local M = {}

local logger = require("atlas.core.logger")

---@param opts AtlasConfig|nil
function M.setup(opts)
  require("atlas.config").setup(opts)
  require("atlas.core.logger").clear()
end

local function bootstrap_common()
  require("atlas.ui.shared.highlights").setup()
  require("atlas.ui.components.footer").setup()

  require("atlas.ui.popups.help").register_command(
    "Commands",
    {},
    { index = 999, buffer = require("atlas.ui.layout").buf_id("main") }
  )
end
