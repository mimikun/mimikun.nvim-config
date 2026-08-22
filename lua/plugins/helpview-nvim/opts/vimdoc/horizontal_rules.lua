-- Configuration for horizontal rules.
---@type vimdoc.hr
local horizontal_rules = {
  parts = {
    {
      type = "repeating",
      repeat_amount = function(buffer)
        return math.ceil((vim.bo[buffer].tw - 3) / 2)
      end,

      text = "─",
      hl = {
        "HelpviewGradient1",
        "HelpviewGradient1",
        "HelpviewGradient2",
        "HelpviewGradient2",
        "HelpviewGradient3",
        "HelpviewGradient3",
        "HelpviewGradient4",
        "HelpviewGradient4",
        "HelpviewGradient5",
        "HelpviewGradient5",
        "HelpviewGradient6",
        "HelpviewGradient6",
        "HelpviewGradient7",
        "HelpviewGradient7",
        "HelpviewGradient8",
        "HelpviewGradient8",
        "HelpviewGradient8",
        "HelpviewGradient8",
      },
    },
    {
      type = "text",
      text = " ◈ ",
    },
    {
      type = "repeating",
      repeat_amount = function(buffer)
        return math.floor((vim.bo[buffer].tw - 3) / 2)
      end,
      direction = "right",

      text = "─",
      hl = {
        "HelpviewGradient1",
        "HelpviewGradient1",
        "HelpviewGradient2",
        "HelpviewGradient2",
        "HelpviewGradient3",
        "HelpviewGradient3",
        "HelpviewGradient4",
        "HelpviewGradient4",
        "HelpviewGradient5",
        "HelpviewGradient5",
        "HelpviewGradient6",
        "HelpviewGradient6",
        "HelpviewGradient7",
        "HelpviewGradient7",
        "HelpviewGradient8",
        "HelpviewGradient8",
        "HelpviewGradient8",
        "HelpviewGradient8",
      },
    },
  },
}

return horizontal_rules
--- Configuration for horizontal rules.
---@class vimdoc.hr

--- When `false`, horizontal rules aren't rendered.
---@field enable? boolean

--- Parts for the shown highlight group
---@field parts (hr.text | hr.repeating)[]
