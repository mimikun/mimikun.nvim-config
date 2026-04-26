With so many User Commands and extra stuff I think having keymaps to call them
would be very convenient for some.

---

## My Own Examples

In [my own Neovim config](https://github.com/DrKJeff16/Jnvim/blob/main/lua/plugin/project.lua#L72) I have the following keymaps:

```lua
local Project = require('project')

vim.keymap.set(
    'n',
    '<leader>ph',
    function()
        vim.cmd.checkhealth('project')
    end,
    {
        desc = 'Attempt to run `:checkhealth project`',
        noremap = true,
        silent = true,
    }
)
vim.keymap.set('n', '<leader>pC', vim.cmd.ProjectConfig, { desc = 'Print Project Config', ... })
vim.keymap.set('n', '<leader>pr', vim.cmd.ProjectRecents, { desc = 'Print Recent Projects', ...})
vim.keymap.set('n','<leader>pf', Project.run_fzf_lua, { desc = 'Run Fzf-Lua', ... })
```

---

<div align="center">

[**<== Previous Entry**](https://github.com/DrKJeff16/project.nvim/wiki/Breaking-Changes) | [**Index**](https://github.com/DrKJeff16/project.nvim/wiki) | [**Next Entry ==>**](https://github.com/DrKJeff16/project.nvim/wiki/Migrating-From-The-Original)

</div>