---@type blink.cmp.KeymapConfig
local keymap = {
  -- 'enter' accepts with <CR> instead of <C-y>:
  --   <C-space> show / show_documentation / hide_documentation (remapped below)
  --   <C-e>     cancel
  --   <CR>      accept
  --   <C-n>/<C-p>, <Up>/<Down>  select_next / select_prev
  --   <C-b>/<C-f>               scroll_documentation_up / down
  --   <C-k>                     show_signature / hide_signature
  -- Other presets: 'default', 'super-tab', 'none'
  ---@type blink.cmp.KeymapPreset
  preset = "enter",

  -- The preset only maps <Tab> to snippet navigation, so add selection in front
  -- of it: cycle the menu with <Tab>, then confirm with <CR>.
  -- Each command runs in order until one of them handles the key, so <Tab>
  -- still jumps between snippet placeholders when the menu is closed, and still
  -- falls back to a literal tab when neither applies.
  ---@type blink.cmp.KeymapCommand[]
  ["<Tab>"] = {
    "select_next",
    "snippet_forward",
    "fallback",
  },

  ---@type blink.cmp.KeymapCommand[]
  ["<S-Tab>"] = {
    "select_prev",
    "snippet_backward",
    "fallback",
  },

  -- <C-space> never reaches Neovim on this machine: PowerToys Run claims it at
  -- the Windows level, above WSL. Move the same three commands to <C-l>, which
  -- has no default insert mode behaviour outside of ins-completion.
  ---@type blink.cmp.KeymapCommand[]
  ["<C-l>"] = {
    -- Opens the menu, then toggles the documentation window
    "show",
    "show_documentation",
    "hide_documentation",
  },

  -- Drop the preset's binding so it does not sit there looking usable
  ---@type false
  ["<C-space>"] = false,
}

return keymap
