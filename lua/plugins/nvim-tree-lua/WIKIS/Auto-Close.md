# Background

A desirable feature is to close the tab/nvim when nvim-tree is the last window.

Unfortunately such functionality is problematic and is not present in nvim-tree:
* vim events are the only mechanism we can use for auto close
* vim events are unpredictably ordered, especially when other plugins and automation are involved
* `BufEnter` is the last event that can be acted upon and that event can have side effects
* Event nesting may be disabled by other plugins / automation, resulting in missing events

# Naive Solution

This is a minimal viable solution that will achieve the auto close functionality.

```lua
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd "quit"
    end
  end
})
```

It doesn't work if Nvim-tree window is the first and only window at startup (e.g. if you run `nvim a/directory`). Also, it will likely fail for most complex nvim setups. Consider this a starting point.

You could adopt below solutions developed by users.

# [@rwblokzijl](https://www.github.com/rwblokzijl)

[Source](https://github.com/nvim-tree/nvim-tree.lua/pull/1698#issuecomment-1312440956)

This will:
1. Close the tab if nvim-tree is the last buffer in the tab (after closing a buffer)
2. Close vim if nvim-tree is the last buffer (after closing a buffer)
3. Close nvim-tree across all tabs when one nvim-tree buffer is manually closed if and only if `tabs.sync.close` [is set](https://github.com/rwblokzijl/nvim-tree.lua/blob/sync-close-through-tabs/doc/nvim-tree-lua.txt#L364).

```lua
local function tab_win_closed(winnr)
  local api = require"nvim-tree.api"
  local tabnr = vim.api.nvim_win_get_tabpage(winnr)
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local buf_info = vim.fn.getbufinfo(bufnr)[1]
  local tab_wins = vim.tbl_filter(function(w) return w~=winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
  local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
  if buf_info.name:match(".*NvimTree_%d*$") then            -- close buffer was nvim tree
    -- Close all nvim tree on :q
    if not vim.tbl_isempty(tab_bufs) then                      -- and was not the last window (not closed automatically by code below)
      api.tree.close()
    end
  else                                                      -- else closed buffer was normal buffer
    if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
      local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
      if last_buf_info.name:match(".*NvimTree_%d*$") then       -- and that buffer is nvim tree
        vim.schedule(function ()
          if #vim.api.nvim_list_wins() == 1 then                -- if its the last buffer in vim
            vim.cmd "quit"                                        -- then close all of vim
          else                                                  -- else there are more tabs open
            vim.api.nvim_win_close(tab_wins[1], true)             -- then close only the tab
          end
        end)
      end
    end
  end
end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function ()
    local winnr = tonumber(vim.fn.expand("<amatch>"))
    vim.schedule_wrap(tab_win_closed(winnr))
  end,
  nested = true
})
```

# [@beauwilliams](https://www.github.com/beauwilliams)

[Source](https://github.com/nvim-tree/nvim-tree.lua/issues/1368#issuecomment-1195557960)

```lua
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
  end
})
```

# [@PROxZIMA](https://www.github.com/PROxZIMA)

[Source](https://github.com/nvim-tree/nvim-tree.lua/issues/1005#issuecomment-1183468091)

```lua
-- nvim-tree is also there in modified buffers so this function filter it out
local modifiedBufs = function(bufs)
    local t = 0
    for k,v in pairs(bufs) do
        if v.name:match("NvimTree_") == nil then
            t = t + 1
        end
    end
    return t
end

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and
        vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil and
        modifiedBufs(vim.fn.getbufinfo({bufmodified = 1})) == 0 then
            vim.cmd "quit"
        end
    end
})
```

# [@dmitry-semenov](https://www.github.com/dmitry-semenov)
Key binds solution, should not conflict with other plugins.

```lua
local function close_buffer_and_nvimtree(buffer_cmd, last_window_cmd)
  local tree = require("nvim-tree.api").tree
  local buffer_count = #vim.fn.filter(vim.fn.range(1, vim.fn.bufnr '$'), 'buflisted(v:val)')
  local command = buffer_count > 1 and buffer_cmd or last_window_cmd

  tree.toggle({ focus = false })

  local success, errorMsg = pcall(api.nvim_command, command)
  if not success then
    print("Failed to quit: " .. errorMsg)
  end

  tree.toggle({ focus = false })

  if buffer_count == 1 and #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
    vim.cmd("quit")
  end
end

map("n", "<Leader>q", function()
  close_buffer_and_nvimtree("bd", "q")
end, { noremap = true, silent = true })
map("n", "<Leader>x", function()
  close_buffer_and_nvimtree("bd!", "q!")
end, { noremap = true, silent = true })

```
# [@EliasA5](https://github.com/EliasA5)
A simple solution that uses the QuitPre event:

```lua
vim.api.nvim_create_autocmd({"QuitPre"}, {
    callback = function() vim.cmd("NvimTreeClose") end,
})
```

# [@ppwwyyxx](https://github.com/ppwwyyxx)
A better solution based on QuitPre that checks if it's the last window:
```lua
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
    end
  end
})
```

# [@marvinth01](https://github.com/marvinth01)
Like the QuitPre-based solution of [@ppwwyyxx](https://github.com/ppwwyyxx) above, but is also aware of floating windows:
```lua
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local tree_wins = {}
    local floating_wins = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(tree_wins, w)
      end
      if vim.api.nvim_win_get_config(w).relative ~= '' then
        table.insert(floating_wins, w)
      end
    end
    if 1 == #wins - #floating_wins - #tree_wins then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(tree_wins) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end
})
```
