# Integrations

## rvaccone/wind.nvim

### nvim-lualine/lualine.nvim

`require("wind").lualine_index()` returns the index of the window being
drawn, for both active and inactive windows. Example for lualine:

```lua
local function wind_index()
    local ok, wind = pcall(require, "wind")
    return ok and wind.lualine_index() or ""
end

require("lualine").setup({
    sections = { lualine_a = { wind_index } },
    inactive_sections = { lualine_a = { wind_index } },
})
```

