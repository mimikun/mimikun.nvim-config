Got a cool or useful snippet that you'd like to ~show off~ share with the community?  
Do it here! Make sure to include a short description to find snippets for a specific filetype. Other users will also surely appreciate a short explaination of that weird pattern or the 100-line dynamicNode you used ;)

## Lua - New module function
Use Treesitter to determine the name of the variable returned from the module and use that as the function's parent, with a choice node to swap between static function (`Module.fn_name`) vs. instance method (`Module:fn_name`) syntax.
```lua
s(
  'mfn',
  c(1, {
    fmt('function {}.{}({})\n  {}\nend', {
      f(get_returned_mod_name, {}),
      i(1),
      i(2),
      i(3),
    }),
    fmt('function {}:{}({})\n  {}\nend', {
      f(get_returned_mod_name, {}),
      i(1),
      i(2),
      i(3),
    }),
  })
)
```
![CleanShot 2022-12-22 at 08 25 35](https://user-images.githubusercontent.com/8648891/209146598-8846c3e0-2673-43bb-8a36-76ff0d119d78.gif)


## LaTeX

### Endless List
:warning: This is pretty hackish, and is just meant to how far luasnip can be pushed.
For actual use, the [external update DynamicNode](https://github.com/L3MON4D3/LuaSnip/wiki/Misc#dynamicnode-with-user-input) is more capable, snippets are more readable, and its behaviour in is plain better (eg. doesn't lead to deeply nested snippets)  
Of course, this is just a recommendation :)
```lua
local rec_ls
rec_ls = function()
	return sn(nil, {
		c(1, {
			-- important!! Having the sn(...) as the first choice will cause infinite recursion.
			t({""}),
			-- The same dynamicNode as in the snippet (also note: self reference).
			sn(nil, {t({"", "\t\\item "}), i(1), d(2, rec_ls, {})}),
		}),
	});
end

...

s("ls", {
	t({"\\begin{itemize}",
	"\t\\item "}), i(1), d(2, rec_ls, {}),
	t({"", "\\end{itemize}"}), i(0)
})
```

This snippet first expands to
```latex
\begin{itemize}
	\item $1
\end{itemize}
```
upon jumping into the `dynamicNode` and changing the choice, another `dynamicNode` (and with it, `\item`) will be inserted.
As the `dynamicNode` is recursive, it's possible to insert as many `\item`s' as desired.

![ls_showcase](https://user-images.githubusercontent.com/41961280/139741702-51f38302-0d6a-4b94-9cd4-ac39bbe364b1.gif)

(The gif also showcases Luasnips ability to preserve input to collapsed choices!)

### Context-aware Snippets

```lua
local tex = {}
tex.in_mathzone = function()
        return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex.in_text = function()
        return not tex.in_mathzone()
end

...

s("dm", {
	t({ "\\[", "\t" }),
	i(1),
	t({ "", "\\]" }),
}, { condition = tex.in_text })
```
This snippet will only expand in text so that you may type `dm` safely in math environments. For other environments, use this multipurpose function: 

> Note: requires [VimTeX](https://github.com/lervag/vimtex) for this to work.

```lua 
local function env(name) 
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

-- Example: use only in TikZ environments. Note a helper for each environment has to be defined.
local function tikz()
    return env("tikzpicture")
end
```

You can even make snippets that only expand in certain commands and syntax groups with VimTeX. Note this is a bit tricky as you may have to play around and evaluate the syntax group you want to target. Some helpful links as well:
- [VimTeX Documentation on syntax group reference](https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt#L5104)
- [VimTeX source on syntax groups](https://github.com/lervag/vimtex/tree/master/autoload/vimtex/syntax)

General function code and example:
```lua
local function cmd(name)
	return vim.fn["vimtex#syntax#in"](name) == 1
end

-- this will only expand \SI{}{<here>} in the \SI command
function M.in_siunitx()
    return cmd("texSIArgUnit")
end
```

Moreover, using the following condition,
the snippet will only be expanded in `beamer` documents.

```lua
tex.in_beamer = function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	for _, line in ipairs(lines) do
		if line:match("\\documentclass{beamer}") then
			return true
		end
	end
	return false
end
-- or, use `vimtex` to detect
-- tex.in_beamer = function()
-- 	return vim.b.vimtex["documentclass"] == "beamer"
-- end

...

s("bfr", {
	t({ "\\begin{frame}", "\t\\frametitle{" }),
	i(1, "frame title"),
	t({ "}", "\t" }),
	i(0),
	t({ "", "\\end{frame}" }),
}, { condition = tex.in_beamer })
```

Indeed, you may combine some of the conditions to build your own context-aware snippets.

A possible use case is using snippets of the corresponding language in `minted` environments (which also uses [Condition Objects](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#condition-objects) and requires [VimTeX](https://github.com/lervag/vimtex)). 

```lua
-- Imports, Define Conditions
local conds = require("luasnip.extras.expand_conditions")
local make_condition = require("luasnip.extras.conditions").make_condition

local function tex()
    return vim.bo.filetype == "tex"
end

local function python()
    return vim.bo.filetype == "python"
end

local function mintedPython()
    return vim.fn['vimtex#syntax#in']("texMintedZonePython") == 1
end

local pyfile = make_condition(python)
local texfile = make_condition(tex)
local pymint = make_condition(mintedPython)

-- example snippet 
autosnippet(
    "pytest",
	{ t("this triggers only in python files, or in tex files with minted enabled with python") },
	{ condition = pyfile + (texfile * pymint), show_condition = pyfile + (texfile * pymint) }
	),
```
![codetest](https://evesdropper.dev/assets/gif/codetest-revised.gif)


### Tabular
With this snippet you can dynamically generate a table. It contain two main
function. The first function return a snipnode which includes an insert node for
each column defined by the user. 
```lua 
table_node= function(args)
	local tabs = {}
	local count
	table = args[1][1]:gsub("%s",""):gsub("|","")
	count = table:len()
	for j=1, count do
		local iNode
		iNode = i(j)
		tabs[2*j-1] = iNode
		if j~=count then
			tabs[2*j] = t" & "
		end
	end
	return sn(nil, tabs)
end
```
The second one it is based on the `rec_ls` function from endless list entry.
```lua
rec_table = function ()
	return sn(nil, {
		c(1, {
			t({""}),
			sn(nil, {t{"\\\\",""} ,d(1,table_node, {ai[1]}), d(2, rec_table, {ai[1]})})
		}),
	});
end
```
Based on those functions, the snips will be 
```lua
s("table", {
	t"\\begin{tabular}{",
	i(1,"0"),
	t{"}",""},
	d(2, table_node, {1}, {}),
	d(3, rec_table, {1}),
	t{"","\\end{tabular}"}
}),
```
![Peek 2022-06-01 16-31](https://user-images.githubusercontent.com/68747055/171431041-0469ba4b-4e18-411e-8b03-d82332a41f10.gif)

### Integrals
A snippet to support multiple integrals with support for surface/volume integrals as well, which uses dynamic nodes with choice nodes.

```lua 
-- integral functions
-- generate \int_{<>}^{<>}
local int1 = function(args, snip)
    local vars = tonumber(snip.captures[1])
    local nodes = {}
    for j = 1, vars do
	table.insert(nodes, t("\\int_{"))
	table.insert(nodes, r(2*j-1, "lb" .. tostring(j), i(1))) -- thanks L3MON4D3 for finding the index issue
	table.insert(nodes, t("}^{"))
	table.insert(nodes, r(2*j, "ub" .. tostring(j), i(1))) -- please remember to count and don't be like me
	table.insert(nodes, t("} "))
    end
    return sn(nil, nodes)
end

-- generate \dd <>
local int2 = function(args, snip)
    local vars = tonumber(snip.captures[1])
    local nodes = {}
    for j = 1, vars do
	table.insert(nodes, t(" \\dd "))
	table.insert(nodes, r(j, "var" .. tostring(j), i(1)))
    end
    return sn(nil, nodes)
end


autosnippet(
    { trig = "(%d)int", name = "multi integrals", dscr = "please work", regTrig = true, hidden = false },
    fmt([[ 
    <> <> <> <>
    ]],{c(1, { fmta([[
    \<><>nt_{<>}
    ]], {c(1, { t(""), t("o") }),
	f(function(_, parent, snip)
	    inum = tonumber(parent.parent.captures[1]) -- this guy's lineage looking like a research lab's
	    res = string.rep("i", inum)
	    return res
	end), i(2),}), d(nil, int1),}),
	i(2), d(3, int2), i(0),},
        { delimiters = "<>" }),
	{ condition = math, show_condition = math }),

```

![integral](https://user-images.githubusercontent.com/82856360/210464574-10121fce-097c-4579-91b9-9efa4f05f666.gif)

### Custom Labels/References

Use choice and dynamic nodes with `user_args` to generate concise and clear labels to be referenced in math notes. Additional second argument supports a personal preamble setup with `tcolorbox` and `newenvironmentx, xargs`.

```lua
-- personal util 
local function isempty(s) --util 
    return s == nil or s == ''
end

-- label util 
local generate_label = function(args, parent, _, user_arg1, user_arg2)
    if user_arg2 ~= "xargs" then
        delims = {"\\label{", "}"} -- chooses surrounding environment based on arg2 - tcolorboxes use xargs
    else
        delims = {"[", "]"}
    end
    if isempty(user_arg1) then  -- creates a general label
        return sn(nil, fmta([[
        \label{<>}
        ]], {i(1)}))
    else
        return sn(nil, fmta([[ -- creates a specialized label
        <><>:<><>
        ]], {t(delims[1]), t(user_arg1), i(1), t(delims[2])}))
    end
end

-- generates \section{$1}(\label{sec:$1})?
s(
    { trig = "#", hidden = true, priority = 250 },
    fmt(
    [[
    \section{<>}<>
    <>]],
    { i(1), c(2, {t(""), d(1, generate_label, {}, {user_args={"sec"}} )
    }), i(0) },
    { delimiters = "<>" }
    )
),

-- generates \begin{definition}[$1]([def:$2])?{ ...
s(
    { trig = "adef", name = "add definition", dscr = "add definition box" },
    fmt(
    [[ 
    \begin{definition}[<>]<>{<>
    }
    \end{definition}]],
    { i(1), c(2, {t(""), d(1, generate_label, {}, {user_args={"def", "xargs"}})}), i(0) },
    { delimiters = "<>" }
    )
),
```
![labels](https://user-images.githubusercontent.com/82856360/216792775-b9ac7b6f-59a6-44ce-8e2a-de8ab556c72d.gif)

### Smart Postfix Snippets
For commands like `\bar{}`, `\hat{}`, a postfix snippet may be useful. e.g. `xbar` turns into `\bar{x}` and so on. But postfix captures are not always the best for certain phrases, such as those with spaces or special characters. But with this dynamic postfix snippet, you can turn that around and even incorporate visual mode.

The idea is:
- If we have a postfix snippet capture, then we go about and surround the capture with the surrounding command. e.g. `xbar` turns into `\bar{x}` and our cursor is outside of the command.
- If we have something that's hard to capture, we have two methods to go about this: either 1. visual mode - so then the trigger will surround the capture with the option to insert more text, e.g. if we have `#$%^&*` saved as visual, then we get `\bar{(#$%^&|insert)}`, or 2. regular insert node if we have no visual capture, so `bar` gives us `\bar{<>}`, where `<>` denotes an insert node. In both methods, the cursor stays inside the command for you to edit freely.

Here's the implementation, a sample snippet, and a demo:
```lua
-- dynamic node
-- generally, postfix comes in the form PRE-CAPTURE-POST, so in this case, arg1 is the "pre" text, arg2 the "post" text
local dynamic_postfix = function(_, parent, _, user_arg1, user_arg2) 
    local capture = parent.snippet.env.POSTFIX_MATCH
    if #capture > 0 then
        return sn(nil, fmta([[
        <><><><>
        ]],
        {t(user_arg1), t(capture), t(user_arg2), i(0)}))
    else
        local visual_placeholder = ""
        if #parent.snippet.env.SELECT_RAW > 0 then
            visual_placeholder = parent.snippet.env.SELECT_RAW
        end
        return sn(nil, fmta([[
        <><><><>
        ]],
        {t(user_arg1), i(1, visual_placeholder), t(user_arg2), i(0)}))
    end
end

postfix({ trig="vec", snippetType = "autosnippet"},
    {d(1, dynamic_postfix, {}, { user_args = {"\\vec{", "}"} })},
    { condition = tex.in_math, show_condition = tex.in_math }
    ),
```

![dynamic-postfix](https://user-images.githubusercontent.com/82856360/227691655-ba7260c6-8007-43fc-97c0-5976007271c8.gif)


## All - Pairs
```lua
local function char_count_same(c1, c2)
	local line = vim.api.nvim_get_current_line()
	-- '%'-escape chars to force explicit match (gsub accepts patterns).
	-- second return value is number of substitutions.
	local _, ct1 = string.gsub(line, '%'..c1, '')
	local _, ct2 = string.gsub(line, '%'..c2, '')
	return ct1 == ct2
end

local function even_count(c)
	local line = vim.api.nvim_get_current_line()
	local _, ct = string.gsub(line, c, '')
	return ct % 2 == 0
end

local function neg(fn, ...)
	return not fn(...)
end

local function part(fn, ...)
	local args = {...}
	return function() return fn(unpack(args)) end
end

-- This makes creation of pair-type snippets easier.
local function pair(pair_begin, pair_end, expand_func, ...)
	-- triggerd by opening part of pair, wordTrig=false to trigger anywhere.
	-- ... is used to pass any args following the expand_func to it.
	return s({trig = pair_begin, wordTrig=false},{
			t({pair_begin}), i(1), t({pair_end})
		}, {
			condition = part(expand_func, part(..., pair_begin, pair_end))
		})
end

...
-- these should be inside your snippet-table.
pair("(", ")", neg, char_count_same),
pair("{", "}", neg, char_count_same),
pair("[", "]", neg, char_count_same),
pair("<", ">", neg, char_count_same),
pair("'", "'", neg, even_count),
pair('"', '"', neg, even_count),
pair("`", "`", neg, even_count),
```

These snippets make use of the expand-condition to only trigger if a closing end of the pair is missing (lots of false positives and negatives, eg. if the closing part from a paren higher up in the text is on the current line, but it works more oft than not).  
Another nice thing is using a function to create similar snippets.

## All - Insert space when the next character after snippet is a letter
```lua
  s("mk", {
    t("$"), i(1), t("$")
  },{
    callbacks = {
      -- index `-1` means the callback is on the snippet as a whole
      [-1] = {
        [events.leave] = function ()
          vim.cmd([[
            autocmd InsertCharPre <buffer> ++once lua _G.if_char_insert_space()
          ]])
        end
      }
    }
  }),
```
```lua
_G.if_char_insert_space = function ()
  if string.find(vim.v.char, "%a") then
    vim.v.char = " " .. vim.v.char
  end
end
```
This snippet has the following behavior after expansion: `|` represents the cursor
- `$|$` jump -> `$$|` insert any letter -> `$$ a`
  - `$$|` insert anything else -> `$$.`

see `:h InsertCharPre` if you want to understand how it works.

## Rust - Common snippets 🦀 

Here are some Rust snippets to make your life a bit easier.

### 🦀 Atributes
- **derivedebug** expands to the outer attribute: ``#[derive(Debug)]``
- **deadcode** expands to the outer attribute:  ``#[allow(dead_code)]``
- **allowfreedom** expands to the inner attribute: ``#![allow(clippy::disallowed_names, unused_variables, dead_code)]``
- **clippypedantic** expands to the inner attribute: ``#![warn(clippy::all, clippy::pedantic)]``

### 🦀 Println

**print** expands to:
- ``println!("(1) {:?}", (0));``  
or:
- ``println!("(1) {(0):?}");``  
(Comment one out)

### 🦀 Turbofish

**:turbofish** expands to:
```rust
::<$0>
```

### 🦀 For loop

**for** expands to:
```rust
for (1) in (2) {
    (0)
}
```

### 🦀 Struct

**struct** expands to:
```rust
#[derive(Debug)]
struct (1) {
    (0)
}
```

### 🦀 Tests

**test** expands to:
```rust
#[test]
fn (1) () {
    assert (0)
}
```

**testcfg** expands to:
```rust 
#[cfg(test)]
mod (1) {
    #[test]
    fn (2) () {
        assert (0)
    }
}
```

### 🦀 Source
```lua
rust = {

  s('derivedebug', t '#[derive(Debug)]'),
  s('deadcode', t '#[allow(dead_code)]'),
  s('allowfreedom', t '#![allow(clippy::disallowed_names, unused_variables, dead_code)]'),

  s('clippypedantic', t '#![warn(clippy::all, clippy::pedantic)]'),

  s(':turbofish', { t {'::<'}, i(0), t {'>'} }),

  s('print', {
    -- t {'println!("'}, i(1), t {' {:?}", '}, i(0), t {');'}}),
    t {'println!("'}, i(1), t {' {'}, i(0), t {':?}");'}}),

  s('for',
  {
  t {'for '}, i(1), t {' in ' }, i(2), t {' {', ''},
        i(0),
  t {'}', ''},
  }),

  s('struct',
  {
    t {'#[derive(Debug)]', ''},
    t {'struct '}, i(1), t {' {', ''},
      i(0),
    t {'}', ''},
  }),

  s('test',
  {
      t {'#[test]', ''},
      t {'fn '}, i(1), t {'() {', ''},
      t {'	assert'}, i(0), t {'', ''},
      t {'}'},
  }),

  s('testcfg',
  {
    t {'#[cfg(test)]', ''},
    t {'mod '}, i(1), t {' {', ''},
    t {'	#[test]', ''},
    t {'	fn '}, i(2), t {'() {', ''},
    t {'		assert'}, i(0), t {'', ''},
    t {'	}', ''},
    t {'}'},
  }),

  s('if',
  {
    t {'if '}, i(1), t {' {', ''},
     i(0),
    t {'}'},
  }),
},

```

## Python

### Function definition with dynamic virtual text
The following snippet expands to a function definition in Python and has `choiceNode`s for if a return declaration should be used and what doc-string to use:
* None.
* Single line.
* Multiline with `Args`/`Returns`.

The `choiceNode` of the doc-string is manipulated to show different virtual text for the different choices to make it easy to now which one your in. This way of doing it is a sort of prototype and will be easier in the future. See discussion on #291.

The full snippet can be improved a lot to for example add the correct arguments from the function to the mulitline doc-string automatically.

```lua
local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local fmt = require('luasnip.extras.fmt').fmt
local types = require("luasnip.util.types")

local function node_with_virtual_text(pos, node, text)
    local nodes
    if node.type == types.textNode then
        node.pos = 2
        nodes = {i(1), node}
    else
        node.pos = 1
        nodes = {node}
    end
    return sn(pos, nodes, {
		node_ext_opts = {
			active = {
				-- override highlight here ("GruvboxOrange").
				virt_text = {{text, "GruvboxOrange"}}
			}
		}
    })
end

local function nodes_with_virtual_text(nodes, opts)
    if opts == nil then
        opts = {}
    end
    local new_nodes = {}
    for pos, node in ipairs(nodes) do
        if opts.texts[pos] ~= nil then
            node = node_with_virtual_text(pos, node, opts.texts[pos])
        end
        table.insert(new_nodes, node)
    end
    return new_nodes
end

local function choice_text_node(pos, choices, opts)
    choices = nodes_with_virtual_text(choices, opts)
    return c(pos, choices, opts)
end

local ct = choice_text_node

ls.add_snippets("python", {
	s('d', fmt([[
		def {func}({args}){ret}:
			{doc}{body}
	]], {
		func = i(1),
		args = i(2),
		ret = c(3, {
			t(''),
			sn(nil, {
				t(' -> '),
				i(1),
			}),
		}),
		doc = isn(4, {ct(1, {
			t(''),
			-- NOTE we need to surround the `fmt` with `sn` to make this work
			sn(1, fmt([[
			"""{desc}"""

			]], {desc = i(1)})),
			sn(2, fmt([[
			"""{desc}

			Args:
			{args}

			Returns:
			{returns}
			"""

			]], {
				desc = i(1),
				args = i(2),  -- TODO should read from the args in the function
				returns = i(3),
			})),
		}, {
			texts = {
				"(no docstring)",
				"(single line docstring)",
				"(full docstring)",
			}
		})}, "$PARENT_INDENT\t"),
		body = i(0),
	}))
})
```

![luasnip_choicenode](https://user-images.githubusercontent.com/23341710/153564260-da5b932f-f5cd-41b0-bec9-046d06787a80.gif)


### init function with dynamic initializer list
This is just the solution I decided to use. With help of @L3MON4D3 we developed multiple solutions see [this issue](https://github.com/L3MON4D3/LuaSnip/issues/328#issuecomment-1064039287) including one using a similar functionality like the latex tabular macro (see [dynamicnode with user input](https://github.com/L3MON4D3/LuaSnip/wiki/Misc#dynamicnode-with-user-input)).

```lua
local ls        = require"luasnip"
local s         = ls.snippet
local sn        = ls.snippet_node
local t         = ls.text_node
local i         = ls.insert_node
local c         = ls.choice_node
local d         = ls.dynamic_node
local r         = ls.restore_node
local fmt       = require("luasnip.extras.fmt").fmt

-- see latex infinite list for the idea. Allows to keep adding arguments via choice nodes.
local function py_init()
  return
    sn(nil, c(1, {
      t(""),
      sn(1, {
        t(", "),
        i(1),
        d(2, py_init)
      })
    }))
end

-- splits the string of the comma separated argument list into the arguments
-- and returns the text-/insert- or restore-nodes
local function to_init_assign(args)
  local tab = {}
  local a = args[1][1]
  if #(a) == 0 then
    table.insert(tab, t({"", "\tpass"}))
  else
    local cnt = 1
    for e in string.gmatch(a, " ?([^,]*) ?") do
      if #e > 0 then
        table.insert(tab, t({"","\tself."}))
        -- use a restore-node to be able to keep the possibly changed attribute name
        -- (otherwise this function would always restore the default, even if the user
        -- changed the name)
        table.insert(tab, r(cnt, tostring(cnt), i(nil,e)))
        table.insert(tab, t(" = "))
        table.insert(tab, t(e))
        cnt = cnt+1
      end
    end
  end
  return
    sn(nil, tab)
end

-- create the actual snippet
s("pyinit", fmt(
  [[def __init__(self{}):{}]],
  {
    d(1, py_init),
    d(2, to_init_assign, {1})
  }))
```

![Peek 2022-03-21 15-00](https://user-images.githubusercontent.com/60581958/159277404-f462099c-6e44-41a8-a275-941dd918e0ff.gif)
(Note about the keys: tab is my jump-key, ctrl+j/k is my change_choice-key)

(Being in a choice node is indicated by a blue dot, insert nodes by a white dot at the end of the line)

### Match Case with Regex/External Updates
Two of the most useful dynamic node technique, regex capture groups and external update dynamic node, join forces. Having regex capture gives you a great way to start off your snippet, but if you need to make changes on the fly, then external updates will allow you to make quick fixes like adding/removing a case in a match case statement with a simple keystroke and nothing more.

```lua
-- dynamic node generator
local generate_matchcase_dynamic = function(args, snip)
    if not snip.num_cases then
        snip.num_cases = tonumber(snip.captures[1]) or 1
    end
    local nodes = {}
    local ins_idx = 1
    for j = 1, snip.num_cases do
        vim.list_extend(nodes, fmta([[
        case <>:
            <>
        ]], {r(ins_idx, "var" .. j, i(1)), r(ins_idx+1, "next" .. j, i(0))}))
        table.insert(nodes, t({"", ""}))
        ins_idx = ins_idx + 2
    end
    table.remove(nodes, #nodes) -- removes the extra line break
    return isn(nil, nodes, "\t")
end

-- snippet 
s({ trig='mc(%d*)', name='match case', dscr='match n cases', regTrig = true, hidden = true},
    fmta([[
    match <>:
        <>
        <>
    ]],
    { i(1), d(2, generate_matchcase_dynamic, {}, {
	user_args = {
		function(snip) snip.num_cases = snip.num_cases + 1 end,
		function(snip) snip.num_cases = math.max(snip.num_cases - 1, 1) end -- don't drop below 1 case, probably can be modified but it seems reasonable to me :shrug:
	}
    }),
    c(3, {t(""), isn(nil, fmta([[
    case _:
        <>
    ]], {i(1, "pass")}), "\t")})}
    )),
```

![dynamic-matchcase](https://github.com/L3MON4D3/LuaSnip/assets/82856360/8f2f6928-5b10-4be4-923a-bf2b2b894764)


## All - [`todo-comments.nvim`](https://github.com/folke/todo-comments.nvim) snippets

As some people using [`honza/vim-snippets`](https://github.com/honza/vim-snippets) may know, a convenient use for snippets is to annotate your code with named comments. These comments may include additional information. Typical examples of useful information marks for the comment:

1. _GitHub username_ in a repository that has more contributors
2. _date_ when browsing code after some time has passed after the writing
3. _email_ if you have multiple remotes for the repository and anticipate some other developer needing to contact you

As stated above, some implementations of this are already made for other snippet engines. However, we have `LuaSnip` and can supercharge this idea using `choice_node`s and `lua`.

### Finding the comment-string
Instead of inventing the wheel, we will be using the amazing [`numToStr/Comment.nvim`](https://github.com/numToStr/Comment.nvim) plugin, which also has added benefits that if the plugin adds compatibility with more languages, we will get them too without any work and that the calculation of the comment-string is based on _TreeSitter_ therefore is also correct for injected languages. Here is a function that fetches comment-strings for us to use in the snippet:
```lua
local calculate_comment_string = require('Comment.ft').calculate
local utils = require('Comment.utils')

--- Get the comment string {beg,end} table
---@param ctype integer 1 for `line`-comment and 2 for `block`-comment
---@return table comment_strings {begcstring, endcstring}
local get_cstring = function(ctype)
  -- use the `Comments.nvim` API to fetch the comment string for the region (eq. '--%s' or '--[[%s]]' for `lua`)
  local cstring = calculate_comment_string { ctype = ctype, range = utils.get_region() } or vim.bo.commentstring
  -- as we want only the strings themselves and not strings ready for using `format` we want to split the left and right side
  local left, right = utils.unwrap_cstr(cstring)
  -- create a `{left, right}` table for it
  return { left, right }
end
```
Now we can use this function in any snippet we want. Next we will want some kind of snippet generation based on the input strings, but first, let us define some useful marks that can be placed after the comment.

### Info marks after the comment
We will eventually want to place the marks into a `choice_node` therefore we want them to return nodes from `LuaSnip`. First lets define some variables that we can use in the marks:
```lua
_G.luasnip = {}
_G.luasnip.vars = {
  username = 'kunzaatko',
  email = 'martinkunz@email.cz',
  github = 'https://github.com/kunzaatko',
  real_name = 'Martin Kunz',
}
```
Now we can use these in the marks and lets create a variety of them to choose from:
```lua
--- Options for marks to be used in a TODO comment
local marks = {
  signature = function()
    return fmt('<{}>', i(1, _G.luasnip.vars.username))
  end,
  signature_with_email = function()
    return fmt('<{}{}>', { i(1, _G.luasnip.vars.username), i(2, ' ' .. _G.luasnip.vars.email) })
  end,
  date_signature_with_email = function()
    return fmt(
      '<{}{}{}>',
      { i(1, os.date '%d-%m-%y'), i(2, ', ' .. _G.luasnip.vars.username), i(3, ' ' .. _G.luasnip.vars.email) }
    )
  end,
  date_signature = function()
    return fmt('<{}{}>', { i(1, os.date '%d-%m-%y'), i(2, ', ' .. _G.luasnip.vars.username) })
  end,
  date = function()
    return fmt('<{}>', i(1, os.date '%d-%m-%y'))
  end,
  empty = function()
    return t ''
  end,
}
```

### `todo-comments` snippets
Finally we will want to generate the snippets that we will use for TODO comments. As you can see in the documentation of [`todo-comments.nvim`](https://github.com/folke/todo-comments.nvim), you can create some aliases and we will use them in our snippets too. We want to create snippets that look like this:
```
<comment-string[1]> [name-of-comment]: {comment-text} [comment-mark] <comment-string[2]>
```
where `<>` are generated strings, `[]` are choices and `{}` are inputs.
Here is an implementation of generating the nodes for the snippet.
```lua
local todo_snippet_nodes = function(aliases, opts)
  local aliases_nodes = vim.tbl_map(function(alias)
    return i(nil, alias) -- generate choices for [name-of-comment]
  end, aliases)
  local sigmark_nodes = {} -- choices for [comment-mark]
  for _, mark in pairs(marks) do
    table.insert(sigmark_nodes, mark())
  end
  -- format them into the actual snippet
  local comment_node = fmta('<> <>: <> <> <><>', {
    f(function()
      return get_cstring(opts.ctype)[1] -- get <comment-string[1]>
    end),
    c(1, aliases_nodes), -- [name-of-comment]
    i(3), -- {comment-text}
    c(2, sigmark_nodes), -- [comment-mark]
    f(function()
      return get_cstring(opts.ctype)[2] -- get <comment-string[2]>
    end),
    i(0),
  })
  return comment_node
end
```
As a cherry on-top, lets make some logic to generate the `name`, `docstring` and `dscr` keys of the `context` for the final snippet:
```lua
--- Generate a TODO comment snippet with an automatic description and docstring
---@param context table merged with the generated context table `trig` must be specified
---@param aliases string[]|string of aliases for the todo comment (ex.: {FIX, ISSUE, FIXIT, BUG})
---@param opts table merged with the snippet opts table
local todo_snippet = function(context, aliases, opts)
  opts = opts or {}
  aliases = type(aliases) == 'string' and { aliases } or aliases -- if we do not have aliases, be smart about the function parameters
  context = context or {}
  if not context.trig then
    return error("context doesn't include a `trig` key which is mandatory", 2) -- all we need from the context is the trigger
  end
  opts.ctype = opts.ctype or 1 -- comment type can be passed in the `opts` table, but if it is not, we have to ensure, it is defined
  local alias_string = table.concat(aliases, '|') -- `choice_node` documentation
  context.name = context.name or (alias_string .. ' comment') -- generate the `name` of the snippet if not defined
  context.dscr = context.dscr or (alias_string .. ' comment with a signature-mark') -- generate the `dscr` if not defined
  context.docstring = context.docstring or (' {1:' .. alias_string .. '}: {3} <{2:mark}>{0} ') -- generate the `docstring` if not defined
  local comment_node = todo_snippet_nodes(aliases, opts) -- nodes from the previously defined function for their generation
  return s(context, comment_node, opts) -- the final todo-snippet constructed from our parameters
end
```
Now we can create a todo-snippet using only one function with the right parameters. Lets create a few of them:
```lua
local todo_snippet_specs = {
  { { trig = 'todo' }, 'TODO' },
  { { trig = 'fix' }, { 'FIX', 'BUG', 'ISSUE', 'FIXIT' } },
  { { trig = 'hack' }, 'HACK' },
  { { trig = 'warn' }, { 'WARN', 'WARNING', 'XXX' } },
  { { trig = 'perf' }, { 'PERF', 'PERFORMANCE', 'OPTIM', 'OPTIMIZE' } },
  { { trig = 'note' }, { 'NOTE', 'INFO' } },
  -- NOTE: Block commented todo-comments <kunzaatko>
  { { trig = 'todob' }, 'TODO', { ctype = 2 } },
  { { trig = 'fixb' }, { 'FIX', 'BUG', 'ISSUE', 'FIXIT' }, { ctype = 2 } },
  { { trig = 'hackb' }, 'HACK', { ctype = 2 } },
  { { trig = 'warnb' }, { 'WARN', 'WARNING', 'XXX' }, { ctype = 2 } },
  { { trig = 'perfb' }, { 'PERF', 'PERFORMANCE', 'OPTIM', 'OPTIMIZE' }, { ctype = 2 } },
  { { trig = 'noteb' }, { 'NOTE', 'INFO' }, { ctype = 2 } },
}

local todo_comment_snippets = {}
for _, v in ipairs(todo_snippet_specs) do
  -- NOTE: 3rd argument accepts nil
  table.insert(todo_comment_snippets, todo_snippet(v[1], v[2], v[3]))
end

ls.add_snippets('all', todo_comment_snippets, { type = 'snippets', key = 'todo_comments' })
```
And a video of the final result:
![todo_comments_video](https://user-images.githubusercontent.com/56647779/159585596-a947fabc-787a-4c97-afe2-59efa2fcab3e.gif)

## box comment like ultisnips.

![20221008132008](https://user-images.githubusercontent.com/23305067/194700548-1ae96a5e-254e-4010-a15e-6ac4d6f3e3cf.gif)

see issue [#151](https://github.com/L3MON4D3/LuaSnip/issues/151)

```lua

local function create_box(opts)
  local pl = opts.padding_length or 4
  local function pick_comment_start_and_end()
    -- because lua block comment is unlike other language's,
    --  so handle lua ctype
    local ctype =  2
    if vim.opt.ft:get() == 'lua' then
      ctype = 1
    end
    local cs = get_cstring(ctype)[1]
    local ce = get_cstring(ctype)[2]
    if ce == '' or ce == nil then
      ce = cs
    end
    return cs, ce
  end
  return {
    -- top line
    f(function (args)
      local cs, ce = pick_comment_start_and_end()
      return cs .. string.rep(string.sub(cs, #cs, #cs), string.len(args[1][1]) + 2 * pl ) .. ce
    end, { 1 }),
    t{"", ""},
    f(function()
      local cs = pick_comment_start_and_end()
      return cs .. string.rep(' ',  pl)
    end),
    i(1, 'box'),
    f(function()
      local cs, ce = pick_comment_start_and_end()
      return string.rep(' ',  pl) .. ce
    end),
    t{"", ""},
    -- bottom line
    f(function (args)
      local cs, ce = pick_comment_start_and_end()
      return cs .. string.rep(string.sub(ce, 1, 1), string.len(args[1][1]) + 2 * pl ) .. ce
    end, { 1 }),
  }
end

return {
  s({trig = 'box'}, create_box{ padding_length = 8 }),
  s({trig = 'bbox'}, create_box{ padding_length = 20 }),
}

```

## Alternative `box` and `bbox`

```lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function box(opts)
    local function box_width()
        return opts.box_width or vim.opt.textwidth:get()
    end

    local function padding(cs, input_text)
        local spaces = box_width() - (2 * #cs)
        spaces = spaces - #input_text
        return spaces / 2
    end

    local comment_string = function()
        return require("luasnip.util.util").buffer_comment_chars()[1]
    end

    return {
        f(function()
            local cs = comment_string()
            return string.rep(string.sub(cs, 1, 1), box_width())
        end, { 1 }),
        t({ "", "" }),
        f(function(args)
            local cs = comment_string()
            return cs .. string.rep(" ", math.floor(padding(cs, args[1][1])))
        end, { 1 }),
        i(1, "placeholder"),
        f(function(args)
            local cs = comment_string()
            return string.rep(" ", math.ceil(padding(cs, args[1][1]))) .. cs
        end, { 1 }),
        t({ "", "" }),
        f(function()
            local cs = comment_string()
            return string.rep(string.sub(cs, 1, 1), box_width())
        end, { 1 }),
    }
end

require("luasnip").add_snippets("all", {
    -- https://github.com/L3MON4D3/LuaSnip/wiki/Cool-Snippets#box-comment-like-ultisnips
    s({ trig = "box" }, box({ box_width = 24 })),
    s({ trig = "bbox" }, box({})),
})
```

## C# - Add using directives needed by snippets

It is a drag to add basic using directives in csharp, let's fix that with luasnip!

This snippet requires this helper function to add the using directives. This function should be called from the luasnip pre_expand event to avoid node locations getting messed up.

```lua
---Function for luasnip to add using directives needed for snippets
---@param required_using_directive_list string|table
local function add_csharp_using_statement_if_needed(required_using_directive_list)
    if type(required_using_directive_list) == 'string' then
        local temp = required_using_directive_list
        required_using_directive_list = { temp }
    end

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        for _, using_directive in ipairs(required_using_directive_list) do
            if line:match(using_directive) ~= nil then
                table.remove(required_using_directive_list, using_directive)
            end
        end
    end

    -- Add all using directives that remain in the list to be written to top of file
    if #required_using_directive_list > 0 then
        local using_directives_to_write = {}
        for _, using_directive in ipairs(required_using_directive_list) do
            table.insert(using_directives_to_write, string.format('using %s;', using_directive))
        end
        vim.api.nvim_buf_set_lines(0, 0, 0, false, using_directives_to_write)
    end
end
```

And here are two of my snippets that use this function.

```lua
    s(
        'regex match',
        fmt(
            [[
        if(Regex.IsMatch({}, @"{}"))
        {{
            {}
        }}
        ]]   ,
            {
                i(1, '"source"'),
                i(2, '.*'),
                i(3),
            }
        ),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        add_csharp_using_statement_if_needed('System.Text.RegularExpressions')
                    end,
                },
            },
        }
    ),

    s(
        'regex matches',
        fmt(
            [[
        var matches = Regex.Matches({}, @"{}")
                           .Cast<Match>()
                           .Select(match => {})
                           .Distinct();
        ]]   ,
            {
                i(1),
                i(2, '.*'),
                i(3, 'match'),
            }
        ),
        {
            callbacks = {
                [-1] = {
                    -- Write needed using directives before expanding snippet so positions are not messed up
                    [events.pre_expand] = function()
                        add_csharp_using_statement_if_needed({
                            'System.Linq',
                            'System.Text.RegularExpressions',
                        })
                    end,
                },
            },
        }
    ),

```

### Going Further With Multisnippets

Here is an example using multisnippets `ms` with a nice helper function to make the callback setup easier!

```lua
-- Helper function to easily setup the callback to add needed usings
local function UsingInclude(includes)
    return {
        common_opts = {
            callbacks = {
                [-1] = {
                    -- Write all includes to top of tile
                    [events.pre_expand] = function()
                        add_csharp_using_statement_if_needed(includes)
                    end,
                },
            },
        },
    }
end

ms(
    {
        { trig = 'prime', snippetType = 'snippet', condition = nil },
        { trig = 'prm', snippetType = 'autosnippet', condition = nil },
    },
    fmt([[Enumerable.Range(2, (int)Math.Sqrt({Range}) - 1).All(divisor => {RangeRep} % divisor != 0)]], {
        Range = i(1, '100'),
        RangeRep = rep(1),
    }),
    UsingInclude('System.Linq')
)
```

## Dotnet C# & F# - XML Code Comment

Dotnet supports using a triple `///` comment to create a enhanced comment that uses XML formatting.

This snippet helps to start the comment and sets neovims built in comment settings to make it easier to
continue the comment on the next line.
Without these callbacks, pressing enter at the end of the line does not continue the `///` on the next
line (at least for my neovim config where I have formatoptions set differently).

```lua
    s(
        {
            trig = '///',
            descr = 'XML comment summary',
        },
        fmt(
            [[
    /// <summary>
    /// {}
    /// </summary>{}
    ]]       ,
            {
                i(1),
                i(2),
            }
        ),
        {
            callbacks = {
                [-1] = {
                    -- Set vim comment mode to help continue writing the XML comment
                    -- Pressing the trigger of '///' again would trigger the snippet again
                    [events.enter] = function()
                        vim.cmd('set formatoptions+=cro')
                    end,
                },

                [2] = {
                    -- Disable the vim settings after leaving the snippet
                    [events.leave] = function()
                        vim.cmd('set formatoptions-=cro')
                    end,
                },
            },
        }
    ),
```

One important trick is to not jump to the second node of this snippet until you're all
done with adding any other XML comments. When you do jump to the end of this snippet it'll disable
the comment new line continuation neovim settings. WOW, luasnip is so powerful!

Here is the full list of available options you can use inside the XML comment.

```lua
    s(
        'XML XML',
        fmt([[{}]], {
            c(1, {
                sn(
                    nil,
                    fmt(
                        [[
                   <summary>{}</summary>
                   ]]    ,
                        {
                            i(1, 'Test test test'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                 <remarks>{}</remarks>
                 ]]      ,
                        {
                            i(1, 'Specifies that text contains supplementary information about the program element'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <param name="{}">{}</param>
                ]]       ,
                        {
                            i(1),
                            i(2, 'Specifies the name and description for a function or method parameter'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <typeparam name="{}">{}</typeparam>
                ]]       ,
                        {
                            i(1),
                            i(2, 'Specifies the name and description for a type parameter'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <returns>{}</returns>
                ]]       ,
                        {
                            i(1, 'Describe the return value of a function or method'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <exception cref="{}">{}</exception>
                ]]       ,
                        {
                            i(1, 'Exception type'),
                            i(
                                2,
                                'Specifies the type of exception that can be generated and the circumstances under which it is thrown'
                            ),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <seealso cref="{}"/>
                ]]       ,
                        {
                            i(
                                1,
                                'Specifies the type of exception that can be generated and the circumstances under which it is thrown'
                            ),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <para>{}</para>
                ]]       ,
                        {
                            i(1, 'Specifies a paragraph of text. This is used to separate text inside the remarks tag'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <code>{}</code>
                ]]       ,
                        {
                            i(
                                1,
                                'Specifies that text is multiple lines of code. This tag can be used by generators to display text in a font that is appropriate for code'
                            ),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <paramref name="{}"/>
                ]]       ,
                        {
                            i(1, 'Specifies a reference to a parameter in the same documentation comment'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <typeparamref name="{}"/>
                ]]       ,
                        {
                            i(1, 'Specifies a reference to a type parameter in the same documentation comment'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <c>{}</c>
                ]]       ,
                        {
                            i(1, 'Specifies a reference to a type parameter in the same documentation comment'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                <see cref="{}">{}</see>
                ]]       ,
                        {
                            i(1, 'reference'),
                            i(2, 'Specifies a reference to a type parameter in the same documentation comment'),
                        }
                    )
                ),

                --
            }),
        })
    ),
```

## All - Loops with automatic variable names

You might iterate over an item in a for loop that has a plural name like "cookies" or "houses." This snippet can convert those words to their singular form ("cookie" or "house"). It also has fallbacks in case that doesn't work.

```lua
---Attempts to (in decreasing order of presedence):
-- - Convert a plural noun into a singular noun
-- - Return the first letter of the word
-- - Return "item" as a fallback
local function singular(input)
  local plural_word = input[1][1]
  local last_word = string.match(plural_word, '[_%w]*$')

  -- initialize with fallback
  local singular_word = 'item'

  if string.match(last_word, '.s$') then
    -- assume the given input is plural if it ends in s. This isn't always
    -- perfect, but it's pretty good
    singular_word = string.gsub(last_word, 's$', '', 1)

  elseif string.match(last_word, '^_?%w.+') then
    -- include an underscore in the match so that inputs like '_name' will
    -- become '_n' and not just '_'
    singular_word = string.match(last_word, '^_?.')
  end

  return s('{}', i(1, singular_word))
end
```

This should work for most languages, but here's an example implementatoin for JavaScript:
```lua
return {
  fmt(
    'for (let {} = 0; {} < {}.length; {}++) {{\n  const {} = {}[{}]\n  {}\n}}',
    { i(1, 'i'), rep(1), i(2, 'arr'), rep(1), d(3, singular, { 2 }), rep(2), rep(1), i(4) }
  )
}
```
https://user-images.githubusercontent.com/36552610/224456512-c8f5912e-431e-4bbf-9411-69c3059e680e.mov

## C

### Super powered header snippet

This snippet achieves this goals

1. Get companion .h file if the current file is a .c or .cpp file excluding main.c
2. Get all the local headers in current directory and below
3. Allow for custom insert_nodes for local and system headers
4. Finally last priority is the system headers

```lua
    s('INCLUDE', {
        d(1, function(args, snip)
            -- Create a table of nodes that will go into the header choice_node
            local headers_to_load_into_choice_node = {}

            -- Step 1: get companion .h file if the current file is a .c or .cpp file excluding main.c
            local extension = vim.fn.expand('%:e')
            local is_main = vim.fn.expand('%'):match('main%.cp?p?') ~= nil
            if (extension == 'c' or extension == 'cpp') and not is_main then
                local matching_h_file = vim.fn.expand('%:t'):gsub('%.c', '.h')
                local companion_header_file = string.format('#include "%s"', matching_h_file)
                table.insert(headers_to_load_into_choice_node, t(companion_header_file))
            end

            -- Step 2: get all the local headers in current directory and below
            local current_file_directory = vim.fn.expand('%:h')
            local local_header_files = require('plenary.scandir').scan_dir(
                current_file_directory,
                { respect_gitignore = true, search_pattern = '.*%.h$' }
            )

            -- Clean up and insert the detected local header files
            for _, local_header_name in ipairs(local_header_files) do
                -- Trim down path to be a true relative path to the current file
                local shortened_header_path = local_header_name:gsub(current_file_directory, '')
                -- Replace '\' with '/'
                shortened_header_path = shortened_header_path:gsub([[\+]], '/')
                -- Remove leading forward slash
                shortened_header_path = shortened_header_path:gsub('^/', '')
                local new_header = t(string.format('#include "%s"', shortened_header_path))
                table.insert(headers_to_load_into_choice_node, new_header)
            end

            -- Step 3: allow for custom insert_nodes for local and system headers
            local custom_insert_nodes = {
                sn(
                    nil,
                    fmt(
                        [[
                         #include "{}"
                         ]],
                        {
                            i(1, 'custom_insert.h'),
                        }
                    )
                ),
                sn(
                    nil,
                    fmt(
                        [[
                         #include <{}>
                         ]],
                        {
                            i(1, 'custom_system_insert.h'),
                        }
                    )
                ),
            }
            -- Add the custom insert_nodes for adding custom local (wrapped in "") or system (wrapped in <>) headers
            for _, custom_insert_node in ipairs(custom_insert_nodes) do
                table.insert(headers_to_load_into_choice_node, custom_insert_node)
            end

            -- Step 4: finally last priority is the system headers
            local system_headers = {
                t('#include <assert.h>'),
                t('#include <complex.h>'),
                t('#include <ctype.h>'),
                t('#include <errno.h>'),
                t('#include <fenv.h>'),
                t('#include <float.h>'),
                t('#include <inttypes.h>'),
                t('#include <iso646.h>'),
                t('#include <limits.h>'),
                t('#include <locale.h>'),
                t('#include <math.h>'),
                t('#include <setjmp.h>'),
                t('#include <signal.h>'),
                t('#include <stdalign.h>'),
                t('#include <stdarg.h>'),
                t('#include <stdatomic.h>'),
                t('#include <stdbit.h>'),
                t('#include <stdbool.h>'),
                t('#include <stdckdint.h>'),
                t('#include <stddef.h>'),
                t('#include <stdint.h>'),
                t('#include <stdio.h>'),
                t('#include <stdlib.h>'),
                t('#include <stdnoreturn.h>'),
                t('#include <string.h>'),
                t('#include <tgmath.h>'),
                t('#include <threads.h>'),
                t('#include <time.h>'),
                t('#include <uchar.h>'),
                t('#include <wchar.h>'),
                t('#include <wctype.h>'),
            }
            for _, header_snippet in ipairs(system_headers) do
                table.insert(headers_to_load_into_choice_node, header_snippet)
            end

            return sn(1, c(1, headers_to_load_into_choice_node))
        end, {}),
    }),

```

## Markdown

### Dynamic markdown table

Create a markdown table dynamically of size m x n by writing "tableMxN".

```Lua
    s({trig = "table(%d+)x(%d+)", regTrig = true}, {
        d(1, function(args, snip)
            local nodes = {}
            local i_counter = 0
            local hlines = ""
            for _ = 1, snip.captures[2] do
                i_counter = i_counter + 1
                table.insert(nodes, t("| "))
                table.insert(nodes, i(i_counter, "Column".. i_counter))
                table.insert(nodes, t(" "))
                hlines = hlines .. "|---"
            end
            table.insert(nodes, t{"|", ""})
            hlines = hlines .. "|"
            table.insert(nodes, t{hlines, ""})
            for _ = 1, snip.captures[1] do
                for _ = 1, snip.captures[2] do
                    i_counter = i_counter + 1
                    table.insert(nodes, t("| "))
                    table.insert(nodes, i(i_counter))
                    print(i_counter)
                    table.insert(nodes, t(" "))
                end
                table.insert(nodes, t{"|", ""})
            end
            return sn(nil, nodes)
        end
    ),
```
