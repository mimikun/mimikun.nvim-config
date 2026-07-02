---@type LazySpec
local spec = {
    "Interlude-Software/lazyissues",
    --lazy = false,
    cmd = require("plugins.lazyissues.cmds"),
    keys = require("plugins.lazyissues.keys"),
    event = require("plugins.lazyissues.events"),
    dependencies = require("plugins.lazyissues.dependencies"),
    --opts = require("plugins.lazyissues.opts"),
    config = function()
        local opts = require("plugins.lazyissues.opts")
        require("lazyissues").setup(opts)
    end,
    --cond = false,
    --enabled = false,
}

return spec
