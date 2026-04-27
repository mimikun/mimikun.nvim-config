--local config = require("nvim-surround.config")
--return config.get_selection({ motion = "at" })
--return M.get_selection({ motion = "at" })

---@type user_options
local opts = {
  -- Defines surround keys and behavior
  surrounds = require("plugins.nvim-surround.opts.surrounds"),
  -- Defines aliases
  aliases = require("plugins.nvim-surround.opts.aliases"),
  -- Defines highlight behavior
  highlight = {
    duration = 0,
  },
  -- Defines cursor behavior after a surround action
  move_cursor = "begin",
  -- Defines line indentation behavior
  indent_lines = function(start, stop)
    local b = vim.bo
    -- Only re-indent the selection if a formatter is set up already
    if start < stop and (b.equalprg ~= "" or b.indentexpr ~= "" or b.cindent or b.smartindent or b.lisp) then
      vim.cmd(string.format("silent normal! %dG=%dG", start, stop))
      require("nvim-surround.cache").set_callback("")
    end
  end,
}

return opts
