---@type blink.cmp.KeymapConfig
local keymap = {
  -- 'default' mirrors the built-in completion keymaps:
  --   <C-space> show / show_documentation / hide_documentation
  --   <C-e>     cancel
  --   <C-y>     select_and_accept
  --   <C-n>/<C-p>, <Up>/<Down>  select_next / select_prev
  --   <C-b>/<C-f>               scroll_documentation_up / down
  --   <Tab>/<S-Tab>             snippet_forward / snippet_backward
  --   <C-k>                     show_signature / hide_signature
  -- Other presets: 'super-tab', 'enter', 'none'
  ---@type blink.cmp.KeymapPreset
  preset = "default",
}

return keymap
