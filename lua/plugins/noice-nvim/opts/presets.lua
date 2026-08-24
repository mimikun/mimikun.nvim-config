---@type NoicePresets
local presets = {
  -- use a classic bottom cmdline for search
  bottom_search = false,

  -- position the cmdline and popupmenu together
  command_palette = true,

  -- long messages will be sent to a split
  long_message_to_split = true,

  -- enables an input dialog for inc-rename.nvim
  inc_rename = false,

  -- add a border to hover docs and signature help
  lsp_doc_border = false,

  -- send the output of a command you executed in the cmdline to a split
  cmdline_output_to_split = false,
}

return presets
