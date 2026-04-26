---@field icon? string|{ enabled: string, disabled: string }
---@field color? string|{ enabled: string, disabled: string }
---@field wk_desc? string|{ enabled: string, disabled: string }
---@field map? fun(mode: string|string[], lhs: string, rhs: string|fun(), opts?: vim.keymap.set.Opts)
---@field which_key? boolean
---@field notify? boolean|fun(state:boolean, opts: snacks.toggle.Opts)

---@type snacks.toggle.Config
local toggle = {
  -- keymap.set function to use
  map = vim.keymap.set,
  -- integrate with which-key to show enabled/disabled icons and colors
  which_key = true,
  -- show a notification when toggling
  notify = true,
  -- icons for enabled/disabled states
  icon = {
    enabled = " ",
    disabled = " ",
  },
  -- colors for enabled/disabled states
  color = {
    enabled = "green",
    disabled = "yellow",
  },
  wk_desc = {
    enabled = "Disable ",
    disabled = "Enable ",
  },
}

return toggle
