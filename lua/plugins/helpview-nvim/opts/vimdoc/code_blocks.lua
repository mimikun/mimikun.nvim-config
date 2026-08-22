-- Configuration for code blocks.
---@type vimdoc.code_blocks
local code_blocks = {
  -- When `false`, code blocks don't get rendered.
  ---@type boolean
  enable = true,

  -- Highlight group for the top & bottom borders.
  ---@type string
  border_hl = "Code",

  -- Highlight group for the language label.
  ---@type string
  --label_hl=

  -- Default line configuration(used for stuff like `diff`).
  ---@type { block_hl: string }
  default = {
    block_hl = "HelpviewCode",
  },

  -- Line configuration when the language is `string`.
  ---@field [string] { block_hl: string }
  ["diff"] = {
    block_hl = function(_, line)
      if line:match("^%s*%+") then
        return "HelpviewPalette4"
      elseif line:match("^%s*%-") then
        return "HelpviewPalette1"
      else
        return "HelpviewCode"
      end
    end,
  },
}

return code_blocks
