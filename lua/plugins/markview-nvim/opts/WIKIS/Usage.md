# 🪄 Usage

## 🔳 Toggling table borders

> This has been taken from [#371](https://github.com/OXY2DEV/markview.nvim/issues/371)

Copy this to your `config` option,

>[!TIP]
> You can use `bb` to toggle the border. Or set the **buffer-local** variable `noborder` to disable borders.

```lua
local default = require("markview.spec").default.markdown.tables;
local no_border = require("markview.presets").tables.none;

require("markview").setup({
    markdown = {
        tables = function (buffer)
            if buffer and vim.b[buffer].noborder == true then
                -- We merge the tables to avoid issues due to
                -- options missing in the presets.
                return vim.tbl_deep_extend("force", default, no_border);
            else
                return default;
            end
        end
    }
});

-- Use `bb` to toggle table border.
vim.api.nvim_set_keymap("n", "bb", "", {
    desc = "Switch table [b]order",
    callback = function ()
        if vim.b.noborder == true then
            vim.b.noborder = false;
        else
            vim.b.noborder = true;
        end

        require("markview").commands.Render();
    end
});
```
