-- Full inventory of snacks.nvim modules (v2.31.0).

-- IMPORTANT: the `enabled` flag is NOT honoured by every module.
-- `snacks.setup()` only consults `config.<mod>.enabled` for the modules it wires up itself
-- (see `snacks/init.lua`: the `events` table plus the `image` / `statuscolumn` / `notifier` special cases).
-- Those are listed in the first group below.
-- Every other module is on-demand it does nothing until `Snacks.<mod>()` is called so writing `enabled = false` there is inert.
-- They are listed in the second group with config only, and are kept dormant by simply not mapping a key.

-- Note: `snacks.setup()` defaults `enabled` to `true` for any key present in these opts, so `enabled = false` has to be spelled out to opt out.

---@type snacks.Config
local opts = {
  -- Libraries used by the modules above (and usable directly):
  -- `animate` is gated by `vim.g.snacks_animate`, not by this table.
  ---@type snacks.animate.Config
  animate = require("plugins.snacks-nvim.opts.animate"),

  ---@type snacks.bigfile.Config
  bigfile = require("plugins.snacks-nvim.opts.bigfile"),

  -- Disabled: another plugin in this config already owns the feature.
  -- alpha-nvim
  ---@type snacks.dashboard.Config
  dashboard = require("plugins.snacks-nvim.opts.dashboard"),

  -- decided against, see above
  -- twilight-nvim
  ---@type  snacks.dim.Config
  dim = require("plugins.snacks-nvim.opts.dim"),

  -- Disabled: another plugin in this config already owns the feature.
  -- oil-nvim / fyler-nvim / triptych-nvim / otree-nvim
  ---@type snacks.explorer.Config
  explorer = require("plugins.snacks-nvim.opts.explorer"),

  -- Available, not mapped yet:
  -- always registers the `gh://*` BufReadCmd, regardless of this table
  ---@type snacks.gh.Config
  gh = require("plugins.snacks-nvim.opts.gh"),

  -- Already mapped in keys.lua:
  ---@type snacks.gitbrowse.Config
  gitbrowse = require("plugins.snacks-nvim.opts.gitbrowse"),

  -- Disabled: another plugin in this config already owns the feature.
  -- image-nvim
  ---@type snacks.image.Config | {}
  image = require("plugins.snacks-nvim.opts.image"),

  -- Disabled: another plugin in this config already owns the feature.
  -- indent-blankline-nvim / virt-column-nvim
  ---@type snacks.indent.Config
  indent = require("plugins.snacks-nvim.opts.indent"),

  -- better `vim.ui.input`
  ---@type snacks.input.Config
  input = require("plugins.snacks-nvim.opts.input"),

  -- Available, not mapped yet:
  -- Libraries used by the modules above (and usable directly):
  ---@type snacks.layout.Config
  layout = require("plugins.snacks-nvim.opts.layout"),

  ---@type snacks.lazygit.Config
  lazygit = require("plugins.snacks-nvim.opts.lazygit"),

  ---@type snacks.notifier.Config
  -- Disabled: another plugin in this config already owns the feature.
  -- nvim-notify
  notifier = require("plugins.snacks-nvim.opts.notifier"),

  -- On trial as the general-purpose picker, to be compared against telescope before settling.
  -- Reached through the `<leader>F` keymaps in `keys.lua`.

  -- `ui_select = false` is deliberate:
  -- telescope is already in the tree (pulled in as a dependency of ascii-nvim, chezmoi-nvim, github-actions-nvim, homeassistant-nvim, iwe-nvim, ...) and telescope-ui-select.nvim already owns `vim.ui.select`.
  -- Leaving this at its default would have both plugins assign it, with the winner decided by load order.
  -- Keep the trial to picker-vs-picker and leave `vim.ui.select` alone.
  ---@type snacks.picker.Config
  picker = require("plugins.snacks-nvim.opts.picker"),

  -- Available, not mapped yet:
  ---@type snacks.profiler.Config
  profiler = require("plugins.snacks-nvim.opts.profiler"),

  ---@type snacks.quickfile.Config
  quickfile = require("plugins.snacks-nvim.opts.quickfile"),

  -- scope text objects / jumping
  ---@type snacks.scope.Config
  scope = require("plugins.snacks-nvim.opts.scope"),

  ---@type snacks.scratch.Config
  scratch = require("plugins.snacks-nvim.opts.scratch"),

  -- Disabled: another plugin in this config already owns the feature.
  -- smear-cursor-nvim
  ---@type snacks.scroll.Config
  scroll = require("plugins.snacks-nvim.opts.scroll"),

  -- Disabled: another plugin in this config already owns the feature.
  -- statuscol-nvim
  ---@type snacks.statuscolumn.Config
  statuscolumn = require("plugins.snacks-nvim.opts.statuscolumn"),

  -- decided against, see above
  -- tabterm-nvim
  ---@type snacks.terminal.Config
  terminal = require("plugins.snacks-nvim.opts.terminal"),

  -- Available, not mapped yet:
  -- which-key-nvim integrated toggles
  ---@type snacks.toggle.Config
  toggle = require("plugins.snacks-nvim.opts.toggle"),

  -- Available, not mapped yet:
  -- Libraries used by the modules above (and usable directly):
  ---@type snacks.win.Config
  win = require("plugins.snacks-nvim.opts.win"),

  -- Disabled: another plugin in this config already owns the feature.
  -- vim-illuminate
  ---@type snacks.words.Config
  words = require("plugins.snacks-nvim.opts.words"),

  -- decided against, see above
  -- zen-mode-nvim
  ---@type snacks.zen.Config
  zen = require("plugins.snacks-nvim.opts.zen"),

  -- Modules with no config surface at all, hence no key here:
  --   bufdelete, debug, git, keymap, notify, rename, util
}

return opts
