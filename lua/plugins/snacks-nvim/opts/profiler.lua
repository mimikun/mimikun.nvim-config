-- Available, not mapped yet:
---@type snacks.profiler.Config
local profiler = {
  autocmds = true,

  ---@type string
  runtime = vim.env.VIMRUNTIME,

  -- thresholds for buttons to be shown as info, warn or error
  -- value is a tuple of [warn, error]
  thresholds = {
    time = {
      2,
      10,
    },
    pct = {
      10,
      20,
    },
    count = {
      10,
      100,
    },
  },

  on_stop = {
    -- highlight entries after stopping the profiler
    highlights = true,

    -- show a picker after stopping the profiler (uses the `on_stop` preset)
    pick = true,
  },

  ---@type snacks.profiler.Highlights
  highlights = {
    -- only highlight entries with time > min_time (in ms)
    min_time = 0,

    -- time in ms for the darkest shade
    max_shade = 20,

    badges = {
      "time",
      "pct",
      "count",
      "trace",
    },

    align = 80,
  },

  pick = {
    ---@type snacks.profiler.Picker
    picker = "snacks",

    ---@type snacks.profiler.Badge.type[]
    badges = {
      "time",
      "count",
      "name",
    },

    ---@type snacks.profiler.Highlights
    preview = {
      badges = {
        "time",
        "pct",
        "count",
      },
      align = "right",
    },
  },

  startup = {
    -- stop profiler on this event.
    -- Defaults to `VimEnter`
    event = "VimEnter",

    -- stop the profiler **after** the event.
    -- When false it stops **at** the event
    after = true,

    -- pattern to match for the autocmd
    pattern = nil,

    -- show a picker after starting the profiler (uses the `startup` preset)
    pick = true,
  },

  ---@type table<string, snacks.profiler.Pick | fun():snacks.profiler.Pick?>
  presets = {
    startup = {
      min_time = 1,
      sort = false,
    },
    on_stop = {},
    filter_by_plugin = function()
      return {
        filter = {
          def_plugin = vim.fn.input("Filter by plugin: "),
        },
      }
    end,
  },

  ---@type string[]
  globals = {
    --"vim",
    --"vim.api",
    --"vim.keymap",
    --"Snacks.dashboard.Dashboard",
  },

  -- filter modules by pattern.
  -- longest patterns are matched first
  filter_mod = {
    -- default value for unmatched patterns
    default = true,
    ["^vim%."] = false,
    ["mason-core.functional"] = false,
    ["mason-core.functional.data"] = false,
    ["mason-core.optional"] = false,
    ["which-key.state"] = false,
  },

  filter_fn = {
    default = true,
    ["^.*%._[^%.]*$"] = false,
    ["trouble.filter.is"] = false,
    ["trouble.item.__index"] = false,
    ["which-key.node.__index"] = false,
    ["smear_cursor.draw.wo"] = false,
    ["^ibl%.utils%."] = false,
  },

  icons = {
    time = " ",
    pct = " ",
    count = " ",
    require = "󰋺 ",
    modname = "󰆼 ",
    plugin = " ",
    autocmd = "⚡",
    file = " ",
    fn = "󰊕 ",
    status = "󰈸 ",
  },
}

return profiler
