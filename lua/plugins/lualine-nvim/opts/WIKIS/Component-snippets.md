Here we list various snippets for components that can be useful
for users. Most of these are functions that can be used as regular
function component in any section of lualine. If you have some
nice component snippets that you want to share. You can add proposal
to get them added here.

### Truncating components in smaller window
It's often useful to truncate/disable some components in smaller windows.

```lua
--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
       return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

require'lualine'.setup {
  lualine_a = {
    {'mode', fmt=trunc(80, 4, nil, true)},
    {'filename', fmt=trunc(90, 30, 50)},
    {function() return require'lsp-status'.status() end, fmt=trunc(120, 20, 60)}
  }
}
```

### Trailing whitespaces
Shows 'TW:line' in lualine when there are trailing
white space in current buffer.
```lua
function()
  local space = vim.fn.search([[\s\+$]], 'nwc')
  return space ~= 0 and "TW:"..space or ""
end
```

### Mixed indent
Shows 'MI:line' in lualine when both tab and spaces are used for indenting
current buffer.
```lua
function()
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = vim.fn.search(space_pat, 'nwc')
  local tab_indent = vim.fn.search(tab_pat, 'nwc')
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
    mixed = mixed_same_line > 0
  end
  if not mixed then return '' end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
     return 'MI:'..mixed_same_line
  end
  local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
  local tab_indent_cnt =  vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
  if space_indent_cnt > tab_indent_cnt then
    return 'MI:'..tab_indent
  else
    return 'MI:'..space_indent
  end
end
```

### keymap
Shows short name of currently active keymap.
See `:h keymap`

```lua
local function keymap()
  if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
    return '⌨ ' .. vim.b.keymap_name
  end
  return ''
end

```

### Adding window number

This is quite useful to quickly switch between multiple windows.

```lua
local function window()
  return vim.api.nvim_win_get_number(0)
end

require'lualine'.setup {
  sections = {
    lualine_a = { window },
  }
}
```

### Using external source for branch
If you have other plugins installed that keep track of
branch info . lualine can reuse that info.
- ***vim-fugitive***

```lua
  lualine_b = { {'FugitiveHead', icon = ''}, },
```

- ***gitsigns.nvim***

```lua
    lualine_b = { {'b:gitsigns_head', icon = ''}, },
```

### Using external source for diff
If you have other plugins installed that keep track of
info. lualine can reuse that info. And you don't need
to have two separate plugins doing the same thing.

- ***gitsigns.nvim***

```lua
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

require'lualine'.setup {
  sections = {
    lualine_b = { {'diff', source = diff_source}, },
  }
}
```

- ***signify***

```lua
local function diff_source()
  if vim.fn.exists('*sy#repo#get_stats') == 1 then
    local stats = vim.fn['sy#repo#get_stats']()
    return {
      added = stats[1],
      modified = stats[2],
      removed = stats[3],
    }
  end
end

require'lualine'.setup {
  sections = {
    lualine_b = { {'diff', source = diff_source}, },
  }
}
```

### Display EOL fileformat as CRLF

Display the fileformat section as CRLF instead of icons or unix/dos/mac

```lua
require'lualine'.setup {
  sections = {
    lualine_x = {
      {
        'fileformat',
        icons_enabled = true,
        symbols = {
          unix = 'LF',
          dos = 'CRLF',
          mac = 'CR',
        },
      },
    },
  },
}

```

### Changing filename color based on  modified status

You can use a custom component extending builtin filename component to do this.

```lua
local custom_fname = require('lualine.components.filename'):extend()
local highlight = require'lualine.highlight'
local default_status_colors = { saved = '#228B22', modified = '#C70039' }

function custom_fname:init(options)
  custom_fname.super.init(self, options)
  self.status_colors = {
    saved = highlight.create_component_highlight_group(
      {bg = default_status_colors.saved}, 'filename_status_saved', self.options),
    modified = highlight.create_component_highlight_group(
      {bg = default_status_colors.modified}, 'filename_status_modified', self.options),
  }
  if self.options.color == nil then self.options.color = '' end
end

function custom_fname:update_status()
  local data = custom_fname.super.update_status(self)
  data = highlight.component_format_highlight(vim.bo.modified
                                              and self.status_colors.modified
                                              or self.status_colors.saved) .. data
  return data
end

require'lualine'.setup {
  lualine_c = {custom_fname},
}
```
