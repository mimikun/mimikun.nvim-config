---@type LazySpec
local spec = {
  "3rd/image.nvim",
  --lazy = false,
  --build = false,
  ft = require("plugins.image-nvim.ft"),
  cmd = require("plugins.image-nvim.cmds"),
  event = require("plugins.image-nvim.events"),
  --opts = require("plugins.image-nvim.opts"),
  config = function()
    local image = require("image")
    image.setup(require("plugins.image-nvim.opts"))

    vim.api.nvim_create_user_command("ImageEnable", function()
      image.enable()
    end, {})

    vim.api.nvim_create_user_command("ImageDisable", function()
      image.disable()
    end, {})

    vim.api.nvim_create_user_command("ImageToggle", function()
      if image.is_enabled() then
        image.disable()
      else
        image.enable()
      end
    end, {})
  end,
  --cond = false,
  --enabled = false,
}

return spec
