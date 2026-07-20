---@type LspEndhints.config
local opts = {
  autoEnableHints = true,
  icons = {
    type = "󰜁 ",
    parameter = "󰏪 ",
    -- hint kind not defined in official LSP spec
    offspec = " ",

    -- hint kind is nil
    unknown = " ",
  },
  label = {
    truncateAtChars = 20,
    padding = 1,
    marginLeft = 0,
    sameKindSeparator = ", ",
  },
  extmark = {
    priority = 50,
  },
  -- Function that overrides how hints are displayed.
  -- expects as output a table for `virt_text` from `nvim_buf_set_extmark`,
  -- that is a table of string tuples (text & highlight group)
  -- To use filetype-specific formatting, get the filetype via
  -- `vim.bo[bufnr].filetype`, to conditionally use the default formatting
  -- function, use `defaultHintFormatFunc(hints)`.
  ---@type function(hints: {label: string, col: number, kind: string}[], bufnr: number, defaultHintFormatFunc: func): {[1]: string, [2]: string}[]
  hintFormatFunc = nil,
}

return opts
