---@type table
local opts = {
  fallow_cmd = "fallow",

  -- extra CLI args forwarded verbatim
  fallow_args = {
    --it
  },

  -- Which analyses to run.
  -- Remove entries to skip them entirely.
  -- "health" automatically adds --score --hotspots --targets to fallow.
  analyses = {
    "dead-code",
    "dupes",
    "health",
  },

  window = {
    ---@type string | "bottom" | "top" | "left" | "right"
    position = "right",

    size = 0.5,
  },

  -- Max items shown per category before a "N more…" expand row appears.
  -- Press <Tab> or <CR> on the "more" row to show all.
  max_items = 30,

  -- Silently re-run fallow after saving a JS/TS file (background, no loading flash).
  auto_refresh = false,

  -- Inline diagnostics in open buffers (like LSP hints)
  diagnostics = {
    enabled = true,
  },

  statusline = {
    -- change to " " for Nerd Font icon
    prefix = "vallow ",
  },

  keymaps = {
    close = "q",
    jump = "<CR>",
    refresh = "r",

    -- unset by default; za/zo/zc/zR/zM always work
    toggle_fold = nil,

    next_section = "]c",
    prev_section = "[c",
    next_tab = "L",
    prev_tab = "H",
    filter = "f",
    clear_filter = "F",
    pick = "gf",
  },

  sections = require("plugins.vallow-nvim.opts.sections"),

  categories = require("plugins.vallow-nvim.opts.categories"),
}

return opts
