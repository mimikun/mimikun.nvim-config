User contributed tips and tricks for how to do cool things with toggleterm
Please feel free to add yours in.

## Windows
### Using Toggleterm with Powershell
toggleterm can be used with [PowerShell](https://github.com/powershell/powershell), but some extra configuration is required.

Neovim has a built in help section on PowerShell that explains the setup as well:
```
:help shell-powershell
```

All of the following options have to be set **before** `require("toggleterm").setup{}` is called or they won't have any effect.

First choose which installation of PowerShell (Windows, Stable, Preview) to use:

```vim
" This line will use Windows PowerShell on
" Windows systems and PowerShell 6+ "Core" on others.
let &shell = has('win32') ? 'powershell' : 'pwsh'

" To always use PowerShell 6+, even on Windows,
" use one of these lines instead:

" For PowerShell Stable
let &shell = 'pwsh'
" For PowerShell Preview
let &shell = 'pwsh-preview'
```

The following are always the same for all releases of PowerShell:

```vim
let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
let &shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
set shellquote= shellxquote=
```

You can set these values in `lua` using

```lua
local powershell_options = {
  shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
  shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
  shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
  shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
  shellquote = "",
  shellxquote = "",
}

for option, value in pairs(powershell_options) do
  vim.opt[option] = value
end
```

Helpful links may be:

https://github.com/neovim/neovim/issues/15634  
https://github.com/akinsho/toggleterm.nvim/issues/178

### Using Toggleterm with GitBash

```lua
require'toggleterm'.setup({
    open_mapping = '<C-\\>',
    start_in_insert = true,
    direction = 'float',
})
```

Then find a nice place to place below:

```lua
vim.cmd [[let &shell = '"<Path to Your GitBash>"']]
vim.cmd [[let &shellcmdflag = '-s']]
```

Save all, enable, and then restart your lady (just kidding) (it works on my PC anyway, using Windows terminal with nushell) :P 

## Init a terminal if not exist

By default, if no terminal exists. The command "ToggleTermToggleAll" will not show any terminal at first. So this function will help you in this case.
If a terminal buffer with the name 'toggleterm#' exists, it will be toggled. Otherwise, a new one will be created.

```lua
local M = {}

M.init_or_toggle = function()
	vim.cmd([[ ToggleTermToggleAll ]])

	-- list current buffers
	local buffers = vim.api.nvim_list_bufs()

	-- check if toggleterm buffer exists. If not then create one by vim.cmd [[ exe 1 . "ToggleTerm" ]]
	local toggleterm_exists = false
	for _, buf in ipairs(buffers) do
		local buf_name = vim.api.nvim_buf_get_name(buf)
		if buf_name:find("toggleterm#") then
			toggleterm_exists = true
			break
		end
	end

	if not toggleterm_exists then
		vim.cmd([[ exe 1 . "ToggleTerm" ]])
	end
end

return M
```

```lua
-- which key
{
  t = { require("your_terminal_config").init_or_toggle, " Toggle Terminal(s)" },
}
```
