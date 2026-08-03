local defaults = {
  show_if_buffers_are_at_least = 1,

  buffers = {
    filter_valid = false,
    filter_visible = false,
    focus_on_delete = "next",
    new_buffers_position = "last",
    delete_on_right_click = true,
  },

  mappings = {
    cycle_prev_next = true,
    disable_mouse = false,
  },

  history = {
    enabled = true,
    size = 2,
  },

  rendering = {
    max_buffer_width = 999,
    --slider = sliders.center_current_buffer,
  },

  pick = {
    use_filename = true,
    letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
  },

  default_hl = {
    fg = function(buffer)
      return buffer.is_focused and "TabLineSel" or "TabLine"
    end,
    bg = function(buffer)
      return buffer.is_focused and "TabLineSel" or "TabLine"
    end,
  },

  fill_hl = "TabLineFill",

  components = {
    {
      text = function(buffer)
        return " " .. buffer.devicon.icon
      end,
      fg = function(buffer)
        return buffer.devicon.color
      end,
    },
    {
      text = function(buffer)
        return buffer.unique_prefix
      end,
      fg = function()
        --return hlgroups.get_hl_attr("Comment", "fg")
      end,
      italic = true,
    },
    {
      text = function(buffer)
        return buffer.filename
      end,
      underline = function(buffer)
        if buffer.is_hovered and not buffer.is_focused then
          return true
        end
      end,
    },
    {
      text = " ",
    },
    {
      ---@param buffer Buffer
      text = function(buffer)
        if buffer.is_modified then
          return ""
        end
        if buffer.is_hovered then
          return "󰅙"
        end
        return "󰅖"
      end,
      on_click = function(_, _, _, _, buffer)
        buffer:delete()
      end,
    },
    {
      text = " ",
    },
  },

  tabs = {
    placement = "right",
    components = {
      --it
    },
  },

  rhs = {
    --it
  },

  sidebar = {
    filetype = {
      "NvimTree",
      "neo-tree",
      "SidebarNvim",
    },
    components = {
      --it
    },
  },
}
