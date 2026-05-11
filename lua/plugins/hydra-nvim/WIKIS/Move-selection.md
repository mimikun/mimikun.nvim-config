[mini.nvim](https://github.com/echasnovski/mini.nvim) plugin is needed for these hydras.

##### Mini.move box and line movements

![grafik](https://github.com/nvimtools/hydra.nvim/assets/13089667/cab2d4c3-e644-4241-b589-c100c18e1174)

![grafik](https://github.com/nvimtools/hydra.nvim/assets/13089667/f566b36a-6699-45fd-8419-aa7db47d82aa)


Includes setup and graceful error handling, if wanted.

```lua
local selmove_hint = [[
 Arrow^^^^^^
 ^ ^ _k_ ^ ^
 _h_ ^ ^ _l_
 ^ ^ _j_ ^ ^                      _<C-c>_
]]

local ok_minimove, minimove = pcall(require, 'mini.move')
assert(ok_minimove)
if ok_minimove == true then
  local opts = {
    mappings = {
      left = '',
      right = '',
      down = '',
      up = '',
      line_left = '',
      line_right = '',
      line_down = '',
      line_up = '',
    },
  }
  minimove.setup(opts)
  -- setup here prevents needless global vars for opts required by `move_selection()/moveline()`
  M.minimove_box_hydra = Hydra {
    name = 'Move Box Selection',
    hint = selmove_hint,
    config = {
      color = 'pink',
      invoke_on_body = true,
    },
    mode = 'v',
    body = '<leader>vb',
    heads = {
      {
        'h',
        function() minimove.move_selection('left', opts) end,
      },
      {
        'j',
        function() minimove.move_selection('down', opts) end,
      },
      {
        'k',
        function() minimove.move_selection('up', opts) end,
      },
      {
        'l',
        function() minimove.move_selection('right', opts) end,
      },
      { '<C-c>', nil, { exit = true } },
    },
  }
  M.minimove_line_hydra = Hydra {
    name = 'Move Line Selection',
    hint = selmove_hint,
    config = {
      color = 'pink',
      invoke_on_body = true,
    },
    mode = 'n',
    body = '<leader>vl',
    heads = {
      {
        'h',
        function() minimove.move_line('left', opts) end,
      },
      {
        'j',
        function() minimove.move_line('down', opts) end,
      },
      {
        'k',
        function() minimove.move_line('up', opts) end,
      },
      {
        'l',
        function() minimove.move_line('right', opts) end,
      },
      { '<C-c>', nil, { exit = true } },
    },
  }
end
```