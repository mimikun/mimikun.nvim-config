-- Available, not mapped yet:
-- which-key-nvim integrated toggles
---@type snacks.toggle.Config
local toggle = {
  -- keymap.set function to use
  ---@type fun(mode: string | string[], lhs: string, rhs: string | fun(), opts?: vim.keymap.set.Opts)
  map = vim.keymap.set,

  -- integrate with which-key to show enabled/disabled icons and colors
  ---@type boolean
  which_key = true,

  -- show a notification when toggling
  ---@type boolean | fun(state:boolean, opts: snacks.toggle.Opts)
  notify = true,

  -- icons for enabled/disabled states
  ---@type string | { enabled: string, disabled: string }
  icon = {
    enabled = " ",
    disabled = " ",
  },

  -- colors for enabled/disabled states
  ---@type string | { enabled: string, disabled: string }
  color = {
    enabled = "green",
    disabled = "yellow",
  },

  ---@type string | { enabled: string, disabled: string }
  wk_desc = {
    enabled = "Disable ",
    disabled = "Enable ",
  },
}

return toggle
