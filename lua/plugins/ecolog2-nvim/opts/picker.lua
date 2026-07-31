-- Picker Configuration (Telescope, fzf-lua, or snacks.nvim)
---@type EcologPickerConfig
local picker = {
  -- Auto-detect if nil
  -- Force picker backend (default: auto-detect)
  ---@type string | "telescope" | "fzf" | "snacks" | nil
  backend = nil,

  -- Picker keymap overrides
  ---@type EcologPickerKeymaps
  keys = {
    -- Copy variable value (default: "<C-y>")
    ---@type string
    copy_value = "<C-y>",

    -- Copy variable name (default: "<C-u>")
    ---@type string
    copy_name = "<C-u>",

    -- Append value at cursor (default: "<C-a>")
    ---@type string
    append_value = "<C-a>",

    -- Append name at cursor (default: "<CR>")
    ---@type string
    append_name = "<CR>",

    -- Go to source file (default: "<C-g>")
    ---@type string
    goto_source = "<C-g>",
  },
}

return picker
