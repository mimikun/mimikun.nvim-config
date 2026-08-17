-- Full inventory of snacks.nvim modules (v2.31.0).
--
-- IMPORTANT: the `enabled` flag is NOT honoured by every module. `snacks.setup()`
-- only consults `config.<mod>.enabled` for the modules it wires up itself
-- (see `snacks/init.lua`: the `events` table plus the `image` / `statuscolumn` /
-- `notifier` special cases). Those are listed in the first group below.
-- Every other module is on-demand -- it does nothing until `Snacks.<mod>()` is
-- called -- so writing `enabled = false` there is inert. They are listed in the
-- second group with config only, and are kept dormant by simply not mapping a key.
--
-- Note: `snacks.setup()` defaults `enabled` to `true` for any key present in
-- these opts, so `enabled = false` has to be spelled out to opt out.

---@type table
local opts = {
  -- ==========================================================================
  -- Group A: setup-driven. `enabled` is honoured here.
  -- ==========================================================================

  bigfile = { enabled = true },
  quickfile = { enabled = true },
  input = { enabled = true }, -- better `vim.ui.input`
  scope = { enabled = true }, -- scope text objects / jumping

  -- Disabled: another plugin in this config already owns the feature.
  dashboard = { enabled = false }, -- alpha-nvim
  explorer = { enabled = false }, -- oil-nvim / fyler-nvim / triptych-nvim / otree-nvim
  image = { enabled = false }, -- image-nvim
  indent = { enabled = false }, -- indent-blankline-nvim / virt-column-nvim
  notifier = { enabled = false }, -- nvim-notify
  scroll = { enabled = false }, -- smear-cursor-nvim
  statuscolumn = { enabled = false }, -- statuscol-nvim
  words = { enabled = false }, -- vim-illuminate

  -- On trial as the general-purpose picker, to be compared against telescope
  -- before settling. Reached through the `<leader>F` keymaps in `keys.lua`.
  --
  -- `ui_select = false` is deliberate: telescope is already in the tree (pulled
  -- in as a dependency of ascii-nvim, chezmoi-nvim, github-actions-nvim,
  -- homeassistant-nvim, iwe-nvim, ...) and telescope-ui-select.nvim already
  -- owns `vim.ui.select`. Leaving this at its default would have both plugins
  -- assign it, with the winner decided by load order. Keep the trial to
  -- picker-vs-picker and leave `vim.ui.select` alone.
  picker = { enabled = true, ui_select = false },

  -- ==========================================================================
  -- Group B: on-demand. `enabled` is never read -- do not rely on it.
  -- Left at defaults; reachable only through keys.lua or an explicit call.
  -- ==========================================================================

  -- Decided against: another plugin already owns the feature and stays the one
  -- we use. Note that `enabled = false` would be inert here (see the header),
  -- so these are kept dormant purely by never mapping a key or calling them.
  --   `zen`      -> zen-mode-nvim
  --   `terminal` -> tabterm-nvim
  -- Both entries are kept so this file stays a full inventory; do not add
  -- keymaps for them.
  dim = {}, -- twilight-nvim
  terminal = {}, -- decided against, see above
  zen = {}, -- decided against, see above

  -- Already mapped in keys.lua:
  gitbrowse = {},
  lazygit = {},
  scratch = {},

  -- Available, not mapped yet:
  gh = {}, -- always registers the `gh://*` BufReadCmd, regardless of this table
  profiler = {},
  toggle = {}, -- which-key-nvim integrated toggles

  -- Libraries used by the modules above (and usable directly):
  -- `animate` is gated by `vim.g.snacks_animate`, not by this table.
  animate = {},
  layout = {},
  win = {},
}

-- Modules with no config surface at all, hence no key here:
--   bufdelete, debug, git, keymap, notify, rename, util

return opts
