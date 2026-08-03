# Example configs

### author: [@noib3](https://github.com/noib3/)

![userconfig-noib3](https://user-images.githubusercontent.com/38540736/226447816-c696153f-ccee-4e4a-8b6a-55e53ee737f8.png)

<details>
<summary>Click to see configuration</summary>

```lua
local get_hex = require('cokeline/utils').get_hex
local mappings = require('cokeline/mappings')
local comments_fg = get_hex('Comment', 'fg')
local errors_fg = get_hex('DiagnosticError', 'fg')
local warnings_fg = get_hex('DiagnosticWarn', 'fg')
local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_3
local components = {
  space = {
    text = ' ',
    truncation = { priority = 1 }
  },
  two_spaces = {
    text = '  ',
    truncation = { priority = 1 },
  },
  separator = {
    text = function(buffer)
      return buffer.index ~= 1 and '▏' or ''
    end,
    truncation = { priority = 1 }
  },
  devicon = {
    text = function(buffer)
      return
        (mappings.is_picking_focus() or mappings.is_picking_close())
          and buffer.pick_letter .. ' '
           or buffer.devicon.icon
    end,
    fg = function(buffer)
      return
        (mappings.is_picking_focus() and yellow)
        or (mappings.is_picking_close() and red)
        or buffer.devicon.color
    end,
    style = function(_)
      return
        (mappings.is_picking_focus() or mappings.is_picking_close())
        and 'italic,bold'
         or nil
    end,
    truncation = { priority = 1 }
  },
  index = {
    text = function(buffer)
      return buffer.index .. ': '
    end,
    truncation = { priority = 1 }
  },
  unique_prefix = {
    text = function(buffer)
      return buffer.unique_prefix
    end,
    fg = comments_fg,
    style = 'italic',
    truncation = {
      priority = 3,
      direction = 'left',
    },
  },
  filename = {
    text = function(buffer)
      return buffer.filename
    end,
    style = function(buffer)
      return
        ((buffer.is_focused and buffer.diagnostics.errors ~= 0)
          and 'bold,underline')
        or (buffer.is_focused and 'bold')
        or (buffer.diagnostics.errors ~= 0 and 'underline')
        or nil
    end,
    truncation = {
      priority = 2,
      direction = 'left',
    },
  },
  diagnostics = {
    text = function(buffer)
      return
        (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
        or (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
        or ''
    end,
    fg = function(buffer)
      return
        (buffer.diagnostics.errors ~= 0 and errors_fg)
        or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
        or nil
    end,
    truncation = { priority = 1 },
  },
  close_or_unsaved = {
    text = function(buffer)
      return buffer.is_modified and '●' or ''
    end,
    fg = function(buffer)
      return buffer.is_modified and green or nil
    end,
    delete_buffer_on_left_click = true,
    truncation = { priority = 1 },
  },
}
require('cokeline').setup({
  show_if_buffers_are_at_least = 2,
  buffers = {
    -- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
    -- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
    new_buffers_position = 'next',
  },
  rendering = {
    max_buffer_width = 30,
  },
  default_hl = {
    fg = function(buffer)
      return
        buffer.is_focused
        and get_hex('Normal', 'fg')
         or get_hex('Comment', 'fg')
    end,
    bg = get_hex('ColorColumn', 'bg'),
  },
  components = {
    components.space,
    components.separator,
    components.space,
    components.devicon,
    components.space,
    components.index,
    components.unique_prefix,
    components.filename,
    components.diagnostics,
    components.two_spaces,
    components.close_or_unsaved,
    components.space,
  },
})
```

</details>

### author: [@jqhr](https://github.com/jqhr/)

![userconfig-jqhr](https://user-images.githubusercontent.com/23305067/167068447-4235b889-510d-41f5-9ee0-f3490ae129dc.gif)

<details>
<summary>Click to see configuration</summary>

```lua

local map = vim.api.nvim_set_keymap
local get_hex = require('cokeline/utils').get_hex
local get_visible = require('cokeline/buffers').get_visible
local is_picking_focus = require('cokeline/mappings').is_picking_focus
local is_picking_close = require('cokeline/mappings').is_picking_close

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_3
local oceanblue = '#0066cc'

require('cokeline').setup({
  -- Only show the bufferline when there are at least this many visible buffers.
  -- default: `1`.
  show_if_buffers_are_at_least = 1,

  buffers = {
    -- filter_valid = function(buffer) return buffer.filetype ~= 'netrw' and buffer.filetype ~= 'startify' end,

    focus_on_delete = 'next',

    new_buffers_position = 'next',
  },

  mappings = {
    cycle_prev_next = true,
  },

  rendering = {
    max_buffer_width = 999,
  },

  default_hl = {
    fg = '#ffffff',
    bg = function(buffer)
      return
        buffer.is_focused
        and oceanblue
        or get_hex('ColorColumn', 'bg')
    end,
  },
  components = {
    {
      text = function(buffer)
       return buffer.is_focused and '' or ' '
      end ,
      fg = function(buffer)
        return buffer.is_focused and buffer.index ~= 1 and get_hex('Normal', 'bg') or oceanblue
      end,
      bg = function(buffer)
        return buffer.is_focused and oceanblue or get_hex('Normal', 'bg')
      end
    },
    {
      text = function(buffer)
        return
          (is_picking_focus() or is_picking_close())
          and buffer.pick_letter .. ' '
           or buffer.devicon.icon
      end,
      fg = function(buffer)
        return
          (is_picking_focus() and red)
          or (is_picking_close() and yellow)
          or buffer.devicon.color
      end,
      style = function(_)
        return
          (is_picking_focus() or is_picking_close())
          and 'italic,bold'
           or nil
      end,
    },
    {
      text = function(buffer) return buffer.index .. ' ' end,
      style = 'italic',
    },
    {
      text = function(buffer) return buffer.filename .. '  ' end,
      style = function(buffer) return buffer.is_focused and 'bold' or nil end,
    },
    {
      text = function(buffer)
        if buffer.is_focused then
          return ''
        end
       local buffers = get_visible()
       local next = buffer.index + 1
       return buffers[next] and buffers[next].is_focused and '' or ' '
      end ,
      fg = function(buffer)
        return buffer.is_focused and oceanblue or get_hex('Normal', 'fg')
      end,
      bg = get_hex('ColorColumn', 'bg')
    },
  },
})

```

</details>




![userconfig-noib3](https://user-images.githubusercontent.com/38540736/226447811-c35d930a-94d4-4715-889b-2b2e2fafe4bd.png)

### author: [@olimorris](https://github.com/olimorris/dotfiles)

<details>
<summary>Click to see configuration</summary>

```lua
local M = {}

function M.setup()
  local present, cokeline = pcall(require, "cokeline")
  if not present then
    return
  end

  local colors = require("colors").get()

  cokeline.setup({

    show_if_buffers_are_at_least = 2,

    mappings = {
      cycle_prev_next = true,
    },

    default_hl = {
      fg = function(buffer)
        return buffer.is_focused and colors.purple or colors.gray
      end,
      bg = "NONE",
      style = function(buffer)
        return buffer.is_focused and "bold" or nil
      end,
    },

    components = {
      {
        text = function(buffer)
          return buffer.index ~= 1 and "  "
        end,
      },
      {
        text = function(buffer)
          return buffer.index .. ": "
        end,
        style = function(buffer)
          return buffer.is_focused and "bold" or nil
        end,
      },
      {
        text = function(buffer)
          return buffer.unique_prefix
        end,
        fg = function(buffer)
          return buffer.is_focused and colors.purple or colors.gray
        end,
        style = "italic",
      },
      {
        text = function(buffer)
          return buffer.filename .. " "
        end,
        style = function(buffer)
          return buffer.is_focused and "bold" or nil
        end,
      },
      {
        text = function(buffer)
          return buffer.is_modified and " ●"
        end,
        fg = function(buffer)
          return buffer.is_focused and colors.red
        end,
      },
      {
        text = "  ",
      },
    },
  })
end

return M
```

</details>

![userconfig-olimorris](https://user-images.githubusercontent.com/38540736/226447827-e2dc7705-b255-4108-9b1a-037adb64c71c.gif)

### author: [@alex-popov-tech](https://github.com/alex-popov-tech/.dotfiles)

<details>
<summary>Click to see configuration</summary>

```lua
return function()
    local get_hex = require("cokeline/utils").get_hex
    local space = {text = " "}
    require("cokeline").setup(
        {
            mappings = {
              cycle_prev_next = true,
            },
            default_hl = {
              fg = function(buffer)
                return
                  buffer.is_focused and nil or get_hex("Comment", "fg")
              end,
              bg = "none",
            },
            components = {
                space,
                {
                    text = function(buffer)
                        return buffer.devicon.icon
                    end,
                    fg = function(buffer)
                        return buffer.devicon.color
                    end
                },
                {
                    text = function(buffer)
                        return buffer.filename
                    end,
                    fg = function(buffer)
                        if buffer.is_focused then
                            return "#78dce8"
                        end
                        if buffer.is_modified then
                            return "#e5c463"
                        end
                        if buffer.lsp.errors ~= 0 then
                            return "#fc5d7c"
                        end
                    end,
                    style = function(buffer)
                        if buffer.is_focused then
                            return "underline"
                        end
                        return nil
                    end
                },
                {
                    text = function(buffer)
                        if buffer.is_readonly then
                            return " 🔒"
                        end
                        return ""
                    end
                },
                space
            }
        }
    )
end
```

</details>

![userconfig-alex-popov-tech](https://user-images.githubusercontent.com/38540736/226447825-7f314e18-472e-4148-982b-d569b1743a9b.png)

### author: [@danielnieto](https://github.com/danielnieto)

<details>
<summary>This configuration shows Powerline styled tabline, and the basic stuff: just the devicons and the filename with unique prefixes. It also shows the pick buffer character.</summary>

```lua
local is_picking_focus = require("cokeline/mappings").is_picking_focus
local is_picking_close = require("cokeline/mappings").is_picking_close
local get_hex = require("cokeline/utils").get_hex

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_4
local space = {text = " "}
local dark = get_hex("Normal", "bg")
local text = get_hex("Comment", "fg")
local grey = get_hex("ColorColumn", "bg")
local light = get_hex("Comment", "fg")
local high = "#a6d120"

require("cokeline").setup(
    {
        default_hl = {
            fg = function(buffer)
                if buffer.is_focused then
                    return dark
                end
                return text
            end,
            bg = function(buffer)
                if buffer.is_focused then
                    return high
                end
                return grey
            end
        },
        components = {
            {
                text = function(buffer)
                    if buffer.index ~= 1 then
                        return ""
                    end
                    return ""
                end,
                bg = function(buffer)
                    if buffer.is_focused then
                        return high
                    end
                    return grey
                end,
                fg = dark
            },
            space,
            {
                text = function(buffer)
                    if is_picking_focus() or is_picking_close() then
                        return buffer.pick_letter .. " "
                    end

                    return buffer.devicon.icon
                end,
                fg = function(buffer)
                    if is_picking_focus() then
                        return yellow
                    end
                    if is_picking_close() then
                        return red
                    end

                    if buffer.is_focused then
                        return dark
                    else
                        return light
                    end
                end,
                style = function(_)
                    return (is_picking_focus() or is_picking_close()) and "italic,bold" or nil
                end
            },
            {
                text = function(buffer)
                    return buffer.unique_prefix .. buffer.filename .. "⠀"
                end,
                style = function(buffer)
                    return buffer.is_focused and "bold" or nil
                end
            },
            {
                text = "",
                fg = function(buffer)
                    if buffer.is_focused then
                        return high
                    end
                    return grey
                end,
                bg = dark
            }
        }
    }
)
```

</details>

![cokeline-danielnieto89](https://user-images.githubusercontent.com/2120107/171753414-9d81c866-7f99-48f8-b6ff-0c28e8883aaa.gif)

### author: [@miversen33](https://github.com/miversen33)

<details>
<summary>This configuration shows the `is_first` and `is_last` buffer options and how to create a cokeline with different components based on if the
component is the first, last, or neither Additionally, this config has some integration with the lsp.</summary>

```lua
local get_hex = require("cokeline.utils").get_hex
local active_bg_color = '#931E9E'
local inactive_bg_color = get_hex('Normal', 'bg')
local bg_color = get_hex('ColorColumn', 'bg')
require('cokeline').setup({
      show_if_buffers_are_at_least = 1,
      mappings = {
          cycle_prev_next = true
      },
      default_hl = {
        bg = function(buffer)
          if buffer.is_focused then
            return active_bg_color
          end
        end,
      },
      components = {
          {
            text = function(buffer)
              local _text = ''
              if buffer.index > 1 then _text = ' ' end
              if buffer.is_focused or buffer.is_first then
                _text = _text .. ''
              end
              return _text
            end,
            fg = function(buffer)
              if buffer.is_focused then
                return active_bg_color
              elseif buffer.is_first then
                return inactive_bg_color
              end
            end,
            bg = function(buffer)
              if buffer.is_focused then
                if buffer.is_first then
                  return bg_color
                else
                  return inactive_bg_color
                end
              elseif buffer.is_first then
                  return bg_color
              end
            end
          },
          {
              text = function(buffer)
                  local status = ''
                  if buffer.is_readonly then
                      status = '➖'
                  elseif buffer.is_modified then
                      status = ''
                  end
                  return status
              end,
          },
          {
              text = function(buffer)
                  return " " .. buffer.devicon.icon
              end,
              fg = function(buffer)
                if buffer.is_focused then
                  return buffer.devicon.color
                end
              end
          },
          {
              text = function(buffer)
                return buffer.unique_prefix .. buffer.filename
              end,
              fg = function(buffer)
                  if(buffer.diagnostics.errors > 0) then
                      return '#C95157'
                  end
              end,
              style = function(buffer)
                  local text_style = 'NONE'
                  if buffer.is_focused then
                      text_style = 'bold'
                  end
                  if buffer.diagnostics.errors > 0 then
                      if text_style ~= 'NONE' then
                          text_style = text_style .. ',underline'
                      else
                          text_style = 'underline'
                      end
                  end
                  return text_style
              end
          },
          {
              text = function(buffer)
                  local errors = buffer.diagnostics.errors
                  if(errors <= 9) then
                      errors = ''
                  else
                      errors = "🙃"
                  end
                  return errors .. ' '
              end,
              fg = function(buffer)
                if buffer.diagnostics.errors == 0 then
                  return '#3DEB63'
                elseif buffer.diagnostics.errors <= 9 then
                  return '#DB121B'
                end
              end
          },
          {
              text = '',
              delete_buffer_on_left_click = true
          },
          {
            text = function(buffer)
              if buffer.is_focused or buffer.is_last then
                return ''
              else
                return ' '
              end
            end,
            fg = function(buffer)
              if buffer.is_focused then
                return active_bg_color
              elseif buffer.is_last then
                return inactive_bg_color
              else
                return bg_color
              end
            end,
            bg = function(buffer)
              if buffer.is_focused then
                if buffer.is_last then
                  return bg_color
                else
                  return inactive_bg_color
                end
              elseif buffer.is_last then
                  return bg_color
              end
            end
          }
      },
  })
```

</details>

![cokeline-miversen33](https://user-images.githubusercontent.com/2640668/174489433-2faa0eea-4921-42ea-a877-1e143e44bc14.png)
