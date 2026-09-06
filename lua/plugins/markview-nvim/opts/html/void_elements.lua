-- Configuration for void elements.
---@type markview.config.html.void_elements
local void_elements = {
  -- Enable rendering of container elements?
  ---@type boolean
  enable = true,

  -- Configuration for `<string></string>`.
  ---@type markview.config.html.container_elements.opts
  ["^hr$"] = {
    ---@field on_node table | fun(tag: markview.config.html.void_elements): table Extmark configuration to use on the element.
    on_node = {
      conceal = "",

      virt_text_pos = "inline",
      virt_text = {
        { "─", "MarkviewGradient2" },
        { "─", "MarkviewGradient3" },
        { "─", "MarkviewGradient4" },
        { "─", "MarkviewGradient5" },
        { " ◉ ", "MarkviewGradient9" },
        { "─", "MarkviewGradient5" },
        { "─", "MarkviewGradient4" },
        { "─", "MarkviewGradient3" },
        { "─", "MarkviewGradient2" },
      },
    },
  },
  ["^br$"] = {
    on_node = {
      conceal = "",

      virt_text_pos = "inline",
      virt_text = {
        { "󱞦", "Comment" },
      },
    },
  },
}

return void_elements
