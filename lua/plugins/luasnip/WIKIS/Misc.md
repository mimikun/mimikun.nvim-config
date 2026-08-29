## ChoiceNode-Popup
![showcase](https://user-images.githubusercontent.com/17103748/131396051-1b87464c-ff0a-470f-8064-d13becdd7053.gif)

```lua
local current_nsid = vim.api.nvim_create_namespace("LuaSnipChoiceListSelections")
local current_win = nil

local function window_for_choiceNode(choiceNode)
    local buf = vim.api.nvim_create_buf(false, true)
    local buf_text = {}
    local row_selection = 0
    local row_offset = 0
    local text
    for _, node in ipairs(choiceNode.choices) do
        text = node:get_docstring()
        -- find one that is currently showing
        if node == choiceNode.active_choice then
            -- current line is starter from buffer list which is length usually
            row_selection = #buf_text
            -- finding how many lines total within a choice selection
            row_offset = #text
        end
        vim.list_extend(buf_text, text)
    end

    vim.api.nvim_buf_set_text(buf, 0,0,0,0, buf_text)
    local w, h = vim.lsp.util._make_floating_popup_size(buf_text)

    -- adding highlight so we can see which one is been selected.
    local extmark = vim.api.nvim_buf_set_extmark(buf,current_nsid,row_selection ,0,
        {hl_group = 'incsearch',end_line = row_selection + row_offset})

    -- shows window at a beginning of choiceNode.
    local win = vim.api.nvim_open_win(buf, false, {
        relative = "win", width = w, height = h, bufpos = choiceNode.mark:pos_begin_end(), style = "minimal", border = 'rounded'})

    -- return with 3 main important so we can use them again
    return {win_id = win,extmark = extmark,buf = buf}
end

function choice_popup(choiceNode)
	-- build stack for nested choiceNodes.
	if current_win then
		vim.api.nvim_win_close(current_win.win_id, true)
                vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
	end
        local create_win = window_for_choiceNode(choiceNode)
	current_win = {
		win_id = create_win.win_id,
		prev = current_win,
		node = choiceNode,
                extmark = create_win.extmark,
                buf = create_win.buf
	}
end

function update_choice_popup(choiceNode)
    vim.api.nvim_win_close(current_win.win_id, true)
    vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
    local create_win = window_for_choiceNode(choiceNode)
    current_win.win_id = create_win.win_id
    current_win.extmark = create_win.extmark
    current_win.buf = create_win.buf
end

function choice_popup_close()
	vim.api.nvim_win_close(current_win.win_id, true)
        vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
        -- now we are checking if we still have previous choice we were in after exit nested choice
	current_win = current_win.prev
	if current_win then
		-- reopen window further down in the stack.
                local create_win = window_for_choiceNode(current_win.node)
                current_win.win_id = create_win.win_id
                current_win.extmark = create_win.extmark
                current_win.buf = create_win.buf
	end
end

vim.cmd([[
augroup choice_popup
au!
au User LuasnipChoiceNodeEnter lua choice_popup(require("luasnip").session.event_node)
au User LuasnipChoiceNodeLeave lua choice_popup_close()
au User LuasnipChangeChoice lua update_choice_popup(require("luasnip").session.event_node)
augroup END
]])
```
This makes use of the nodeEnter/Leave/ChangeChoice events to show available choices. A similar effect can also be achieved by overriding the `vim.ui.select`-menu and binding [`select_choice`](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#select_choice) to a key.

## Improve Language Server-Snippets

This can be useful if a language server returns snippets that suffer from the limitations of
lsp-snippets. In this particular case `clangd`s snippets for member initializatizer lists always
look like this: `m_SomeMember(${0:m_SomeMembersType})`. This is suboptimal in some ways, mainly
that
- Only normal parenthesis are possible, whereas curly braces may be preferred.
- Luasnip treats the $0-placeholder as a one-time-stop, meaning that once SELECT is exited, there's
no way to change it.

To fix this, we need to
1. intercept and change the snippet received via LSP.
2. override the expansion-function (here in `nvim-cmp`) to use our new snippet, if available.

We override the `client.request`-function so all responses from LSP go through our function.
There we override the handler for `"textDocument/completion"` to modify the `TextEdit` returned by the language server.
("Inspired" by [this comment](https://github.com/hrsh7th/nvim-cmp/issues/465#issuecomment-981159946)).
```lua
local ls = require("luasnip")
local s = ls.snippet
local r = ls.restore_node
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

lspsnips = {}

nvim_lsp.clangd.setup{
	on_attach = function(client)
		local orig_rpc_request = client.rpc.request
		function client.rpc.request(method, params, handler, ...)
			local orig_handler = handler
			if method == 'textDocument/completion' then
				-- Idiotic take on <https://github.com/fannheyward/coc-pyright/blob/6a091180a076ec80b23d5fc46e4bc27d4e6b59fb/src/index.ts#L90-L107>.
				handler = function(...)
					local err, result = ...
					if not err and result then
						local items = result.items or result
						for _, item in ipairs(items) do
							-- override snippets for kind `field`, matching the snippets for member initializer lists.
							if item.kind == vim.lsp.protocol.CompletionItemKind.Field and
								item.textEdit.newText:match("^[%w_]+%(${%d+:[%w_]+}%)$") then

								local snip_text = item.textEdit.newText
								local name = snip_text:match("^[%w_]+")
								local type = snip_text:match("%{%d+:([%w_]+)%}")
								-- the snippet is stored in a separate table. It is not stored in the `item` passed to
								-- cmp, because it will be copied there and cmps [copy](https://github.com/hrsh7th/nvim-cmp/blob/ac476e05df2aab9f64cdd70b6eca0300785bb35d/lua/cmp/utils/misc.lua#L125-L143) doesn't account
								-- for self-referential tables and metatables (rightfully so, a response from lsp
								-- would contain neither), both of which are vital for a snippet.
								lspsnips[snip_text] = s("", {
									t(name),
									c(1, {
										-- use a restoreNode to remember the text typed here.
										{t"(", r(1, "type", i(1, type)), t")"},
										{t"{", r(1, "type"), t"}"},
									}, {restore_cursor = true})
								})
							end
						end
					end
					return orig_handler(...)
				end
			end
			return orig_rpc_request(method, params, handler, ...)
		end
	end
}
```

The last missing piece is changing the `"default"` snippet-expansion-function in cmp to account for our snippet:

```lua
cmp.setup {
	snippet = {
		expand = function(args)
			-- check if we created a snippet for this lsp-snippet.
			if lspsnips[args.body] then
				-- use `snip_expand` to expand the snippet at the cursor position.
				require("luasnip").snip_expand(lspsnips[args.body])
			else
				require("luasnip").lsp_expand(args.body)
			end
		end,
	},
}
```

_et voilà_:
![output](https://user-images.githubusercontent.com/41961280/144756622-0d55714b-f768-460a-a0c3-dff3aa754a59.gif)

## DynamicNode with user input

Normally, dynamicNodes can only update when text inside the snippet changed. This is pretty powerful, but not enough
for eg. a latex-table-snippet, where the number of rows should be adjustable on-the-fly (otherwise a regex-triggered snippet with
`trig=tab(%d+)x(%d+)` would suffice).  
This isn't possible OOTB, so we need to write a function that
1. Runs some other function whose output will be used in the dynamicNode-function.
2. Updates the dynamicNode.

and then call that function using a mapping (optional, but much more comfortable than calling it manually).

```lua
local ls = require("luasnip")
local util = require("luasnip.util.util")
local node_util = require("luasnip.nodes.util")

local function find_dynamic_node(node)
	-- the dynamicNode-key is set on snippets generated by a dynamicNode only (its'
	-- actual use is to refer to the dynamicNode that generated the snippet).
	while not node.dynamicNode do
		node = node.parent
		if not node then
			return
		end
	end
	return node.dynamicNode
end

local external_update_id = 0
-- func_indx to update the dynamicNode with different functions.
function dynamic_node_external_update(func_indx)
	-- most of this function is about restoring the cursor to the correct
	-- position+mode, the important part are the few lines from
	-- `dynamic_node.snip:store()`.


	-- find current node and the innermost dynamicNode it is inside.
	local current_node = ls.session.current_nodes[vim.api.nvim_get_current_buf()]
	local dynamic_node = find_dynamic_node(current_node)

	if not dynamic_node then
		return
	end

	-- to identify current node in new snippet, if it is available.
	external_update_id = external_update_id + 1
	current_node.external_update_id = external_update_id
	local current_node_key = current_node.key

	-- store which mode we're in to restore later.
	local insert_pre_call = vim.fn.mode() == "i"
	-- is byte-indexed! Doesn't matter here, but important to be aware of.
	local cursor_pos_end_relative = util.pos_sub(
		util.get_cursor_0ind(),
		current_node.mark:get_endpoint(1)
	)

	-- leave current generated snippet.
	node_util.leave_nodes_between(dynamic_node.snip, current_node)

	-- call update-function.
	local func = dynamic_node.user_args[func_indx]
	if func then
		-- the same snippet passed to the dynamicNode-function. Any output from func
		-- should be stored in it under some unused key.
		func(dynamic_node.parent.snippet)
	end

	-- last_args is used to store the last args that were used to generate the
	-- snippet. If this function is called, these will most probably not have
	-- changed, so they are set to nil, which will force an update.
	dynamic_node.last_args = nil
	dynamic_node:update()

	-- everything below here isn't strictly necessary, but it's pretty nice to have.


    -- try to find the node we marked earlier, or a node with the same key.
    -- Both are getting equal priority here, it might make sense to give "exact
    -- same node" higher priority by doing two searches (but that would require
    -- two searches :( )
	local target_node = dynamic_node:find_node(function(test_node)
		return (test_node.external_update_id == external_update_id) or (current_node_key ~= nil and test_node.key == current_node_key)
	end)

	if target_node then
		-- the node that the cursor was in when changeChoice was called exists
		-- in the active choice! Enter it and all nodes between it and this choiceNode,
		-- then set the cursor.
		node_util.enter_nodes_between(dynamic_node, target_node)

		if insert_pre_call then
			-- restore cursor-position if the node, or a corresponding node,
			-- could be found.
			-- It is restored relative to the end of the node (as opposed to the
			-- beginning). This does not matter if the text in the node is
			-- unchanged, but if the length changed, we may move the cursor
			-- relative to its immediate neighboring characters.
			-- I assume that it is more likely that the text before the cursor
			-- got longer (since it is very likely that the cursor is just at
			-- the end of the node), and thus restoring relative to the
			-- beginning would shift the cursor back.
			-- 
			-- However, restoring to any fixed endpoint is likely to not be
			-- perfect, an interesting enhancement would be to compare the new
			-- and old text/[neighborhood of the cursor], and find its new position
			-- based on that.
			util.set_cursor_0ind(
				util.pos_add(
					target_node.mark:get_endpoint(1),
					cursor_pos_end_relative
				)
			)
		else
			node_util.select_node(target_node)
		end
		-- set the new current node correctly.
		ls.session.current_nodes[vim.api.nvim_get_current_buf()] = target_node
	else
		-- the marked node wasn't found, just jump into the new snippet noremally.
		ls.session.current_nodes[vim.api.nvim_get_current_buf()] = dynamic_node.snip:jump_into(1)
	end
end
```

Bind the function to some key:
```lua
vim.api.nvim_set_keymap('i', "<C-t>", '<cmd>lua _G.dynamic_node_external_update(1)<Cr>', {noremap = true})
vim.api.nvim_set_keymap('s', "<C-t>", '<cmd>lua _G.dynamic_node_external_update(1)<Cr>', {noremap = true})

vim.api.nvim_set_keymap('i', "<C-g>", '<cmd>lua _G.dynamic_node_external_update(2)<Cr>', {noremap = true})
vim.api.nvim_set_keymap('s', "<C-g>", '<cmd>lua _G.dynamic_node_external_update(2)<Cr>', {noremap = true})
```

It may be useful to bind even more numbers (3-???????), but two suffice for this example.  

Now it's time to make use of the new function:
```lua

local function column_count_from_string(descr)
	-- this won't work for all cases, but it's simple to improve
	-- (feel free to do so! :D )
	return #(descr:gsub("[^clm]", ""))
end

-- function for the dynamicNode.
local tab = function(args, snip)
	local cols = column_count_from_string(args[1][1])
	-- snip.rows will not be set by default, so handle that case.
	-- it's also the value set by the functions called from dynamic_node_external_update().
	if not snip.rows then
		snip.rows = 1
	end
	local nodes = {}
	-- keep track of which insert-index we're at.
	local ins_indx = 1
	for j = 1, snip.rows do
		-- use restoreNode to not lose content when updating.
		table.insert(nodes, r(ins_indx, tostring(j).."x1", i(1)))
		ins_indx = ins_indx+1
		for k = 2, cols do
			table.insert(nodes, t" & ")
			table.insert(nodes, r(ins_indx, tostring(j).."x"..tostring(k), i(1)))
			ins_indx = ins_indx+1
		end
		table.insert(nodes, t{"\\\\", ""})
	end
	-- fix last node.
	nodes[#nodes] = t""
	return sn(nil, nodes)
end


s("tab", fmt([[
\begin{{tabular}}{{{}}}
{}
\end{{tabular}}
]], {i(1, "c"), d(2, tab, {1}, {
	user_args = {
		-- Pass the functions used to manually update the dynamicNode as user args.
		-- The n-th of these functions will be called by dynamic_node_external_update(n).
		-- These functions are pretty simple, there's probably some cool stuff one could do
		-- with `ui.input`
		function(snip) snip.rows = snip.rows + 1 end,
		-- don't drop below one.
		function(snip) snip.rows = math.max(snip.rows - 1, 1) end
	}
} )}))
```

`<C-t>`, now calls the first function, increasing the number of rows, whereas `<C-g>` calls the second function, decreasing it.

And here's the result:  
![output](https://user-images.githubusercontent.com/41961280/145810589-f68259a1-a1a6-4e39-87ab-4ab4d7112cc5.gif)

## Mathematical Context Detection for Conditional Expansion without relying on VimTeX's `in_mathzone()`.
If you aren't using VimTeX or want to be independent from its `in_mathzone()` function, then you might find the below suggestions helpful. You can also hook it to your snippets for `markdown` as well, not just for `*.tex`.  

```lua
--[[  
Optimized Mathematical Context Detection Module for LuaSnip's autosnippets.  

Features:  
- Configurable caching mechanism  
- Configurable incremental parsing  
- Robust math environment detection  
- Multiple fallback strategies  

Last updated: 2025-05-25  
]]

-- Module table
local M = {}
local buffer_id = vim.api.nvim_get_current_buf() -- Current buffer ID

------------------------------------------------------------------------------
-- UNIFIED CACHE MECHANISM (Configurable)
------------------------------------------------------------------------------
local function create_unified_cache(options)
  -- Default configuration with options handling
  local config = {
    max_size = (options and options.max_size) or 100, -- Maximum cache size
    on_evict = (options and options.on_evict) or function() end,
    on_miss = (options and options.on_miss) or function() end,
    eviction_strategy = (options and options.eviction_strategy) or "lru",
  }

  -- Cache storage structure
  local cache = {
    items = {}, -- Cached items
    access_count = {}, -- Access frequency tracking
    last_access = {}, -- Last accessed timestamp tracking
    config = config, -- Cache configuration
  }

  -- Update access tracking
  local function update_access_tracking(full_key)
    cache.access_count[full_key] = (cache.access_count[full_key] or 0) + 1
    cache.last_access[full_key] = os.time() -- Update last access time
  end

  -- Eviction strategies
  local eviction_strategies = {
    lru = function()
      local oldest_key, oldest_time = nil, math.huge
      for key, access_time in pairs(cache.last_access) do
        if access_time < oldest_time then
          oldest_key, oldest_time = key, access_time
        end
      end
      return oldest_key
    end,
    lfu = function()
      local least_used_key, least_count = nil, math.huge
      for key, count in pairs(cache.access_count) do
        if count < least_count then
          least_used_key, least_count = key, count
        end
      end
      return least_used_key
    end,
    arc = function()
      local lru_key = eviction_strategies.lru()
      local lfu_key = eviction_strategies.lfu()
      return lru_key or lfu_key -- Combine LRU and LFU strategies
    end,
  }

  -- Namespace-aware cache getter method
  function cache:get(namespace, key)
    local full_key = string.format("%s:%s", namespace, tostring(key))
    local value = self.items[full_key]

    if value then
      update_access_tracking(full_key) -- Update access tracking
      return value
    else
      config.on_miss(namespace, key) -- Trigger cache miss callback
      return nil
    end
  end

  -- Namespace-aware cache setter method
  function cache:set(namespace, key, value)
    local full_key = string.format("%s:%s", namespace, tostring(key))

    -- Eviction logic
    if #vim.tbl_keys(self.items) >= config.max_size then
      local evict_strategy = eviction_strategies[config.eviction_strategy] or eviction_strategies.lru
      local key_to_evict = evict_strategy()

      if key_to_evict then
        config.on_evict(key_to_evict, self.items[key_to_evict]) -- Trigger eviction callback
        -- Remove evicted item
        self.items[key_to_evict] = nil
        self.access_count[key_to_evict] = nil
        self.last_access[key_to_evict] = nil
      end
    end

    -- Add or update cache item
    self.items[full_key] = value
    update_access_tracking(full_key)

    return true
  end

  -- Utility methods
  function cache:clear()
    self.items = {}
    self.access_count = {}
    self.last_access = {}
  end

  function cache:size()
    return #vim.tbl_keys(self.items) -- Return the number of cached items
  end

  function cache:stats()
    return {
      total_items = #vim.tbl_keys(self.items),
      max_size = config.max_size,
      eviction_strategy = config.eviction_strategy,
    }
  end

  return cache
end

------------------------------------------------------------------------------
-- CONFIGURATION AND SETUP
------------------------------------------------------------------------------
M.config = {
  -- Performance and parsing settings
  cache_size = 300,
  use_cache = true, -- Enable/disable the caching mechanism
  incremental_parsing = {
    enabled = false, -- Enable/disable incremental parsing
    max_lines_for_full_parse = 1000, -- Max lines for full parse
    partial_update_threshold = 50, -- Threshold for partial updates
  },

  -- Logging and debugging
  debug = false, -- Enable debug logging

  -- Detection method priorities
  detection_strategies = {
    "cache", -- Fastest
    "treesitter", -- Intermediate speed
    "regex", -- Slower fallback
    "environment", -- Slowest
  },

  -- Math environment definitions
  math_environments = {
    latex = {
      equation = true,
      align = true,
      displaymath = true,
      gather = true,
      multline = true,
    },
    context = {
      formula = true,
      subformulas = true,
      placeformula = true,
    },
  },
}

-- Initialize the unified cache only if caching is enabled
if M.config.use_cache then
  M.cache = create_unified_cache({
    max_size = M.config.cache_size,
    on_evict = function(key, value)
      if M.config.debug then
        vim.notify(string.format("Evicting cache key: %s (value: %s)", key, tostring(value)), vim.log.levels.DEBUG)
      end
    end,
    on_miss = function(namespace, key)
      if M.config.debug then
        vim.notify(string.format("Cache miss in namespace %s for key %s", namespace, key), vim.log.levels.DEBUG)
      end
    end,
    eviction_strategy = M.config.eviction_strategy or "lru", -- Default eviction strategy
  })
else
  M.cache = nil -- Disable caching
end

------------------------------------------------------------------------------
-- CONFIGURATION SETUP
------------------------------------------------------------------------------
function M.setup(user_config)
  -- Deep merge user configurations
  M.config = vim.tbl_deep_extend("force", M.config, user_config or {})

  -- Validate incremental parsing settings
  if type(M.config.incremental_parsing.enabled) ~= "boolean" then
    M.config.incremental_parsing.enabled = false

    if M.config.debug then
      vim.notify("Invalid incremental parsing setting. Defaulting to false.", vim.log.levels.WARN)
    end
  end

  -- Reinitialize cache if caching is enabled
  if M.config.use_cache then
    M.cache = create_unified_cache({
      max_size = M.config.cache_size,
      on_evict = function(key, value)
        if M.config.debug then
          vim.notify(string.format("Evicting cache key: %s (value: %s)", key, tostring(value)), vim.log.levels.DEBUG)
        end
      end,
      on_miss = function(namespace, key)
        if M.config.debug then
          vim.notify(string.format("Cache miss in namespace %s for key %s", namespace, key), vim.log.levels.DEBUG)
        end
      end,
      eviction_strategy = M.config.eviction_strategy or "lru",
    })
  else
    M.cache = nil -- Disable caching
  end

  -- Optional debug logging
  if M.config.debug then
    vim.notify("Math Detection Config: " .. vim.inspect(M.config), vim.log.levels.DEBUG)
  end
end

------------------------------------------------------------------------------
-- INCREMENTAL PARSING HELPER
------------------------------------------------------------------------------
local function get_incremental_parser(buffer, language)
  local parser = vim.treesitter.get_parser(buffer, language)
  local config = M.config.incremental_parsing

  if not config.enabled then
    local line_count = vim.api.nvim_buf_line_count(buffer)

    -- Determine max_lines_for_full_parse if it's a function
    local max_lines = type(config.max_lines_for_full_parse) == "function" and config.max_lines_for_full_parse()
      or config.max_lines_for_full_parse

    if line_count > max_lines then
      parser:parse(true) -- Force a full parse if exceeds limit
    end
  end

  return parser
end

------------------------------------------------------------------------------
-- HELPER FUNCTIONS
------------------------------------------------------------------------------
local function get_cursor_pos()
  local cursor = vim.api.nvim_win_get_cursor(0) -- Get cursor position
  return cursor[1], cursor[2] + 1 -- Return 1-indexed row and column
end

-------------------------------------------------------------------------------
-- MATH ZONE DETECTION
-------------------------------------------------------------------------------
local function create_math_query()
  local cached_query = nil

  return function()
    if not cached_query then
      cached_query = vim.treesitter.query.parse(
        "latex",
        [[  
        (  
          (inline_formula) @inline  
          (displayed_equation) @display  
          (math_delimiter) @delim  
          (math_environment) @latex  
          (generic_command) @context   
        )  
        ]]
      )
    end
    return cached_query
  end
end

local get_math_query = create_math_query()

function M.is_mathzone()
  local current_row, current_col = get_cursor_pos()
  local cache_key = string.format("%d:%d", current_row, current_col)

  -- Check cache first if caching is enabled
  local cached_result = M.config.use_cache and M.cache:get("mathzone", cache_key)
  if cached_result ~= nil then
    return cached_result
  end

  -- Use incremental parser; ensure you run `:TSInstall latex`
  local parser = get_incremental_parser(0, "latex")
  if not parser then
    return M.is_mathzone_fallback()
  end

  local root = parser:parse()[1]:root()
  local row, col = get_cursor_pos()
  local cursor_row, cursor_col = row - 1, col - 1

  local query = get_math_query()

  local function check_math_environment(node, capture)
    local env_name = vim.treesitter.get_node_text(node, 0):gsub("[\\{}]", ""):lower()
    local s_row, s_col, e_row, e_col = node:range()

    -- Check if the environment is defined
    if M.config.math_environments[env_name] then
      if
        cursor_row >= s_row
        and cursor_row <= e_row
        and (cursor_row > s_row or cursor_col >= s_col)
        and (cursor_row < e_row or cursor_col < e_col)
      then
        return true
      end
    end

    return false
  end

  for id, node in query:iter_captures(root, 0) do
    local capture = query.captures[id]
    local s_row, s_col, e_row, e_col = node:range()

    local is_in_zone = (capture == "inline" or capture == "display" or capture == "delim")
      and cursor_row >= s_row
      and cursor_row <= e_row
      and (cursor_row > s_row or cursor_col >= s_col)
      and (cursor_row < e_row or cursor_col < e_col)

    local is_math_env = (capture == "latex" or capture == "context") and check_math_environment(node, capture)

    if is_in_zone or is_math_env then
      if M.config.use_cache then
        M.cache:set("mathzone", cache_key, true)
      end
      return true
    end
  end

  if M.config.use_cache then
    M.cache:set("mathzone", cache_key, false)
  end
  return false
end

------------------------------------------------------------------------------
-- REGEX-BASED DETECTION
------------------------------------------------------------------------------
local function safe_regex_matcher(line)
  local matches = {}
  local patterns = {
    { pattern = "()%$(.-)%$()", type = "inline" },
    { pattern = "()%$%$(.-)%$%$()", type = "display" },
    { pattern = "()\\(%(.-)\\%)()", type = "latex_inline" },
    { pattern = "()\\(%[.-)\\%]()()", type = "latex_display" },
    { pattern = "()\\math{(.-)}()", type = "sile_inline" },
  }

  for _, pat in ipairs(patterns) do
    for start, content, stop in line:gmatch(pat.pattern) do
      table.insert(matches, {
        type = pat.type,
        start = start,
        stop = stop,
        content = content,
      })
    end
  end

  return matches
end

function M.is_mathzone_fallback()
  local current_row, current_col = get_cursor_pos()
  local cache_key = string.format("fallback:%d:%d", current_row, current_col)

  -- Check cache first if caching is enabled
  if M.config.use_cache then
    local cached_result = M.cache:get("fallback", cache_key)
    if cached_result ~= nil then
      return cached_result
    end
  end

  local line = vim.api.nvim_buf_get_lines(buffer_id, current_row - 1, current_row, false)[1] or ""
  local matches = safe_regex_matcher(line)

  -- Check for math zones in the current line
  for _, zone in ipairs(matches) do
    if current_col >= zone.start and current_col <= zone.stop then
      -- Cache the result if caching is enabled
      if M.config.use_cache then
        M.cache:set("fallback", cache_key, true)
      end
      return true
    end
  end

  -- Cache the result as false if no match was found
  if M.config.use_cache then
    M.cache:set("fallback", cache_key, false)
  end

  return false
end

------------------------------------------------------------------------------
-- ENVIRONMENT DETECTION
------------------------------------------------------------------------------
local function in_environment(env_name)
  local current_row = get_cursor_pos()

  -- Check cache first if caching is enabled
  local cache_key = string.format("%d:%s", current_row, env_name)
  local cached_result = M.config.use_cache and M.cache:get("environment", cache_key)
  if cached_result ~= nil then
    return cached_result
  end

  local start_patterns = {
    "\\begin{" .. env_name .. "}",
    "\\start" .. env_name,
  }

  local end_patterns = {
    "\\end{" .. env_name .. "}",
    "\\stop" .. env_name,
  }

  local last_start_marker = nil
  for line_num = current_row, 1, -1 do
    local text = vim.api.nvim_buf_get_lines(buffer_id, line_num - 1, line_num, false)[1] or ""

    for _, pat in ipairs(start_patterns) do
      if text:find(pat, 1, true) then
        last_start_marker = line_num
        break -- Break after finding a start marker
      end
    end

    if last_start_marker then
      break
    end
  end

  if not last_start_marker then
    if M.config.use_cache then
      M.cache:set("environment", cache_key, false)
    end
    return false
  end

  for line_num = last_start_marker, vim.api.nvim_buf_line_count(0) do
    local text = vim.api.nvim_buf_get_lines(buffer_id, line_num - 1, line_num, false)[1] or ""

    for _, pat in ipairs(end_patterns) do
      if text:find(pat, 1, true) then
        local result = line_num > current_row and last_start_marker < current_row
        if M.config.use_cache then
          M.cache:set("environment", cache_key, result)
        end
        return result
      end
    end
  end

  local result = last_start_marker < current_row
  if M.config.use_cache then
    M.cache:set("environment", cache_key, result)
  end
  return result
end

------------------------------------------------------------------------------
-- SPECIFIC ENVIRONMENT CHECKS
------------------------------------------------------------------------------
M.in_text = function()
  return in_environment("text") and not M.math_mode()
end

M.in_tikz = function()
  return in_environment("tikzpicture")
end

M.in_bullets = function()
  return in_environment("itemize") or in_environment("enumerate")
end

M.in_MPcode = function()
  return in_environment("MPcode")
end

local function is_math_range()
  local math_ranges = {
    "formula",
    "placeformula",
    "subformulas",
    "equation",
    "align",
    "displaymath",
    "gather",
    "multline",
  }

  for _, env in ipairs(math_ranges) do
    if in_environment(env) then
      return true
    end
  end

  return false
end

function M.is_in_sile_display_math()
  local current_row, current_col = get_cursor_pos()
  local cache_key = string.format("%d:%d", current_row, current_col)

  -- Check cache first
  if M.config.use_cache then
    local cached_result = M.cache:get("sile_display_math", cache_key)
    if cached_result ~= nil then
      return cached_result
    end
  end

  -- Look for the begin marker above the current row
  local begin_row = nil
  for row = current_row, 1, -1 do
    local line = vim.api.nvim_buf_get_lines(buffer_id, row - 1, row, false)[1] or ""
    if line:match("\\begin%[mode=display%]{math}") then
      begin_row = row
      break
    end
  end

  -- Return false if no begin marker is found
  if not begin_row then
    if M.config.use_cache then
      M.cache:set("sile_display_math", cache_key, false)
    end
    return false
  end

  -- Look for end marker below the last found begin marker
  local end_row = nil
  for row = begin_row, vim.api.nvim_buf_line_count(buffer_id) do
    local line = vim.api.nvim_buf_get_lines(buffer_id, row - 1, row, false)[1] or ""
    if line:match("\\end{math}") then
      end_row = row
      break
    end
  end

  -- Check if the cursor is within the display math environment
  local result = begin_row <= current_row and (not end_row or current_row <= end_row)

  if M.config.use_cache then
    M.cache:set("sile_display_math", cache_key, result)
  end
  return result
end

------------------------------------------------------------------------------
-- TEXT COMMAND DETECTION
------------------------------------------------------------------------------
local function is_cursor_in_text_command()
  local current_row, current_col = get_cursor_pos()
  local cache_key = string.format("%d:%d", current_row, current_col)

  -- Check cache for result if caching is enabled
  local cached_result = M.config.use_cache and M.cache:get("text_command", cache_key)
  if cached_result ~= nil then
    return cached_result
  end

  local line = vim.api.nvim_buf_get_lines(buffer_id, current_row - 1, current_row, false)[1] or ""
  local text_start = line:find("\\text{")
  local text_end = line:find("}")

  local result = text_start and text_end and text_start < current_col and current_col < text_end
  if M.config.use_cache then
    M.cache:set("text_command", cache_key, result) -- Store result in cache
  end
  return result
end

------------------------------------------------------------------------------
-- MATH MODE DETECTION
------------------------------------------------------------------------------
function M.math_mode()
  return (M.config.use_cache and M.cache:get("mathzone", string.format("%d:%d", get_cursor_pos())) == true)
    or (M.is_mathzone() or M.is_mathzone_fallback() or is_math_range() or M.is_in_sile_display_math())
      and not is_cursor_in_text_command()
end

------------------------------------------------------------------------------
-- NEOVIM INTEGRATION
------------------------------------------------------------------------------
vim.api.nvim_create_user_command("CheckCursorMathZone", function()
  if M.math_mode() then
    print("Cursor is in a math mode")
  else
    print("Cursor is NOT in a math mode")
  end
end, {})

-- Initialize with default settings
M.setup({
  cache_size = 500,
  use_cache = true, -- Enable or disable caching
  eviction_strategy = "arc",
  incremental_parsing = {
    enabled = true,
    max_lines_for_full_parse = function()
      local line_count = vim.api.nvim_buf_line_count(buffer_id)
      return math.max(line_count, 1000) -- Minimum 1000 lines for full parse
    end,
    -- partial_update_threshold = 50, -- Lines for partial updates
  },
  debug = false, -- Enable debug logging
})

vim.api.nvim_create_user_command("DebugSileMath", function()
  local current_row, current_col = get_cursor_pos()
  local line = vim.api.nvim_buf_get_lines(buffer_id, current_row - 1, current_row, false)[1] or ""

  print("SILE Math Debug")
  print("Current line:", line)
  print("Cursor position:", current_row, current_col)
  print("In math mode:", M.math_mode())
  print("In math environment:", in_environment("math"))
  print("In SILE display math:", M.is_in_sile_display_math())

  -- Test pattern matching
  local test_string = "\\begin[mode=display]{math}"
  print("Test string:", test_string)
  print("Matches pattern \\begin%[mode=display%]{math}:", test_string:match("\\begin%[mode=display%]{math}") ~= nil)
end, {})

return M

```

Next, test it with:

```lua
    -- Assumming that you have a directory called `TEX` containing `conditions.lua` under the `lua`, e.g `~/.config/nvim/lua`.
    local tex = require("TEX.conditions")

    autosnippet({ trig='//', name='fraction', dscr="fraction (general)"},
    fmta([[
    \frac{<>}{<>} <>
    ]],
    { i(1), i(2), i(0) }),
    { condition = tex.math_mode }),

```
And in the following

```tex
   \begin{document} or \starttext

   \startformula or \begin{equation} or \begin[mode=display]{math}
      {1}
   \stopformula or \end{equation} or \end{math}

   {2}
   ${3}$ {4} ${5} \text{{6}}$ or \math{x^2{7}}
   \end{document} or \stoptext
```
the trigger `//` should be expanded to `\frac{}{} ` at {1}, {3}, {5} and {7} but not at {2} or {4} or {6}. Anything inside `\text{}` is treated as `text` not `mathmode`.