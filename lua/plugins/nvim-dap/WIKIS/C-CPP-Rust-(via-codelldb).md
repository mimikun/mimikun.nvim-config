# C/C++/Rust (via codelldb)

Configuration examples are in Lua. See `:help lua-commands` if your Neovim setup so far uses a `init.vim` file.

## Installation

Install [codelldb](https://github.com/vadimcn/vscode-lldb):

- Download the [VS Code extension](https://github.com/vadimcn/vscode-lldb/releases).
- Unpack it. `.vsix` is a zip file and you can use `unzip` to extract the contents.


## Adapter definition

`codelldb` uses TCP for the DAP communication - that requires using the `server` type for the adapter definition. See `:help dap-adapter`.

### Start codelldb manually in a terminal


Up to including version 1.6.10 you could launch `codelldb` and it printed out a port it was listening to:

```bash
$ codelldb
Listening on port 13123
```

Starting with version 1.7.0 it is necessary to specify the port:

```bash
$ codelldb --port 13000
```


To have nvim-dap connect to it, you can define an adapter like this:


```lua
local dap = require('dap')
dap.adapters.codelldb = {
  type = 'server',
  host = '127.0.0.1',
  port = 13000 -- 💀 Use the port printed out or specified with `--port`
}
```

With this adapter definition you'll have to launch `codelldb` manually in a
terminal first whenever you want to debug your application.

### Start codelldb automatically

If you want nvim-dap to automatically spawn the debug adapter before
connecting, you can use the following for version 1.7.0 and later:


```lua
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/absolute/path/to/codelldb/extension/adapter/codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}
```


<details>
  <summary>For version 1.6.10 and earlier</summary>

```lua
local dap = require('dap')
dap.adapters.codelldb = function(on_adapter)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  -- CHANGE THIS!
  local cmd = '/absolute/path/to/codelldb/extension/adapter/codelldb'

  local handle, pid_or_err
  local opts = {
    stdio = {nil, stdout, stderr},
    detached = true,
  }
  handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
    stdout:close()
    stderr:close()
    handle:close()
    if code ~= 0 then
      print("codelldb exited with code", code)
    end
  end)
  assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      local port = chunk:match('Listening on port (%d+)')
      if port then
        vim.schedule(function()
          on_adapter({
            type = 'server',
            host = '127.0.0.1',
            port = port
          })
        end)
      else
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end
  end)
  stderr:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
end
```

</details>


---

* **Rust-Tools only** If you are using this adapter for debugging Rust and are using the [rust-tools](https://github.com/simrat39/rust-tools.nvim) extension, there is a helper function defined for setting up `CodeLLDB`. 
This helper function works the same way as the function defined in the point above.
Set it up as defined [here](https://github.com/simrat39/rust-tools.nvim#a-better-debugging-experience).


Have a look at this [issue](https://github.com/mfussenegger/nvim-dap/issues/307) for more information on `CodeLLDB` definition.

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
