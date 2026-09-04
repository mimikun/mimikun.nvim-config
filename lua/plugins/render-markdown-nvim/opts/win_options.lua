---@type render.md.window.Configs | table<string, render.md.window.UserConfig>
local win_options = {
  -- Window options to use that change between rendered and raw view.

  -- @see :h 'conceallevel'
  conceallevel = {
    -- Used when not being rendered, get user setting.
    ---@type render.md.option.Value
    default = vim.o.conceallevel,

    -- Used when being rendered, concealed text is completely hidden.
    ---@type render.md.option.Value
    rendered = 3,
  },

  -- @see :h 'concealcursor'
  concealcursor = {
    -- Used when not being rendered, get user setting.
    default = vim.o.concealcursor,

    -- Used when being rendered, show concealed text in all modes.
    rendered = "",
  },
}

return win_options
