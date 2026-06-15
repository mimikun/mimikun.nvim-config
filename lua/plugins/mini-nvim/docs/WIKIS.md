# WIKIS

## mini.jump2d.md

### Replace `f`, `F`, `t`, `T`

The 'mini.jump2d' module can be used to replace builtin `f`, `F`, `t`, `T` motions (if, for some reason, [mini.jump](https://github.com/echasnovski/mini.nvim#minijump) is not a suitable solution). Here is a config which creates mappings for Normal, Visual and Operator-pending modes (with a rudimentary dot-repeat) to achieve that:

```lua
require('mini.jump2d').setup()

local function make_fFtT_keymap(key, extra_opts)
  local opts = vim.tbl_deep_extend('force', { allowed_lines = { blank = false, fold = false } }, extra_opts)
  opts.hooks = opts.hooks or {}

  opts.hooks.before_start = function()
    local input = vim.fn.getcharstr()
    --stylua: ignore
    if input == nil then
      opts.spotter = function() return {} end
    else
      local pattern = vim.pesc(input)
      opts.spotter = MiniJump2d.gen_pattern_spotter(pattern)
    end
  end

  -- Using `<Cmd>...<CR>` enables dot-repeat in Operator-pending mode
  _G.jump2dfFtT_opts = _G.jump2dfFtT_opts or {}
  _G.jump2dfFtT_opts[key] = opts
  local command = string.format('<Cmd>lua MiniJump2d.start(_G.jump2dfFtT_opts.%s)<CR>', key)

  vim.api.nvim_set_keymap('n', key, command, {})
  vim.api.nvim_set_keymap('v', key, command, {})
  vim.api.nvim_set_keymap('o', key, command, {})
end

make_fFtT_keymap('f', { allowed_lines = { cursor_before = false } })
make_fFtT_keymap('F', { allowed_lines = { cursor_after = false } })
make_fFtT_keymap('t', {
  allowed_lines = { cursor_before = false },
  hooks = { after_jump = function() vim.api.nvim_input('<Left>') end },
})
make_fFtT_keymap('T', {
  allowed_lines = { cursor_after = false },
  hooks = { after_jump = function() vim.api.nvim_input('<Right>') end },
})
```

## mini.sessions.md

### How to start nvim without session when `autoread` is `true`?

All "runtime" options in every 'mini.nvim' module can be [modified manually after setup](https://github.com/echasnovski/mini.nvim/blob/b0ba2b98ee63b4814fcfa7657dab9f72bc4cc7da/README.md?plain=1#L79) to take effect. So to do this, start Neovim with `nvim -c 'lua MiniSessions.config.autoread = false'`.

## mini.starter.md

### How to make custom mappings for Starter buffer?

Use `MiniStarterOpened` event to make buffer-local mappings. Example of using `<Left>` and `<Right>` arrow keys to move between items:

```lua
vim.cmd([[
  augroup MiniStarterKeymaps
    au!
    au User MiniStarterOpened nmap <buffer> <Left> <Cmd>lua MiniStarter.update_current_item('next')<CR>
    au User MiniStarterOpened nmap <buffer> <Right> <Cmd>lua MiniStarter.update_current_item('prev')<CR>
  augroup END
]])
```

