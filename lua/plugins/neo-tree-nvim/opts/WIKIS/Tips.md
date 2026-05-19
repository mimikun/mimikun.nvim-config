This page is for smaller "tips and tricks" that users want to share with others. This is where to put information that, while technically documented, you feel is not obvious and should be highlighted for others to find.

## Open file without losing sidebar focus

[Discussion #249](https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/249) answered by [@cseickel](https://github.com/cseickel)

```lua
["<tab>"] = function(state)
  state.commands["open"](state)
  vim.cmd("Neotree reveal")
end,
```

Alternative version by [@nyngwang](https://github.com/nyngwang):

```lua
['<tab>'] = function (state)
  local node = state.tree:get_node()
  if require("neo-tree.utils").is_expandable(node) then
    state.commands["toggle_node"](state)
  else
    state.commands['open'](state)
    vim.cmd('Neotree reveal')                  
  end
end,
```

Read comment here: https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/249#discussioncomment-2585963

## Navigation with HJKL

[Discussion #163](https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/163) answered by [@bennypowers](https://github.com/bennypowers)

```lua
["h"] = function(state)
  local node = state.tree:get_node()
    if node.type == 'directory' and node:is_expanded() then
      require'neo-tree.sources.filesystem'.toggle_directory(state, node)
    else
      require'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
    end
  end,
["l"] = function(state)
  local node = state.tree:get_node()
    if node.type == 'directory' then
      if not node:is_expanded() then
        require'neo-tree.sources.filesystem'.toggle_directory(state, node)
      elseif node:has_children() then
        require'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
      end
    end
  end,
```

## Hijacking netrw when loading neo-tree lazily

[#1247 (feature request)](https://github.com/nvim-neo-tree/neo-tree.nvim/issues/1247)

Add the following to any `init` function (preferably neo-tree's or netman's):
<details><summary>If using netrw</summary>

```lua
vim.api.nvim_create_autocmd('BufNewFile', {
  group    = vim.api.nvim_create_augroup('RemoteFile', {clear = true}),
  callback = function()
    local f = vim.fn.expand('%:p')
    for _, v in ipairs{'sftp', 'scp', 'ssh', 'dav', 'fetch', 'ftp', 'http', 'rcp', 'rsync'} do
      local p = v .. '://'
      if string.sub(f, 1, #p) == p then
        vim.cmd[[
          unlet g:loaded_netrw
          unlet g:loaded_netrwPlugin
          runtime! plugin/netrwPlugin.vim
          silent Explore %
        ]]
        vim.api.nvim_clear_autocmds{group = 'RemoteFile'}
        break
      end
    end
  end
})
```
</details>
<details><summary>If using netman.nvim</summary>

```lua
vim.api.nvim_create_autocmd('BufNewFile', {
  group    = vim.api.nvim_create_augroup('NetmanInit', {clear = true}),
  callback = function()
    local f = vim.fn.expand('%:p')
    for _, v in ipairs{'sftp', 'scp', 'ssh', 'docker'} do
      local p = v .. '://'
      if string.sub(f, 1, #p) == p then
        vim.defer_fn(function()
          require'netman'.read(f)
        end, 0)
        vim.api.nvim_clear_autocmds{group = 'NetmanInit'}
        break
      end
    end
  end
})
--- optional part if you still want to use netrw for files unsupported by netman.nvim
--- these need to be two separate AUgroups, don't combine them
vim.api.nvim_create_autocmd('BufNewFile', {
  group    = vim.api.nvim_create_augroup('UnsupportedRemoteFile', {clear = true}),
  callback = function()
    local f = vim.fn.expand('%:p')
    for _, v in ipairs{'dav', 'fetch', 'ftp', 'http', 'rcp', 'rsync'} do
      local p = v .. '://'
      if string.sub(f, 1, #p) == p then
        vim.cmd[[
          unlet g:loaded_netrw
          unlet g:loaded_netrwPlugin
          runtime! plugin/netrwPlugin.vim
          silent Explore %
        ]]
        vim.api.nvim_clear_autocmds{group = 'UnsupportedRemoteFile'}
        break
      end
    end
  end
})
```
</details>