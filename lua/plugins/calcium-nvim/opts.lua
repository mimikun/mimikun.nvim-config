---@type table
local opts = {
  -- TODO: it
}

local readme = {
  -- default configuration
  notifications = true, -- notify result
  default_mode = "append", -- or `replace` the expression
  scratchpad = {
    border = "rounded", -- floating window border style (:help 'winborder')
    virtual_text = {
      format = "= %s", -- virtual text format
      highlight_group = "Comment", -- virtual text highlight group
    },
    result_variable = "ans", -- name of the variable for the last computation result
  },
}
local defaults = {
  notifications = true,
  default_mode = "append",
  scratchpad = {
    border = "rounded",
    virtual_text = {
      format = "= %s",
      highlight_group = "Comment",
    },
    result_variable = "ans",
  },
}

return opts
