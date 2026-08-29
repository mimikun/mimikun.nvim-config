## Hint node-type with virtual text

Using `ext_opts` it's possible to add virtual text to nodes:
```lua
local types = require("luasnip.util.types")

require'luasnip'.config.setup({
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = {{"●", "GruvboxOrange"}}
			}
		},
		[types.insertNode] = {
			active = {
				virt_text = {{"●", "GruvboxBlue"}}
			}
		}
	},
})
```

This adds an orange dot to the end of the line if inside a `choiceNode`, and a blue one if inside an `insertNode`:

![showcase](https://user-images.githubusercontent.com/41961280/129458121-feb6510f-bec8-4146-a22f-e559bc7b00c7.gif)

## Imitate vscodes' behaviour for nested placeholders

```lua
local util = require("luasnip.util.util")
local node_util = require("luasnip.nodes.util")

ls.setup({
  parser_nested_assembler = function(_, snippetNode)
    local select = function(snip, no_move, dry_run)
      if dry_run then
        return
      end
      snip:focus()
      -- make sure the inner nodes will all shift to one side when the
      -- entire text is replaced.
      snip:subtree_set_rgrav(true)
      -- fix own extmark-gravities, subtree_set_rgrav affects them as well.
      snip.mark:set_rgravs(false, true)

      -- SELECT all text inside the snippet.
      if not no_move then
        require("luasnip.util.feedkeys").feedkeys_insert("<Esc>")
        node_util.select_node(snip)
      end
    end

    local original_extmarks_valid = snippetNode.extmarks_valid
    function snippetNode:extmarks_valid()
      -- the contents of this snippetNode are supposed to be deleted, and
      -- we don't want the snippet to be considered invalid because of
      -- that -> always return true.
      return true
    end

    function snippetNode:init_dry_run_active(dry_run)
      if dry_run and dry_run.active[self] == nil then
        dry_run.active[self] = self.active
      end
    end

    function snippetNode:is_active(dry_run)
      return (not dry_run and self.active) or (dry_run and dry_run.active[self])
    end

    function snippetNode:jump_into(dir, no_move, dry_run)
      self:init_dry_run_active(dry_run)
      if self:is_active(dry_run) then
        -- inside snippet, but not selected.
        if dir == 1 then
          self:input_leave(no_move, dry_run)
          return self.next:jump_into(dir, no_move, dry_run)
        else
          select(self, no_move, dry_run)
          return self
        end
      else
        -- jumping in from outside snippet.
        self:input_enter(no_move, dry_run)
        if dir == 1 then
          select(self, no_move, dry_run)
          return self
        else
          return self.inner_last:jump_into(dir, no_move, dry_run)
        end
      end
    end

    -- this is called only if the snippet is currently selected.
    function snippetNode:jump_from(dir, no_move, dry_run)
      if dir == 1 then
        if original_extmarks_valid(snippetNode) then
          return self.inner_first:jump_into(dir, no_move, dry_run)
        else
          return self.next:jump_into(dir, no_move, dry_run)
        end
      else
        self:input_leave(no_move, dry_run)
        return self.prev:jump_into(dir, no_move, dry_run)
      end
    end

    return snippetNode
  end,
})
```

The main reason for this not being the default is that it
- requires a lot of modification to the resulting snippets
- Doesn't work perfectly(yet): if the entire placeholder is replaced, the nested tabstops won't be skipped.

Example with `"test: ${1: this is ${2:nested} ${3:text}} ${4:yay!}"`:
![showcase](https://user-images.githubusercontent.com/41961280/134727915-931a62de-a74b-452e-8d33-a028c16cdd40.gif)

## Only jump in the current snippet
A slight change to the recommended nvim-cmp [setup](https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip) where we replace `luasnip.expand_or_jumpable()` with `luasnip.expand_or_locally_jumpable()` to only jump to a snippet field if we are currently in a snippet.
example setup:
```lua
cmp.setup({

  -- ... Your other configuration ...

  mapping = {

    -- ... Your other mappings ...

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
  }
}
```

## "Super-Tab"-like setup for Change Choice and External Update Dynamic Node
Similar to the above, but this is for setting the same keymap for changing choice if there's an active choicenode or using external update dynamic node. Since there are a lot of keymaps already, it might be nice to overload them and use the same keymap for mutually exclusive events. Set it up as follows:

```lua
-- feel free to change the keys to new ones, those are just my current mappings
local opts = { noremap = true, silent = true }

vim.keymap.set("i", "<C-f>", function()
	if ls.in_snippet() then -- added to check if you're actually in a snippet
		if ls.choice_active() then
			return ls.change_choice(1)
		else
			return _G.dynamic_node_external_update(1) -- feel free to update to any index i
		end
	end
end, opts)
vim.keymap.set("s", "<C-f>", function()
	if ls.in_snippet() then
		if ls.choice_active() then
			return ls.change_choice(1)
		else
			return _G.dynamic_node_external_update(1)
		end
	end
end, opts)
vim.keymap.set("i", "<C-d>", function()
	if ls.in_snippet() then
		if ls.choice_active() then
			return ls.change_choice(-1)
		else
			return _G.dynamic_node_external_update(2)
		end
	end
end, opts)
vim.keymap.set("s", "<C-d>", function()
	if ls.in_snippet() then
		if ls.choice_active() then
			return ls.change_choice(-1)
		else
			return _G.dynamic_node_external_update(2)
		end
	end
end, opts)
```

Also see:
- [this discussion](https://github.com/L3MON4D3/LuaSnip/discussions/885) for more context
- [this wiki page](https://github.com/L3MON4D3/LuaSnip/wiki/Misc#dynamicnode-with-user-input) for more information on external update dynamic node

## Jump into/select node under the cursor

With `ls.activate_node()` being added recently, there is now a way to jump to any snippet in the buffer.
This can be utilized with a mapping like the following:
```lua
local select_next = false
vim.keymap.set({"i"}, "<C-;>", function()
	-- the meat of this mapping: call ls.activate_node.
	-- strict makes it so there is no fallback to activating any node in the
	-- snippet, and select controls whether the text associated with the node is
	-- selected.
	local ok, _ = pcall(ls.activate_node, {
		strict = true,
        -- select_next is initially unset, but set within the first second after
        -- activating the mapping, so activating it again in that timeframe will
        -- select the text of the found node.
		select = select_next
	})
	-- ls.activate_node throws on failure.
	if not ok then
		print("No node.")
		return
	end

	-- once the node is activated, we are either done (if text is SELECTed), or
	-- we briefly highlight the text associated with the node so one can know
	-- which node was activated.
	-- TODO: this highlighting does not show up if the node has no text
	-- associated (ie ${1:asdf} vs $1), a cool extension would be to also show
	-- something if there was no text.
	if select_next then
		return
	end

	local curbuf = vim.api.nvim_get_current_buf()
	local hl_duration_ms = 100

	local node = ls.session.current_nodes[curbuf]
	-- get node-position, raw means we want byte-columns, since those are what
	-- nvim_buf_set_extmark expects.
	local from, to = node:get_buf_position({raw = true})

	-- highlight snippet for 1000ms
	local id = vim.api.nvim_buf_set_extmark(
		curbuf,
		ls.session.ns_id,
		from[1],
		from[2],
		{
			-- one line below, at col 0 => entire last line is highlighted.
			end_row = to[1],
			end_col = to[2],
			hl_group = "Visual",
		}
	)
    -- disable highlight by removing the extmark after a short wait.
	vim.defer_fn(function()
		vim.api.nvim_buf_del_extmark(curbuf, ls.session.ns_id, id)
	end, hl_duration_ms)

	-- set select_next for the next second.
	select_next = true
	vim.uv.new_timer():start(1000, 0, function()
		select_next = false
	end)
end)
```
And, of course, an example of the result :D
![out](https://github.com/L3MON4D3/LuaSnip/assets/41961280/86f0ec40-42e1-4880-9806-1fb9fd539dd4)