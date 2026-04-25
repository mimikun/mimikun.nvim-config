## Integrations

#### [scope.nvim]

To preserve buffer order while using [scope.nvim], you can add this to your config:

```lua
require('scope').setup {
  hooks = {
    pre_tab_leave = function()
      vim.api.nvim_exec_autocmds('User', {pattern = 'ScopeTabLeavePre'})
      -- [other statements]
    end,

    post_tab_enter = function()
      vim.api.nvim_exec_autocmds('User', {pattern = 'ScopeTabEnterPost'})
      -- [other statements]
    end,

    -- [other hooks]
  },

  -- [other options]
}
```

#### Sessions

`barbar.nvim` can restore the order that your buffers were in, as well as whether a buffer was pinned. To do this, `sessionoptions` must contain `globals`, and the `User SessionSavePre` event must be executed before `:mksession`.

##### [mini.nvim]

Here is a [mini.sessions][mini.nvim] config which can be used:

```lua
vim.opt.sessionoptions:append 'globals'
require'mini.sessions'.setup {
  hooks = {
    pre = {
      write = function() vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'}) end,
    },
  },
}
```

##### [persistence.nvim]

Here is a [persistence.nvim] config which can be used:

```lua
require'persistence'.setup {
  options = {--[[<other options>,]] 'globals'},
  pre_save = function() vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'}) end,
}
```

##### [persisted.nvim]

Here is a [persisted.nvim] config which can be used:

```lua
vim.opt.sessionoptions:append 'globals'
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'PersistedSavePre',
  group = vim.api.nvim_create_augroup('PersistedHooks', {}),
  callback = function()
    vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
  end,
})
```

##### [resession.nvim]

This plugin comes with support for [resession.nvim] through an extension. To enable, add the following snippet to your resession config:

```lua
extensions = {
  barbar = {},
}
```

If using [lazy.nvim](https://github.com/folke/lazy.nvim) then ensure you add barbar.nvim as a dependency to resession, to ensure that the extension loads before resession.

##### Custom

You can add this snippet to your config to take advantage of our session integration:

```lua
vim.opt.sessionoptions:append 'globals'
vim.api.nvim_create_user_command(
  'Mksession',
  function(attr)
    vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'})

    -- Neovim 0.8+
    vim.cmd.mksession {bang = attr.bang, args = attr.fargs}

    -- Neovim 0.7
    vim.api.nvim_command('mksession ' .. (attr.bang and '!' or '') .. attr.args)
  end,
  {bang = true, complete = 'file', desc = 'Save barbar with :mksession', nargs = '?'}
)
```

## Known Issues

#### Sidebars On Startup

The `sidebar_filetypes` option may not work as expected if your sidebar opens on startup. See nvim-tree/nvim-tree.lua#2130 for details, and romgrk/barbar.nvim#421 for a workaround.

