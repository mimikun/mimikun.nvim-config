---@type blink.cmp.CmdlineConfig
local cmdline = {
  -- Completion in the cmdline.
  -- NOTE: tiny-cmdline.nvim aligns its floating window to this menu through
  -- `menu_col_offset` (see plugins/tiny-cmdline-nvim/opts.lua).
  ---@type boolean
  enabled = true,

  ---@type blink.cmp.KeymapConfig
  keymap = {
    -- 'cmdline' mirrors the built-in cmdline completion:
    --   <Tab>/<S-Tab> show_and_insert_or_accept_single / select_prev
    --   <C-e> cancel, <C-y> select_accept_and_enter
    ---@type blink.cmp.KeymapPreset
    preset = "cmdline",
  },
}

return cmdline
