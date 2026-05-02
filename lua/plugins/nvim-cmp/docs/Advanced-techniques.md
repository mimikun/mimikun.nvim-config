This page contains advanced techniques.

### Managing completion timing completely

nvim-cmp has a programmatic API. So you can manage the completion behavior by yourself.

See https://github.com/hrsh7th/nvim-cmp/issues/519#issuecomment-1091109258

### Disabling completion in certain contexts, such as comments

See https://github.com/hrsh7th/nvim-cmp/pull/676#issuecomment-2736795535

```lua
require('cmp').setup({
  enabled = function()
    local disabled = false
    disabled = disabled or (vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt')
    disabled = disabled or (vim.fn.reg_recording() ~= '')
    disabled = disabled or (vim.fn.reg_executing() ~= '')
    disabled = disabled or require('cmp.config.context').in_treesitter_capture('comment')
    return not disabled
  end,
})
```

### Disabling cmdline completion for certain commands, such as IncRename

```lua
cmp.setup.cmdline(':', {
  sources = { --[[ your sources ]] },
  enabled = function()
    -- Set of commands where cmp will be disabled
    local disabled = {
        IncRename = true
    }
    -- Get first word of cmdline
    local cmd = vim.fn.getcmdline():match("%S+")
    -- Return true if cmd isn't disabled
    -- else call/return cmp.close(), which returns false
    return not disabled[cmd] or cmp.close()
  end
})
```

### Add parentheses after selecting function or method item

#### nvim-autopairs

```lua
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
```

### Disable / Enable cmp sources only on certain buffers

If you encounter a situation where a specific cmp source is acting slow on certain files, either due to their size or due to a bug in the cmp source, you can run `cmp.setup.buffer({...})` as a part of an `BufReadPre` `autocmd`, instead of in the generic `cmp.setup({...})` command. Here's an example of a configuration that doesn't add sources in `cmp.setup({...})`, but sets a proper `autocmd` and doesn't add the `treesitter` source if the file is too big.

```lua
-- default sources for all buffers
local default_cmp_sources = cmp.config.sources({
	{ name = 'nvim_lsp' },
	{ name = 'nvim_lsp_signature_help' },
}, {
	{ name = 'vsnip' },
	{ name = 'path' }
})
-- If a file is too large, I don't want to add to it's cmp sources treesitter, see:
-- https://github.com/hrsh7th/nvim-cmp/issues/1522
vim.api.nvim_create_autocmd('BufReadPre', {
	callback = function(t)
		local sources = default_cmp_sources
		if not bufIsBig(t.buf) then
			sources[#sources+1] = {name = 'treesitter', group_index = 2}
		end
	cmp.setup.buffer {
		sources = sources
	}
	end
})
```

And the `bufIsBig` function, takes a buffer index and returns if it's considered big. This function can be adjusted to your liking. Here's an example that works with the above:

```lua
bufIsBig = function(bufnr)
	local max_filesize = 100 * 1024 -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
	if ok and stats and stats.size > max_filesize then
		return true
	else
		return false
	end
end
```

The example above is based upon the idea in [#1522](https://github.com/hrsh7th/nvim-cmp/issues/1522).