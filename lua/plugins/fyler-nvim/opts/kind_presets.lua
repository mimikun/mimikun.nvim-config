-- Per-kind preset overrides.
-- Each preset can contain mappings, buf_opts, win_opts,
-- and any window layout fields (width, height, border, etc.).
---@type table<string, fyler.KindPresetConfig>
local kind_presets = {
  floating = {
    -- Border style (see: :h winborder)
    border = "single",

    -- Size of buffer:
    -- - string with '%' for relative (e.g. '70%')
    -- - number for absolute
    height = "80%",
    mappings = {
      n = {
        ["<CR>"] = {
          action = "select",
          args = {
            close = true,
          },
        },
      },
    },
    width = "60%",
    -- Horizontal alignment: 'start' | 'center' | 'end'
    col = "center",
    -- Vertical alignment: 'start' | 'center' | 'end'
    row = "center",
  },
  replace = {
    mappings = {
      n = {
        ["<CR>"] = {
          action = "select",
          args = {
            close = true,
          },
        },
      },
    },
  },
  split_above = {
    height = "50%",
  },
  split_above_all = {
    height = "50%",
  },
  split_below = {
    height = "50%",
  },
  split_below_all = {
    height = "50%",
  },
  split_left = {
    width = "25%",
  },
  split_left_most = {
    width = "25%",
  },
  split_right = {
    width = "25%",
  },
  split_right_most = {
    width = "25%",
  },
}

return kind_presets
