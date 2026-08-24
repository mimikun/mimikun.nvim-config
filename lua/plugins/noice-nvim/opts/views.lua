---@type table<string, NoiceViewOptions>
local views = {
  popupmenu = {
    relative = "editor",
    zindex = 65,

    -- when auto, then it will be positioned to the cmdline or cursor
    position = "auto",
    size = {
      width = "auto",
      height = "auto",
      max_height = 20,
      --min_width = 10,
    },
    win_options = {
      winbar = "",
      foldenable = false,
      cursorline = true,
      cursorlineopt = "line",
      winhighlight = {
        -- change to NormalFloat to make it look like other floats
        Normal = "NoicePopupmenu",

        -- border highlight
        FloatBorder = "NoicePopupmenuBorder",

        -- used for highlighting the selected item
        CursorLine = "NoicePopupmenuSelected",

        -- used to highlight the part of the item that matches the input
        PmenuMatch = "NoicePopupmenuMatch",
      },
    },
    border = {
      padding = {
        0,
        1,
      },
    },
  },
  cmdline_popupmenu = {
    view = "popupmenu",
    zindex = 200,
  },
  virtualtext = {
    backend = "virtualtext",
    format = {
      "{message}",
    },
    hl_group = "NoiceVirtualText",
  },
  notify = {
    backend = {
      "snacks",
      "notify",
    },
    fallback = "mini",
    format = "notify",
    replace = false,
    merge = false,
  },
  split = {
    backend = "split",
    enter = false,
    relative = "editor",
    position = "bottom",
    size = "20%",
    close = {
      keys = {
        "q",
      },
    },
    win_options = {
      winhighlight = {
        Normal = "NoiceSplit",
        FloatBorder = "NoiceSplitBorder",
      },
      wrap = true,
    },
  },
  cmdline_output = {
    format = "details",
    view = "split",
  },
  messages = {
    view = "split",
    enter = true,
  },
  vsplit = {
    view = "split",
    position = "right",
  },
  popup = {
    backend = "popup",
    relative = "editor",
    close = {
      events = {
        "BufLeave",
      },
      keys = {
        "q",
      },
    },
    enter = true,
    border = {
      style = "rounded",
    },
    position = "50%",
    size = {
      width = "120",
      height = "20",
    },
    win_options = {
      winhighlight = {
        Normal = "NoicePopup",
        FloatBorder = "NoicePopupBorder",
      },
      winbar = "",
      foldenable = false,
    },
  },
  hover = {
    view = "popup",
    relative = "cursor",
    zindex = 45,
    enter = false,
    anchor = "auto",
    size = {
      width = "auto",
      height = "auto",
      max_height = 20,
      max_width = 120,
    },
    border = {
      style = "none",
      padding = {
        0,
        2,
      },
    },
    position = {
      row = 1,
      col = 0,
    },
    win_options = {
      wrap = true,
      linebreak = true,
    },
  },
  cmdline = {
    backend = "popup",
    relative = "editor",
    position = {
      row = "100%",
      col = 0,
    },
    size = {
      height = "auto",
      width = "100%",
    },
    border = {
      style = "none",
    },
    win_options = {
      winhighlight = {
        Normal = "NoiceCmdline",
        IncSearch = "",
        CurSearch = "",
        Search = "",
      },
    },
  },
  mini = {
    backend = "mini",
    relative = "editor",
    align = "message-right",
    timeout = 2000,
    reverse = true,
    focusable = false,
    position = {
      row = -1,
      col = "100%",
      --col = 0,
    },
    size = {
      width = "auto",
      height = "auto",
      max_height = 10,
    },
    border = {
      style = "none",
    },
    zindex = 60,
    win_options = {
      winbar = "",
      foldenable = false,
      winblend = 30,
      winhighlight = {
        Normal = "NoiceMini",
        IncSearch = "",
        CurSearch = "",
        Search = "",
      },
    },
  },
  cmdline_popup = {
    backend = "popup",
    relative = "editor",
    focusable = false,
    enter = false,
    zindex = 200,
    position = {
      row = "50%",
      col = "50%",
    },
    size = {
      min_width = 60,
      width = "auto",
      height = "auto",
    },
    border = {
      style = "rounded",
      padding = {
        0,
        1,
      },
    },
    win_options = {
      winhighlight = {
        Normal = "NoiceCmdlinePopup",
        FloatTitle = "NoiceCmdlinePopupTitle",
        FloatBorder = "NoiceCmdlinePopupBorder",
        IncSearch = "",
        CurSearch = "",
        Search = "",
      },
      winbar = "",
      foldenable = false,
      cursorline = false,
    },
  },
  cmdline_input = {
    view = "cmdline_popup",
    border = {
      style = "rounded",
      padding = {
        0,
        1,
      },
    },
  },
  confirm = {
    backend = "popup",
    relative = "editor",
    focusable = false,
    align = "center",
    enter = false,
    zindex = 210,
    format = {
      "{confirm}",
    },
    position = {
      row = 3,
      col = "50%",
    },
    size = "auto",
    border = {
      style = "rounded",
      padding = {
        0,
        1,
      },
      text = {
        top = " Confirm ",
      },
    },
    win_options = {
      winhighlight = {
        Normal = "NoiceConfirm",
        FloatBorder = "NoiceConfirmBorder",
      },
      winbar = "",
      foldenable = false,
    },
  },
}

return views
