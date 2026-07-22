---@type table
local opts = {
  -- notify result
  notifications = true,

  -- or `replace` the expression
  default_mode = "append",

  scratchpad = {
    -- floating window border style (:help 'winborder')
    border = "rounded",

    virtual_text = {
      -- virtual text format
      format = "= %s",

      -- virtual text highlight group
      highlight_group = "Comment",
    },

    -- name of the variable for the last computation result
    result_variable = "ans",
  },
}

return opts
