---@type LazySpec
local spec = {
  "NicholasZolton/neoink-showcase",
  --lazy = false,
  -- needs Bun; compiles dist/host
  build = "bun install && bun run build",
  cmd = require("plugins.neoink-showcase.cmds"),
  event = require("plugins.neoink-showcase.events"),
  --cond = false,
  --enabled = false,
}

return spec
