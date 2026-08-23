local picker_buffer = {
  "buffer",
  opts = {
    -- Enable/Disable hotkeys for quick selection of actions
    hotkeys = false,

    -- Modes for generating hotkeys
    -- can also be a function(titles, used_hotkeys) returning a list of hotkey strings
    ---@type string | "sequential" | "text_based" | "text_diff_based" | function(titles, used_hotkeys)
    hotkeys_mode = function(_titles, _used_hotkeys)
      --local t = {}
      --for i = 1, #titles do
      --  t[i] = tostring(i)
      --end
      --return t
      return "text_diff_based"
    end,

    -- Enable or disable automatic preview
    auto_preview = false,

    -- Automatically accept the selected action (with hotkeys)
    auto_accept = false,

    -- Position of the picker window
    position = "cursor",

    -- Border style for picker and preview windows
    ---@type string | "single" | nil
    winborder = nil,

    conceallevel = 1,

    keymaps = {
      -- Key to show preview
      preview = "K",

      -- Keys to close the window (can be string or table)
      close = {
        "q",
        "<Esc>",
      },

      -- Keys to select action (can be string or table)
      select = "<CR>",

      back = "<Backspace>",

      -- Keys to return from preview to main window (can be string or table)
      preview_close = {
        "q",
        "<Esc>",
      },
    },

    custom_keys = {
      {
        key = "m",
        pattern = "Fill match arms",
      },

      {
        key = "m",
        pattern = "Consider making this binding mutable: mut",
      },

      -- Lua pattern matching
      {
        key = "r",
        pattern = "Rename.*",
      },

      {
        key = "e",
        pattern = "Extract Method",
      },
    },

    ---@type string | "▶ " | " └",
    group_icon = "▶ ",
  },
}

local picker_telescope = {
  "telescope",
  opts = {
    layout_strategy = "vertical",
    layout_config = {
      width = 0.7,
      height = 0.9,
      preview_cutoff = 1,
      preview_height = function(_, _, max_lines)
        local h = math.floor(max_lines * 0.5)
        return math.max(h, 10)
      end,
    },
  },
}

local picker_snacks = {
  "snacks",
  opts = {
    layout = "vertical",
  },
}

local picker_select = {
  "select",
  opts = {},
}

---@type string | "telescope" | "snacks" | "select" | "buffer" | "fzf-lua" | table | nil
local picker = picker_snacks

return picker
