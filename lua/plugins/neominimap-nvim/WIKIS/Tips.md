## Disable minimap for large file

```lua
-- Either use https://github.com/folke/snacks.nvim or use the following code snippets. 
vim.g.neominimap = {
    buf_filter = function(bufnr)
        local line_count = vim.api.nvim_buf_line_count(bufnr)
        return line_count < 4096
    end
}
```

## Show minimap only for current window

```lua
-- Refresh all windows in current tab when focus switched

vim.api.nvim_create_autocmd("WinEnter", {
    group = vim.api.nvim_create_augroup("minimap", { clear = true }),
    pattern = "*",
    callback = function()
        require("neominimap").tabRefresh({}, {})
    end,
})


vim.g.neominimap = {
    layout = "float",
    win_filter = function(winid)
        return winid == vim.api.nvim_get_current_win()
    end,
}

```

## Always show signcolumn

```lua
vim.g.neominimap = {
    winopt = function (opt, winid)
        opt.signcolumn = 'yes:1'
    end
}
```

### Only Show Minimap During Search

Use key events to toggle the minimap window on and off during search navigation.

```lua
vim.on_key(function(char)
    if vim.fn.mode() == "n" then
        local is_search_nav_key = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
        if is_search_nav_key then
            vim.g.neominimap_is_in_search = true
            require("neominimap").winRefresh({}, {})
        else
            vim.g.neominimap_is_in_search = false
            require("neominimap").winRefresh({}, {})
        end
    end
end, vim.api.nvim_create_namespace("auto_search_nav"))
```

Set up `neominimap` configuration like this:

```lua
vim.g.neominimap = {
    auto_enable = true,
    win_filter = function(bufnr)
        return vim.g.neominimap_is_in_search
    end,
    layout = "float",
    search = {
        enabled = true,
        mode = "line",
    },
}
```
