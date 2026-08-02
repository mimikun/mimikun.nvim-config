Welcome to the nvim-cokeline wiki!


## Configuration recipes

### Harpoon-based sorting:

This sorter pins harpoon-marked buffers to the left hand side of the tabline, while still allowing you to rearrange any others that are open. Any harpoon mark order changes will be reflected immediately in the tabline.

> [!NOTE]
> This sorter only work with Harpoon v2; It also may not be up to date. If you notice that it is broken or outdated, contributions are welcome :)

```lua
local function harpoon_sorter()
  local cache = {}
  local setup = false

  local function marknum(buf, force)
    local harpoon = require("harpoon")
    local b = cache[buf.number]
    if b == nil or force then
      local path =
        require("plenary.path"):new(buf.path):make_relative(vim.uv.cwd())
      for i, mark in ipairs(harpoon:list():display()) do
        if mark == path then
          b = i
          cache[buf.number] = b
          break
        end
      end
    end
    return b
  end

  -- Use this in `config.buffers.new_buffers_position`
  return function(a, b)
    -- Only run this if harpoon is loaded, otherwise just use the default sorting.
    -- This could be used to only run if a user has harpoon installed, but
    -- I'm mainly using it to avoid loading harpoon on UiEnter.
    local has_harpoon = package.loaded["harpoon"] ~= nil
    if not has_harpoon then
      ---@diagnostic disable-next-line: undefined-field
      return a._valid_index < b._valid_index
    elseif not setup then
      local refresh = function()
        cache = {}
      end
      require("harpoon"):extend({
        ADD = refresh,
        REMOVE = refresh,
        REORDER = refresh,
        LIST_CHANGE = refresh,
      })
      setup = true
    end
    -- switch the a and b._valid_index to place non-harpoon buffers on the left
    -- side of the tabline - this puts them on the right.
    local ma = marknum(a)
    local mb = marknum(b)
    if ma and not mb then
      return true
    elseif mb and not ma then
      return false
    elseif ma == nil and mb == nil then
      ma = a._valid_index
      mb = b._valid_index
    end
    return ma < mb
  end
end
```

### Focus mappings by @psmolak:

<details>

<summary>From <a href="https://github.com/willothy/nvim-cokeline/issues/59">#59</a></summary>

Instead of setting up new keybinding for each buffer number separately in a loop, we could use `count` variable like so:

 ```lua
 vim.keymap.set('n', '<tab>', function()
   return ('<Plug>(cokeline-focus-%s)'):format(vim.v.count > 0 and vim.v.count or 'next')
 end, { silent = true, expr = true })
 ```

Now whenever we precede `Tab` with a count, we will go directly to that buffer. Otherwise the `Tab` will just move to the next buffer in a list.

</details>

### Rounded corners

![userconfig-noib3](https://user-images.githubusercontent.com/38540736/226447796-12200cca-9dec-4145-8f4a-d271512bdf8c.png)

<details>
<summary>This config shows how you configure buffers w/ rounded corners.</summary>

```lua
local hlgroups = require('cokeline.hlgroups')
local hl_attr = hlgroups.get_hl_attr

require('cokeline').setup({
  default_hl = {
    fg = function(buffer)
      return
        buffer.is_focused
        and hl_attr('Normal', 'fg')
         or hl_attr('Comment', 'fg')
    end,
    bg = hl_attr('ColorColumn', 'bg'),
  },

  components = {
    {
      text = ' ',
      bg = hl_attr('Normal', 'bg'),
    },
    {
      text = '',
      fg = hl_attr('ColorColumn', 'bg'),
      bg = hl_attr('Normal', 'bg'),
    },
    {
      text = function(buffer)
        return buffer.devicon.icon
      end,
      fg = function(buffer)
        return buffer.devicon.color
      end,
    },
    {
      text = ' ',
    },
    {
      text = function(buffer) return buffer.filename .. '  ' end,
      style = function(buffer)
        return buffer.is_focused and 'bold' or nil
      end,
    },
    {
      text = '',
      delete_buffer_on_left_click = true,
    },
    {
      text = '',
      fg = hl_attr('ColorColumn', 'bg'),
      bg = hl_attr('Normal', 'bg'),
    },
  },
})
```

</details>

### Equally sized buffers

<details>
<summary>
This config shows how to get equally sized buffers. All the buffers
are 23 characters wide, adding padding spaces left and right if a buffer is too
short and cutting it off if it's too long.
</summary>

```lua
local hl_attr = require('cokeline.hlgroups').get_hl_attr
local mappings = require('cokeline.mappings')

local str_rep = string.rep

local green = vim.g.terminal_color_2
local yellow = vim.g.terminal_color_3

local comments_fg = hl_attr('Comment', 'fg')
local errors_fg = hl_attr('DiagnosticError', 'fg')
local warnings_fg = hl_attr('DiagnosticWarn', 'fg')

local min_buffer_width = 23

local components = {
  separator = {
    text = ' ',
    bg = hl_attr('Normal', 'bg'),
    truncation = { priority = 1 },
  },

  space = {
    text = ' ',
    truncation = { priority = 1 },
  },

  left_half_circle = {
    text = '',
    fg = hl_attr('ColorColumn', 'bg'),
    bg = hl_attr('Normal', 'bg'),
    truncation = { priority = 1 },
  },

  right_half_circle = {
    text = '',
    fg = hl_attr('ColorColumn', 'bg'),
    bg = hl_attr('Normal', 'bg'),
    truncation = { priority = 1 },
  },

  devicon = {
    text = function(buffer)
      return buffer.devicon.icon
    end,
    fg = function(buffer)
      return buffer.devicon.color
    end,
    truncation = { priority = 1 },
  },

  index = {
    text = function(buffer)
      return buffer.index .. ': '
    end,
    fg = function(buffer)
      return
        (buffer.diagnostics.errors ~= 0 and errors_fg)
        or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
        or nil
    end,
    truncation = { priority = 1 },
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
    fg = function(buffer)
      return
        (buffer.diagnostics.errors ~= 0 and errors_fg)
        or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
        or nil
    end,
    style = function(buffer)
      return
        ((buffer.is_focused and buffer.diagnostics.errors ~= 0)
          and 'bold,underline')
        or (buffer.is_focused and 'bold')
        or (buffer.diagnostics.errors ~= 0 and 'underline')
        or nil
    end
    truncation = {
      priority = 2,
      direction = 'left',
    },
  },

  close_or_unsaved = {
    text = function(buffer)
      return buffer.is_modified and '●' or ''
    end,
    fg = function(buffer)
      return buffer.is_modified and green or nil
    end
    delete_buffer_on_left_click = true,
    truncation = { priority = 1 },
  },
}

local get_remaining_space = function(buffer)
  local used_space = 0
  for _, component in pairs(components) do
    used_space = used_space + vim.fn.strwidth(
      (type(component.text) == 'string' and component.text)
      or (type(component.text) == 'function' and component.text(buffer))
    )
  end
  return math.max(0, min_buffer_width - used_space)
end

local left_padding = {
  text = function(buffer)
    local remaining_space = get_remaining_space(buffer)
    return str_rep(' ', remaining_space / 2 + remaining_space % 2)
  end,
}

local right_padding = {
  text = function(buffer)
    local remaining_space = get_remaining_space(buffer)
    return str_rep(' ', remaining_space / 2)
  end,
}

require('cokeline').setup({
  show_if_buffers_are_at_least = 2,

  buffers = {
    -- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
    -- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
    focus_on_delete = 'next',
    new_buffers_position = 'next',
  },

  rendering = {
    max_buffer_width = 23,
  },

  default_hl = {
    fg = function(buffer)
      return
        buffer.is_focused
        and hl_attr('Normal', 'fg')
         or hl_attr('Comment', 'fg')
    end,
    bg = hl_attr('ColorColumn', 'bg'),
  },

  sidebar = {
    filetype = 'NvimTree',
    components = {
      {
        text = '  NvimTree',
        fg = yellow,
        bg = hl_attr('NvimTreeNormal', 'bg'),
        style = 'bold',
      },
    }
  },

  components = {
    components.separator,
    components.left_half_circle,
    left_padding,
    components.devicon,
    components.index,
    components.unique_prefix,
    components.filename,
    components.space,
    right_padding,
    components.close_or_unsaved,
    components.right_half_circle,
  },
})

```

</details>
