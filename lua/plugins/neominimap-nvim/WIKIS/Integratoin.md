This page describes how to integrate neominimap with other plugins.

## Integrating with [statuscol](https://github.com/luukvbaal/statuscol.nvim)

First, in the `neominimap` configuration, set `mode = "sign"` for the handlers
that you want to display in the sign column.

For example:

```lua
vim.g.neominimap = {
    auto_enable = true,
    diagnostic = {
        mode = "line",
    },
    git = {
        enabled = true,
        mode = "sign",
    },
    search = {
        enabled = true,
        mode = "sign",
    },
}
```

Next, define a wrapper function to safely invoke `StatusCol`.

```lua
_G.MyStatusCol = function()
    local ok, _ = pcall(require, "statuscol") -- Make sure statuscol is installed and loaded.
    if ok then
        --  For latest
        -- return statuscol.get_statuscol_string()

        -- For version 0.10
        return _G.StatusCol()
    else
        return ""
    end
end

vim.g.neominimap = {
    winopt = function(wo)
        wo.statuscolumn = "%!v:lua.MyStatusCol()"
    end
}
```

Finally, filter out segments for normal buffers and minimap buffers.

Here is an example:

```lua
local function is_neominimap(arg)
    return vim.bo[arg.buf].filetype == "neominimap"
end

local function is_not_neominimap(arg)
    return not is_neominimap(arg)
end

return {
    "luukvbaal/statuscol.nvim",
    opts = function()
        local builtin = require("statuscol.builtin")
        return {
            setopt = true,
            relculright = true,
            segments = {
              -- These segments will be shown for normal buffers
              {
                  sign = {
                      namespace = { ".*" },
                      name = { ".*" },
                  },
                  condition = { is_not_neominimap },
              },
              {
                  text = {
                      builtin.lnumfunc,
                      " ",
                      builtin.foldfunc,
                  },
                  condition = { is_not_neominimap },
              },
              {
                  sign = {
                      namespace = { "gitsigns_" },
                  },
                  condition = { is_not_neominimap },
              },

              -- These segments will be shown for minimap buffers
              {
                  sign = {
                      namespace = { "neominimap_search" },
                      maxwidth = 1,
                      colwidth = 1, -- For more compact look
                  },
                  condition = { is_neominimap },
              },
              {
                  sign = {
                      namespace = { "neominimap_git" },
                      maxwidth = 1,
                      colwidth = 1,
                  },
                  condition = { is_neominimap },
              },
            },
        }
    end,
}
```


## Disable minimap on start screen

```lua
local is_float_window = function(winid)
  return vim.api.nvim_win_get_config(winid).relative ~= ""
end

vim.g.neominimap = {
  tab_filter = function(tab_id)
    local win_list = vim.api.nvim_tabpage_list_wins(tab_id)
    local exclude_ft = { "alpha", "neominimap", "snacks_dashboard" }
    for _, win_id in ipairs(win_list) do
      if not is_float_window(win_id) then
        local bufnr = vim.api.nvim_win_get_buf(win_id)
        if not vim.tbl_contains(exclude_ft, vim.bo[bufnr].filetype) then
          return true
        end
      end
    end
    return false
  end,
}

```

## Toggling by [snack.toggle](https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md)

Create the following autocmd

```lua
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = vim.api.nvim_create_augroup("setup_neominimap", { clear = true }),
  callback = function()
    Snacks.toggle({
      name = "minimap",
      get = function() return require("neominimap.api").enabled() end,
      set = function(state)
        if state then
          require("neominimap.api").enable()
        else
          require("neominimap.api").disable()
        end
      end,
    }):map("<LEADER>mm")
    Snacks.toggle({
      name = "minimap for buffer",
      get = function() return require("neominimap.api").buf.enabled() end,
      set = function(state)
        if state then
          require("neominimap.api").buf.enable()
        else
          require("neominimap.api").buf.disable()
        end
      end,
    }):map("<LEADER>mb")
    Snacks.toggle({
      name = "minimap for window",
      get = function() return require("neominimap.api").win.enabled() end,
      set = function(state)
        if state then
          require("neominimap.api").win.enable()
        else
          require("neominimap.api").win.disable()
        end
      end,
    }):map("<LEADER>mw")
    Snacks.toggle({
      name = "minimap for tabpage",
      get = function() return require("neominimap.api").tab.enabled() end,
      set = function(state)
        if state then
          require("neominimap.api").tab.enable()
        else
          require("neominimap.api").tab.disable()
        end
      end,
    }):map("<LEADER>mt")
    Snacks.toggle({
      name = "focus",
      get = function() return vim.bo.ft == "neominimap" end,
      set = function(state)
        if state then
          require("neominimap.api").focus.enable()
        else
          require("neominimap.api").focus.disable()
        end
      end,
    }):map("<LEADER>mf")
  end,
})                                              
```

