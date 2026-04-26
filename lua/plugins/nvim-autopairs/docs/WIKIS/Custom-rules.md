This page contains custom rules, that can be added to your neovim config using `add_rules` method.

## Add spaces between parentheses

| Before | Insert  |  After   |
|--------|---------|----------|
| `(\|)` | `space` | `( \| )` |
| `( \| )` | `)` | `(  )\|` |


```lua
local npairs = require'nvim-autopairs'
local Rule = require'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
  -- Rule for a pair with left-side ' ' and right side ' '
  Rule(' ', ' ')
    -- Pair will only occur if the conditional function returns true
    :with_pair(function(opts)
      -- We are checking if we are inserting a space in (), [], or {}
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1] .. brackets[1][2],
        brackets[2][1] .. brackets[2][2],
        brackets[3][1] .. brackets[3][2]
      }, pair)
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    -- We only want to delete the pair of spaces when the cursor is as such: ( | )
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({
        brackets[1][1] .. '  ' .. brackets[1][2],
        brackets[2][1] .. '  ' .. brackets[2][2],
        brackets[3][1] .. '  ' .. brackets[3][2]
      }, context)
    end)
}
-- For each pair of brackets we will add another rule
for _, bracket in pairs(brackets) do
  npairs.add_rules {
    -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
    Rule(bracket[1] .. ' ', ' ' .. bracket[2])
      :with_pair(cond.none())
      :with_move(function(opts) return opts.char == bracket[2] end)
      :with_del(cond.none())
      :use_key(bracket[2])
      -- Removes the trailing whitespace that can occur without this
      :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
  }
end
```

## Insertion with surrounding check

generalization of the first rule above

| Before | Insert  |  After   |
|--------|---------|----------|
| `(\|)` | `*` | `(*\|*)` |
| `(*\|*)` | `space` | `(* \| *)` |
| `(\|)` | `space` | `( \| )` |

```lua
function rule2(a1,ins,a2,lang)                  
  npairs.add_rule(          
    Rule(ins, ins, lang)                                   
      :with_pair(function(opts) return a1..a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1) end)
      :with_move(cond.none())                                  
      :with_cr(cond.none())                                 
      :with_del(function(opts)                    
        local col = vim.api.nvim_win_get_cursor(0)[2]                          
        return a1..ins..ins..a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
      end)                                      
  )                                             
end

rule2('(','*',')','ocaml')
rule2('(*',' ','*)','ocaml')
rule2('(',' ',')')
```

## Move past commas and semicolons

```lua
for _,punct in pairs { ",", ";" } do
    require "nvim-autopairs".add_rules {
        require "nvim-autopairs.rule"("", punct)
            :with_move(function(opts) return opts.char == punct end)
            :with_pair(function() return false end)
            :with_del(function() return false end)
            :with_cr(function() return false end)
            :use_key(punct)
    }
end
```

## Expand pair only on enter key

```lua
npairs.clear_rules()

for _,bracket in pairs { { '(', ')' }, { '[', ']' }, { '{', '}' } } do
  npairs.add_rules {
    Rule(bracket[1], bracket[2])
      :end_wise(function() return true end)
  }
end
```

## arrow key on javascript

| Before | Insert  |  After   |
|--------|---------|----------|
| `(item)=` | `>` | `(item)=> { }` |

```lua
    Rule('%(.*%)%s*%=>$', ' {  }', { 'typescript', 'typescriptreact', 'javascript' })
        :use_regex(true)
        :set_end_pair_length(2),
```
## auto addspace on =
| Before | Insert  |  After   |
|--------|---------|----------|
| `local data` | `=` | `local data = ` |
| `local data = ` | `=` | `local data ==` |

```lua
      Rule('=', '')
        :with_pair(cond.not_inside_quote())
        :with_pair(function(opts)
            local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
            if last_char:match('[%w%=%s]') then
                return true
            end
            return false
        end)
        :replace_endpair(function(opts)
            local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
            local next_char = opts.line:sub(opts.col, opts.col)
            next_char = next_char == ' ' and '' or ' '
            if prev_2char:match('%w$') then
                return '<bs> =' .. next_char
            end
            if prev_2char:match('%=$') then
                return next_char
            end
            if prev_2char:match('=') then
                return '<bs><bs>=' .. next_char
            end
            return ''
        end)
        :set_end_pair_length(0)
        :with_move(cond.none())
        :with_del(cond.none())
```

## Expand multiple pairs on enter key

Similarly to [vim-closer](https://github.com/rstacruz/vim-closer). It tries to close all of the opened pairs in that line when pressing `<CR>`.

Before:

```javascript
(function () { |
```

After pressing `<CR>`:

```javascript
(function () {
    |
})
```

```lua
-- https://github.com/rstacruz/vim-closer/blob/master/autoload/closer.vim
local get_closing_for_line = function (line)
  local i = -1
  local clo = ''

  while true do
    i, _= string.find(line, "[%(%)%{%}%[%]]", i + 1)
    if i == nil then break end
    local ch = string.sub(line, i, i)
    local st = string.sub(clo, 1, 1)

    if ch == '{' then
      clo = '}' .. clo
    elseif ch == '}' then
      if st ~= '}' then return '' end
      clo = string.sub(clo, 2)
    elseif ch == '(' then
      clo = ')' .. clo
    elseif ch == ')' then
      if st ~= ')' then return '' end
      clo = string.sub(clo, 2)
    elseif ch == '[' then
      clo = ']' .. clo
    elseif ch == ']' then
      if st ~= ']' then return '' end
      clo = string.sub(clo, 2)
    end
  end

  return clo
end

autopairs.remove_rule('(')
autopairs.remove_rule('{')
autopairs.remove_rule('[')

autopairs.add_rule(Rule("[%(%{%[]", "")
  :use_regex(true)
  :replace_endpair(function(opts)
    return get_closing_for_line(opts.line)
  end)
  :end_wise(function(opts)
    -- Do not endwise if there is no closing
    return get_closing_for_line(opts.line) ~= ""
  end))
```
##  dynamic add pair text after start.
| Before | Insert  |  After   |
|--------|---------|----------|
| `\startmove` | `space` | `\stopmove ` |


```lua

pairs.add_rules({
    Rule("\\start(%w*) $", "tex")
        :replace_endpair(function(opts)
            local beforeText = string.sub(opts.line, 0, opts.col)
            local _, _, match = beforeText:find("\\start(%w*)")
            if match and #match > 0 then
                return " \\stop" .. match
            end
            return ''
        end)
        :with_move(cond.none())
        :use_key("<space>")
        :use_regex(true)
})
```

## auto-pair `<>` for generics but not as greater-than/less-than operators

```lua
npairs.add_rule(Rule('<', '>', {
  -- if you use nvim-ts-autotag, you may want to exclude these filetypes from this rule
  -- so that it doesn't conflict with nvim-ts-autotag
  '-html',
  '-javascriptreact',
  '-typescriptreact',
}):with_pair(
  -- regex will make it so that it will auto-pair on
  -- `a<` but not `a <`
  -- The `:?:?` part makes it also
  -- work on Rust generics like `some_func::<T>()`
  cond.before_regex('%a+:?:?$', 3)
):with_move(function(opts)
  return opts.char == '>'
end))
```

## auto center the current line when inserting enter inside curly brackets

Use [LZDQ/nvim-autocenter](https://github.com/LZDQ/nvim-autocenter), or use the following lua script:

```lua
require("nvim-autopairs").get_rule("{"):replace_map_cr(function()
	local res = '<c-g>u<CR><CMD>normal! ====<CR><up><end><CR>'
	local line = vim.fn.winline()
	local height = vim.api.nvim_win_get_height(0)
	-- Check if current line is within [1/3, 2/3] of the screen height.
	-- If not, center the current line.
	if line < height / 3 or height * 2 / 3 < line then
		-- Here, 'x' is a placeholder to make sure the indentation doesn't break.
		res = res .. 'x<ESC>zzs'
	end
	return res
end)
```

## When typing space equals for assignment in Nix, add the final semicolon to the line

```lua
local npairs = require'nvim-autopairs'
local Rule = require("nvim-autopairs.rule")
local ts_conds = require('nvim-autopairs.ts-conds')
local log = require('nvim-autopairs._log')
local utils = require('nvim-autopairs.utils')

-- Note that when the cursor is at the end of a comment line,
-- treesitter thinks we are in attrset_expression
-- because the cursor is "after" the comment, even though it is on the same line.
local is_not_ts_node_comment_one_back = function()
    return function(info)
        log.debug('not_in_ts_node_comment_one_back')

        local p = vim.api.nvim_win_get_cursor(0)
        -- Subtract one to account for 1-based row indexing in nvim_win_get_cursor
        -- Also subtract one from the position of the column to see if we are at the end of a comment.
        local pos_adjusted = {p[1] - 1, p[2] - 1}

        vim.treesitter.get_parser():parse()
        local target = vim.treesitter.get_node({ pos = pos_adjusted, ignore_injections = false })
        log.debug(target:type())
        if target ~= nil and utils.is_in_table({'comment'}, target:type()) then
            return false
        end

        local rest_of_line = info.line:sub(info.col)
        return rest_of_line:match('^%s*$') ~= nil
    end
end

npairs.add_rule(
  Rule("= ", ";", "nix")
    :with_pair(is_not_ts_node_comment_one_back())
    :set_end_pair_length(1)
)
```

## Add trailing commas to `"'}` inside Lua tables

Extremely useful when editing neovim config

```lua
local npairs = require'nvim-autopairs'
local Rule = require("nvim-autopairs.rule")
local ts_conds = require('nvim-autopairs.ts-conds')

npairs.add_rules({
  Rule("{", "},", "lua"):with_pair(ts_conds.is_ts_node({ "table_constructor" })),
  Rule("'", "',", "lua"):with_pair(ts_conds.is_ts_node({ "table_constructor" })),
  Rule('"', '",', "lua"):with_pair(ts_conds.is_ts_node({ "table_constructor" })),
})
```