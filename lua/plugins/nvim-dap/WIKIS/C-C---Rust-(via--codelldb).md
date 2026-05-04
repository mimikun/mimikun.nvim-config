# C/C++/Rust (via codelldb)

Configuration examples are in Lua. See `:help lua-commands` if your Neovim setup so far uses a `init.vim` file.

## Installation

Install [codelldb](https://github.com/vadimcn/vscode-lldb):

- Download the [VS Code extension](https://github.com/vadimcn/vscode-lldb/releases).
- Unpack it. `.vsix` is a zip file and you can use `unzip` to extract the contents.


## Adapter definition

Pick one of the below sections depending on your codelldb version. See `:help
dap-adapter` for a description of the available options.

### 1.11.0 and later

Since 1.11.0 `codelldb` supports stdio for the DAP communication. Create an adapter like this:

```lua
local dap = require('dap')
dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

  -- On windows you may have to uncomment this:
  -- detached = false,
}
```

### 1.7.0 or later

Before 1.11.0 `codelldb` only supported TCP for the DAP communication - that
requires using the `server` type for the adapter definition.

Create an adapter like this:

```lua
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}
```

Or if you prefer starting `codelldb` in a separate terminal you can run it
there with `codelldb --port 13000` and then have nvim-dap connect to it with an
adapter definition like:

```lua
local dap = require('dap')
dap.adapters.codelldb = {
  type = 'server',
  host = '127.0.0.1',
  port = 13000,
}
```

### Before 1.7.0

Update to a newer version



## Configuration

The [codelldb manual](https://github.com/vadimcn/vscode-lldb/blob/master/MANUAL.md) contains a full reference for all options supported by the debug adapter.


A common configuration example:


```lua
local dap = require('dap')
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
```

If you want to use this debug adapter for other languages, you can re-use the configurations:


```lua
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
```

The executables that you want to debug need to be compiled with debug symbols.
