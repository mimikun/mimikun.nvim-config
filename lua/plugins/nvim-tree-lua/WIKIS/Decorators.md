Please share your custom decorators.

See `:help nvim-tree-decorators` for documentation and example `:help nvim-tree-decorator-example`

See [_meta/api_decorator.lua](https://github.com/nvim-tree/nvim-tree.lua/blob/master/lua/nvim-tree/_meta/api_decorator.lua) for `nvim_tree.api.decorator.UserDecorator` class documentation.
See [_meta/api.lua](https://github.com/nvim-tree/nvim-tree.lua/blob/master/lua/nvim-tree/_meta/api.lua) for `nvim_tree.api.Node` classes documentation.

# Quickfix Decorator

[@b0o](https://www.github.com/b0o)

Highlights files which are in your quickfix list.
![2024-12-01_17-39-39_region](https://github.com/user-attachments/assets/bb552b3f-414d-4d5d-9b9e-da85df4959b2)

```lua
---@class (exact) QuickfixDecorator: nvim_tree.api.decorator.UserDecorator
---@field private qf_icon nvim_tree.api.HighlightedString
local QuickfixDecorator = require('nvim-tree.api').decorator.UserDecorator:extend()

local augroup = vim.api.nvim_create_augroup('nvim-tree-quickfix-decorator', { clear = true })

local autocmds_setup = false
local function setup_autocmds()
  if autocmds_setup then
    return
  end
  autocmds_setup = true
  vim.api.nvim_create_autocmd('QuickfixCmdPost', {
    group = augroup,
    callback = function() require('nvim-tree.api').tree.reload() end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    group = augroup,
    callback = function(evt)
      vim.api.nvim_create_autocmd('TextChanged', {
        buffer = evt.buf,
        group = augroup,
        callback = function() require('nvim-tree.api').tree.reload() end,
      })
    end,
  })
end

function QuickfixDecorator:new()
  self.enabled = true
  self.highlight_range = 'all'
  self.icon_placement = 'signcolumn'
  self.qf_icon = { str = '', hl = { 'QuickFixLine' } }
  self:define_sign(self.qf_icon)
  setup_autocmds()
end

---Helper function to check if a node is in quickfix list
---@param node nvim_tree.api.Node
---@return boolean
local function is_qf_item(node)
  if node.name == '..' or node.type == 'directory' then
    return false
  end
  local bufnr = vim.fn.bufnr(node.absolute_path)
  return bufnr ~= -1 and vim.iter(vim.fn.getqflist()):any(function(qf) return qf.bufnr == bufnr end)
end

---Return quickfix icons for the node
---@param node nvim_tree.api.Node
---@return nvim_tree.api.HighlightedString[]? icons
function QuickfixDecorator:icons(node)
  if is_qf_item(node) then
    return { self.qf_icon }
  end
  return nil
end

---Return highlight group for the node
---@param node nvim_tree.api.Node
---@return string? highlight_group
function QuickfixDecorator:highlight_group(node)
  if is_qf_item(node) then
    return 'QuickFixLine'
  end
  return nil
end

return QuickfixDecorator
```

# Reference Example

A decorator class for nodes named "example", overridind all builtin decorators
except for Cut.

- Highlights node name with `IncSearch`
- Creates two icons `"1"` and `"2"` placed after the node name, highlighted with
  `DiffAdd` and `DiffText`
- Replaces the node icon with `"N"`, highlighted with `Error `

Create a class file `~/.config/nvim/lua/my-decorator.lua`

Require and register it during setup:

```lua
local MyDecorator = require("my-decorator")

require("nvim-tree").setup({
  renderer = {
    decorators = {
      "Git",
      "Open",
      "Hidden",
      "Modified",
      "Bookmark",
      "Diagnostics",
      "Copied",
      MyDecorator,
      "Cut",
    },
  },
})
```

Contents of `my-decorator.lua`:

```lua
---@class (exact) MyDecorator: nvim_tree.api.decorator.UserDecorator
---@field private my_icon1 nvim_tree.api.HighlightedString
---@field private my_icon2 nvim_tree.api.HighlightedString
---@field private my_icon_node nvim_tree.api.HighlightedString
---@field private my_highlight_group string
local MyDecorator = require("nvim-tree.api").decorator.UserDecorator:extend()

---Mandatory constructor  :new()  will be called once per tree render, with no arguments.
function MyDecorator:new()
  self.enabled            = true
  self.highlight_range    = "name"
  self.icon_placement     = "after"

  -- create your icons and highlights once, applied to every node
  self.my_icon1           = { str = "1", hl = { "DiffAdd" } }
  self.my_icon2           = { str = "2", hl = { "DiffText" } }
  self.my_icon_node       = { str = "N", hl = { "Error" } }
  self.my_highlight_group = "IncSearch"

  -- Define the icon signs only once
  -- Only needed if you are using icon_placement = "signcolumn"
  -- self:define_sign(self.my_icon1)
  -- self:define_sign(self.my_icon2)
end

---Override node icon
---@param node nvim_tree.api.Node
---@return nvim_tree.api.HighlightedString? icon_node
function MyDecorator:icon_node(node)
  if node.name == "example" then
    return self.my_icon_node
  else
    return nil
  end
end

---Return two icons for DecoratorIconPlacement "after"
---@param node nvim_tree.api.Node
---@return nvim_tree.api.HighlightedString[]? icons
function MyDecorator:icons(node)
  if node.name == "example" then
    return { self.my_icon1, self.my_icon2, }
  else
    return nil
  end
end

---Exactly one highlight group for DecoratorHighlightRange "name"
---@param node nvim_tree.api.Node
---@return string? highlight_group
function MyDecorator:highlight_group(node)
  if node.name == "example" then
    return self.my_highlight_group
  else
    return nil
  end
end

return MyDecorator
```
