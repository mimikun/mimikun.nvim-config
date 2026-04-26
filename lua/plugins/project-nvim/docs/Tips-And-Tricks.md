## Redirecting Output Of User Commands

If you need to open an issue, or just want to see the output of `:ProjectConfig` (or similar commands) clearly, I have a redirection command you can use.

**It's not mine, really. I saw it somewhere (probably StackOverflow), and I use it daily ever since.**

To use it just paste this in your Neovim config:

```lua
vim.api.nvim_create_user_command("Redir", function(ctx)
    local lines = vim.split(
        vim.api.nvim_exec2(ctx.args, { output = true })['output'],
        string.char(10), -- `'\n'`
        { plain = true }
    )

    local buf = vim.api.nvim_create_buf(true, true)

    vim.api.nvim_open_win(buf, true, { vertical = false })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    vim.api.nvim_set_option_value('modified', false, { buf = buf })
end, { nargs = '+' })
```

Usage:

```vim
" For example, if you wish to see your `:messages` output clearly
:Redir messages
```

> [!NOTE]
> You don't have to name it `Redir` necessarily. I just use that name myself.

---

<div align="center">

[**<== Previous Entry**](https://github.com/DrKJeff16/project.nvim/wiki/Migrating-From-The-Original) | [**Index**](https://github.com/DrKJeff16/project.nvim/wiki) | ~**Next Entry ==>**~

</div>