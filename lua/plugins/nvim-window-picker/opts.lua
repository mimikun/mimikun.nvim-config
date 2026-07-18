---@type table
local opts = {
  -- type of hints you want to get following types are supported
  -- 'statusline-winbar' draw on 'statusline' if possible,
  -- if not 'winbar' will be 'floating-big-letter' draw big letter on a floating window used
  ---@type string | "statusline-winbar" | "floating-big-letter"
  hint = "statusline-winbar",

  -- when you go to window selection mode, status bar will show one of following letters on them so you can use that letter to select the window
  ---@type string
  selection_chars = "FJDKSLA;CMRUEIWOQP",

  -- This section contains picker specific configurations
  picker_config = {
    -- whether should select window by clicking left mouse button on it
    ---@type boolean
    handle_mouse_click = false,

    statusline_winbar_picker = {
      -- You can change the display string in status bar.
      -- It supports '%' printf style. Such as `return char .. ': %f'` to display buffer file path.
      -- See :h 'stl' for details.
      -- window id also passed in as second argument
      selection_display = function(char)
        return "%=" .. char .. "%="
      end,

      -- whether you want to use winbar instead of the statusline
      -- always: always use winbar
      -- never:  never use winbar
      -- smart:  use winbar if cmdheight=0 and statusline if cmdheight > 0
      ---@type string | "always" | "never" | "smart"
      use_winbar = "never",
    },

    floating_big_letter = {
      -- window picker plugin provides bunch of big letter fonts fonts will be lazy loaded as they are being requested additionally, user can pass in a table of fonts in to font property to use instead
      ---@type string | "ansi-shadow"
      font = "ansi-shadow",
    },
  },

  -- whether to show 'Pick window:' prompt
  ---@type boolean
  show_prompt = true,

  -- prompt message to show to get the user input
  ---@type string
  prompt_message = "Pick window: ",

  -- if you want to manually filter out the windows, pass in a function that takes two parameters.
  -- You should return window ids that should be included in the selection
  filter_func = function(_window_ids, _filters)
    -- folder the window_ids
    -- return only the ones you want to include
    -- EX:-
    --{1000, 1001}
    return nil
  end,

  -- following filters are only applied when you are using the default filter defined by this plugin.
  -- If you pass in a function to "filter_func" property, you are on your own
  filter_rules = {
    -- when there is only one window available to pick from, use that window without prompting the user to select
    ---@type boolean
    autoselect_one = true,

    -- whether you want to include the window you are currently on to window selection or not
    ---@type boolean
    include_current_win = false,

    -- whether to include windows marked as unfocusable
    ---@type boolean
    include_unfocusable_windows = false,

    -- filter using buffer options
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = {
        "NvimTree",
        "neo-tree",
        "notify",
        "snacks_notif",
      },

      -- if the file type is one of following, the window will be ignored
      buftype = {
        "terminal",
      },
    },

    -- filter using window options
    wo = {},

    -- if the file path contains one of following names, the window will be ignored
    file_path_contains = {},

    -- if the file name contains one of following names, the window will be ignored
    file_name_contains = {},
  },

  -- You can pass in the highlight name or a table of content to set as highlight
  highlights = {
    enabled = true,
    statusline = {
      focused = {
        fg = "#ededed",
        bg = "#e35e4f",
        bold = true,
      },
      unfocused = {
        fg = "#ededed",
        bg = "#44cc41",
        bold = true,
      },
    },
    winbar = {
      focused = {
        fg = "#ededed",
        bg = "#e35e4f",
        bold = true,
      },
      unfocused = {
        fg = "#ededed",
        bg = "#44cc41",
        bold = true,
      },
    },
  },
}

return opts
