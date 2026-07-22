---@type LazySpec
local spec = {
  "Rtarun3606k/TakaTime",
  lazy = false,
  cmd = require("plugins.takatime.cmds"),
  event = require("plugins.takatime.events"),
  --opts = require("plugins.takatime.opts"),
  config = function()
    local opts = require("plugins.takatime.opts")
    require("taka-time").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
