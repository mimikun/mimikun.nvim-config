
## Integration

Avante.nvim can be extended to work with other plugins by using its extension modules. Below is an example of integrating Avante with [`nvim-tree`](https://github.com/nvim-tree/nvim-tree.lua), allowing you to select or deselect files directly from the NvimTree UI:

```lua
{
    "yetone/avante.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>a+",
            function()
                local tree_ext = require("avante.extensions.nvim_tree")
                tree_ext.add_file()
            end,
            desc = "Select file in NvimTree",
            ft = "NvimTree",
        },
        {
            "<leader>a-",
            function()
                local tree_ext = require("avante.extensions.nvim_tree")
                tree_ext.remove_file()
            end,
            desc = "Deselect file in NvimTree",
            ft = "NvimTree",
        },
    },
    opts = {
        --- other configurations
        selector = {
            exclude_auto_select = { "NvimTree" },
        },
    },
}
```