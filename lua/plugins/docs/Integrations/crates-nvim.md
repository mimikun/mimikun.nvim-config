# Integrations

## saecki/crates.nvim

### hrsh7th/nvim-cmp

#### Custom nvim-cmp kind icons

How custom icons can be added depends on how you've set up [the nvim-cmp menu](https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations).

Here's an example of how add custom icons, you might need to adapt some things.

```lua
local kind_icons = {
    ["Class"] = "🅒 ",
    ["Interface"] = "🅘 ",
    ["TypeParameter"] = "🅣 ",
    ["Struct"] = "🅢 ",
    ["Enum"] = "🅔 ",
    ["Unit"] = "🅤 ",
    ["EnumMember"] = "🅔 ",
    ["Constant"] = "🅒 ",
    ["Field"] = "🅕 ",
    ["Property"] = "🅟 ",
    ["Variable"] = "🅥 ",
    ["Reference"] = "🅡 ",
    ["Function"] = "🅕 ",
    ["Method"] = "🅜 ",
    ["Constructor"] = "🅒 ",
    ["Module"] = "🅜 ",
    ["File"] = "🅕 ",
    ["Folder"] = "🅕 ",
    ["Keyword"] = "🅚 ",
    ["Operator"] = "🅞 ",
    ["Snippet"] = "🅢 ",
    ["Value"] = "🅥 ",
    ["Color"] = "🅒 ",
    ["Event"] = "🅔 ",
    ["Text"] = "🅣 ",

    -- crates.nvim extensions
    ["Version"] = "🅥 ",
    ["Feature"] = "🅕 ",
}

require("cmp").setup({
    formatting = {
        fields = { "abbr", "kind" },
        format = function(_, vim_item)
            vim_item.kind = kind_icons[vim_item.kind] or "  "
            return vim_item
        end,
    },
})
```

