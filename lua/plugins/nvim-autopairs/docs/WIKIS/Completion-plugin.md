<details>
<summary><b>nvim-cmp</b></summary>

```lua
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local ts_utils = require("nvim-treesitter.ts_utils")

local ts_node_func_parens_disabled = {
  -- ecma
  named_imports = true,
  -- rust
  use_declaration = true,
}

local default_handler = cmp_autopairs.filetypes["*"]["("].handler
cmp_autopairs.filetypes["*"]["("].handler = function(char, item, bufnr, rules, commit_character)
  local node_type = ts_utils.get_node_at_cursor():type()
  if ts_node_func_parens_disabled[node_type] then
    if item.data then
      item.data.funcParensDisabled = true
    else
      char = ""
    end
  end
  default_handler(char, item, bufnr, rules, commit_character)
end

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done({
    sh = false,
  })
)
```

</details>

<details>
<summary><b>nvim-compe</b></summary>

``` lua
require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
  auto_select = false,  -- auto select first item
  map_char = { -- modifies the function or method delimiter by filetypes
    all = '(',
    tex = '{'
  }
})
```

Make sure to remove mapping insert mode `<CR>` binding if you have it.
</details>
<details>
<summary><b>completion nvim</b></summary>

``` lua
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils= {}

vim.g.completion_confirm_key = ""

MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      require'completion'.confirmCompletion()
      return npairs.esc("<c-y>")
    else
      vim.api.nvim_select_popupmenu_item(0 , false , false ,{})
      require'completion'.confirmCompletion()
      return npairs.esc("<c-n><c-y>")
    end
  else
    return npairs.autopairs_cr()
  end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

```
</details>

<details>
<summary><b>COC </b></summary>
coc-nvim

```lua
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')
npairs.setup({map_cr=false})

-- skip it, if you use another global object
_G.MUtils= {}

-- old version
-- MUtils.completion_confirm=function()
  -- if vim.fn["coc#pum#visible"]() ~= 0 then
    -- return vim.fn["coc#_select_confirm"]()
  -- else
    -- return npairs.autopairs_cr()
  -- end
-- end

-- new version for custom pum
MUtils.completion_confirm=function()
    if vim.fn["coc#pum#visible"]() ~= 0  then
        return vim.fn["coc#pum#confirm"]()
    else
        return npairs.autopairs_cr()
    end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

```

Or use this in vimscript:

```vim
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() :
	\ "\<CMD>call feedkeys(v:lua.require('nvim-autopairs').autopairs_cr(), 'in')\<CR>"
```

Explanation:

If coc pum is visible, confirm it, or else:

- Break undo sequence
- Input Expression register `i_CTRL-R_=`
- Type the result of the lua function `autopairs_cr()` (see `v:lua-call` and `feedkeys`)
	- Note: `execute` prevents the return value of `feedkeys` from being inserted 
</details>