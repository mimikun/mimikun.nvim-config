# Getting Started

[Fork](https://github.com/nvim-tree/nvim-tree.lua/fork) this repo and read through [CONTRIBUTING.md](https://github.com/nvim-tree/nvim-tree.lua/blob/master/CONTRIBUTING.md)

If you're new to Nvim lua programming, take a look at [Neovim Plugins Challenges](https://github.com/uanela/nvim-plugin-challenges) (thanks [@uanela](https://github.com/uanela)) for some excercises to get you started on a variety of APIs, options and use cases.

# Clean Room

It is strongly advised to develop in a "clean room" using the minimal configuration, so that your plugins and other customisations don't interfere with nvim-tree.

See [bug report](https://github.com/nvim-tree/nvim-tree.lua/issues/new?assignees=&labels=bug&template=bug_report.yml) for some background on the minimal configuration.

```sh
cp .github/ISSUE_TEMPLATE/nvt-min.lua /tmp
```

Change

```lua
      "nvim-tree/nvim-tree.lua",
```

to your fork e.g.

```lua
      "~/src/nvim-tree.lua.myfork",
```

Run with

```sh
nvim -nu /tmp/nvt-min.lua
```

# Lua Language Server

[luals](https://luals.github.io) is strongly advised during development. It provides autocomplete, navigation etc. as well as diagnostics.

`scripts/luals-check.sh` is run during CI and must return no issues.

## Setup

[neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) is the "official" lsp manager.

See [luals quickstart config](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls)

Minimal example:
```lua
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
  capabilities = vim.lsp.protocol.make_client_capabilities(),
})
```

See [@alex-courtis](https://www.github.com/alex-courtis) language server setup:
* [nvim-lspconfig](https://github.com/alex-courtis/arch/blob/1f3b7f2abbd98b6389a5a6028edd1b00cf9040e5/config/nvim/lua/amc/plugins/lsp.lua#L67)

## Formatting

[EmmyLuaCodeStyle](https://github.com/CppCXY/EmmyLuaCodeStyle) is the default lua-language-server formatter. It's `CodeFormat` utility is used for CI and CLI styling.

You can format via the standard `vim.lsp.buf.format()`

A convenience function and mapping:
```lua
local function format()
  -- use LSP formatting if available for this buffer
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if client.server_capabilities.documentFormattingProvider then
      vim.lsp.buf.format()
      return
    end
  end

  -- fall back to vim native
  vim.cmd([[silent! norm! gg=G``]])
end

vim.keymap.set("n", "<leader>f", format, { desc = "format" })
```

## Completion Engine

[hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) provides completion and integrates with the language server via [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)

Neovim 0.10+ provides snippet support, notably parameters.

See [@alex-courtis](https://www.github.com/alex-courtis) language server and completion setup: `<C-space>` to complete, `<tab>` to navigate parameters:
* [nvim-lspconfig and cmp-nvim-lsp](https://github.com/alex-courtis/arch/blob/1f3b7f2abbd98b6389a5a6028edd1b00cf9040e5/config/nvim/lua/amc/plugins/lsp.lua#L27)
* [nvim-cmp](https://github.com/alex-courtis/arch/blob/1f3b7f2abbd98b6389a5a6028edd1b00cf9040e5/config/nvim/lua/amc/plugins/cmp.lua#L30)
* [snippets mappings](https://github.com/alex-courtis/arch/blob/1f3b7f2abbd98b6389a5a6028edd1b00cf9040e5/config/nvim/lua/amc/init/late/map.lua#L178)

## Alternative Setup: Native neovim Configuration

[neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) plugin not required, needs explicit setup.

Start `lua-language-server` via `:help vim.lsp.start` when a buffer's `&filetype` is set:
```lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.lsp.start {
      name = "my-luals",
      cmd = { "lua-language-server" },
      root_dir = vim.fs.root(0, '.luarc.json'),
    }
  end,
})
```

`name` and `root_dir` identifies the instance, which will be joined on `vim.lsp.start`, rather than starting a new instance.

`root_dir` searches up the filesystem from the open buffer until nvim-tree's [.luarc.json](https://github.com/nvim-tree/nvim-tree.lua/blob/master/.luarc.json) is found.

# Debug Logging

Using `print` can be a little problematic when there are many messages.

See `:help nvim-tree.log`

Enable dev type:
```lua
    log = {
      enable = true,
      truncate = true,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        dev = true,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false,
      },
    },
```

Require the logger:
```lua
local log = require "nvim-tree.log"
```

Add string.format style log lines e.g.:
```lua
log.line("dev", "do_copy uid %d '%s' -> '%s'", source_stats.uid, source, destination)
```

Watch:
```sh
tail -F ${XDG_STATE_HOME}/nvim/nvim-tree.log
```

# Re-running setup

Setup may be run many times by the user and you are encouraged to test it.

```lua
:lua _G.setup()
```

# OS Feature Flags

OS may be tested via [utils.lua](https://github.com/nvim-tree/nvim-tree.lua/blob/master/lua/nvim-tree/utils.lua) convenience fields.

## Windows

Please ensure that windows specific fixes and features are behind the appropriate feature flag(s).

e.g.

```lua
--- path is an executable file or directory
---@param absolute_path string
---@return boolean
function M.is_executable(absolute_path)
  if M.is_windows or M.is_wsl then
    --- executable detection on windows is buggy and not performant hence it is disabled
    return false
  else
    return vim.loop.fs_access(absolute_path, "X") or false
  end
```

## Feature Flag Enumeration

[Script](https://github.com/nvim-tree/nvim-tree.lua/issues/2467#issuecomment-1763229460) run by [various users ~2023 10](https://github.com/nvim-tree/nvim-tree.lua/issues?q=is%3Aissue+has.lua.gz) to evaluate `vim.fn.has` for all known feature flags from [src/nvim/eval/funcs.c](https://github.com/neovim/neovim/blob/a6e74c1f0a2bbf03f5b99c167b549018f4c8fb0d/src/nvim/eval/funcs.c#L3052)

Notable:

### Linux

```
linux=1
mac=0
macunix=0
osx=0
osxdarwin=0
unix=1
win32=0
win64=0
wsl=0
```

### WSL

```
linux=1
mac=0
macunix=0
osx=0
osxdarwin=0
unix=1
win32=0
win64=0
wsl=1
```

### PowerShell

```
linux=0
mac=0
macunix=0
osx=0
osxdarwin=0
unix=0
win32=1
win64=1
wsl=0
```

nvim-qt also: `gui_running=1`

### macOS

```
linux=0
mac=1
macunix=1
osx=1
osxdarwin=1
unix=1
win32=0
win64=0
wsl=0
```

### Cygwin

Unknown

### msys2

```
linux=0
mac=0
macunix=0
osx=0
osxdarwin=0
unix=0
win32=1
win64=1
wsl=0
```
