# Integrations

## ph1losof/ecolog2.nvim

### nvim-lualine/lualine.nvim

Lualine integration

```lua
require("lualine").setup({
  sections = {
    lualine_c = { require("ecolog").lualine() },
  },
})
```

---

### Any status-line plugin

```lua
local ecolog = require("ecolog")

-- Statusline access
local statusline = ecolog.statusline()
statusline.is_running()            -- LSP running?
statusline.get_active_file()       -- Current file name
statusline.get_var_count()         -- Total variables
```

---

### ecolog.toml Configuration

Create `ecolog.toml` in your workspace root for LSP-level configuration:

```toml
[features]
hover = true
completion = true
diagnostics = true
definition = true

[strict]
hover = true
completion = true

[workspace]
env_files = [".env", ".env.local", ".env.*"]

[resolution]
precedence = ["Shell", "File", "Remote"]

[interpolation]
enabled = true
max_depth = 10

[cache]
enabled = true
hot_cache_size = 100
ttl = 300
```
