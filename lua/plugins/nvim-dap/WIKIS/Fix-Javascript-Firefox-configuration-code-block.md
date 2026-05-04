
### Contents

- [C/C++/Rust (via lldb-vscode)](#ccrust-via-lldb-vscode)
- [C/C++/Rust (via vscode-cpptools)](#ccrust-via-vscode-cpptools)
- [C/C++/Rust (via codelldb)](#ccrust-via-codelldb)
- [Go](#Go)
- [Go (using delve directly)](#go-using-delve-directly)
- [Java](https://github.com/mfussenegger/nvim-dap/wiki/Java)
- [Mockdebug](#Mockdebug)
- [Python](#Python)
- [Ruby](#Ruby)
- [Dart](#Dart)
- [Haskell](#Haskell)
- [Javascript/Node](#Javascript)
- [Javascript/Chrome](#Javascript-chrome)
- [Javascript/Firefox](#Javascript-firefox)
- [PHP](#PHP)
- [Scala](#Scala)
- [Neovim Lua](#neovim-lua)
- [.NET (csharp, fsharp)](#Dotnet)
- [Unity](#Unity)
- [Elixir](#Elixir)
- [Godot gdscript](#godot-gdscript)
- [Bash via bashdb](#bash)

---


Some examples below are in lua, if you want to set up `nvim-dap` in a `.vim` file, you have to wrap the code blocks like this:

```
lua <<EOF
-- lua code goes here
EOF
```

See `:help lua-commands`


## Python


Install [debugpy](https://github.com/microsoft/debugpy) into a virtualenv

```bash
mkdir .virtualenvs
cd .virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
```

You can then either use [nvim-dap-python][1] - it comes with adapter and configurations definitions - or define them manually as follows:


```lua
local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = 'path/to/virtualenvs/debugpy/bin/python';
  args = { '-m', 'debugpy.adapter' };
}
```


```lua
local dap = require('dap')
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}
```
You can refer to the virtualenv environment variable with
```shell
command = os.getenv("VIRTUAL_ENV") .. "/bin/python"
```

## C/C++/Rust (via [vscode-cpptools](https://github.com/Microsoft/vscode-cpptools))

Moved to [C/C++/Rust (cpptools)](https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools))

## C/C++/Rust (via [codelldb](https://github.com/vadimcn/vscode-lldb))

See [C/C++/Rust (codelldb)](https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb))

## C/C++/Rust (via lldb-vscode)

Modern LLDB installations come with a binary called `lldb-vscode` (or `lldb-vscode-11`).
For the following to work, make sure the binaries `lldb-vscode` depends on (`llvm-symbolizer`) are in your `PATH`.

Adapter:

```lua
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}
```

Configurations:

```lua
local dap = require('dap')
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
```

If you want to be able to attach to running processes, add another configuration entry like described here:

- https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#pick-a-process


You can find more configurations options here:

- https://github.com/llvm/llvm-project/tree/main/lldb/tools/lldb-vscode#configurations
- https://github.com/llvm/llvm-project/blob/release/11.x/lldb/tools/lldb-vscode/package.json


### Environment variables


`lldb-vscode` by default doesn't inherit the environment variables from the parent. If you want to inherit them, add the `env` property definition below to your `configurations` entries.

```lua
  env = function()
    local variables = {}
    for k, v in pairs(vim.fn.environ()) do
      table.insert(variables, string.format("%s=%s", k, v))
    end
    return variables
  end,
```

### LLDB commands

You can execute LLDB debugger commands such as `bt`, `parray` or `register read rax` on the `dap>` command line by prefixing them with `` ` `` (for example `` `bt ``).

### Building lldb-vscode
Adapted from [build instructions for clangd](https://github.com/llvm/llvm-project/blob/d480f968ad8b56d3ee4a6b6df5532d485b0ad01e/clang-tools-extra/clangd/README.md)

For a minimal setup on building lldb-vscode:
- Clone the LLVM repo to `$LLVM_ROOT`.
- Create a build directory, for example at `$LLVM_ROOT/build`.
- Inside the build directory run: `cmake $LLVM_ROOT/llvm/
  -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="lldb" -G Ninja`.
  - We suggest building in `Release` mode as building DEBUG binaries requires
    considerably more resources. You can check
    [Building LLVM with CMake documentation](https://llvm.org/docs/CMake.html)
    for more details about cmake flags.

- Afterwards you can build lldb-vscode with `cmake --build $LLVM_ROOT/build --target
  lldb-vscode`.
- same for lldb-server `cmake --build $LLVM_ROOT/build --target
  lldb-server`.

### Installation with Homebrew
An easy way to install `lldb-vscode` is to use `brew`
```bash
$ brew install llvm
```
Then executable file `lldb-vscode` and `lldb-server` are under this path `$(brew --prefix llvm)/bin`.
## Mockdebug

Vscode offers a [mock implementation for a debug adapter for testing](https://github.com/Microsoft/vscode-mock-debug). It can "debug" READMEs.

Clone the repo and run npm:

```bash
git clone https://github.com/Microsoft/vscode-mock-debug.git
cd vscode-mock-debug
npm install
```

Add the adapter and configuration:

```lua
  local dap = require "dap"
  dap.adapters.markdown = {
    type = "executable",
    name = "mockdebug",
    command = "node",
    args = {"./out/debugAdapter.js"},
    cwd = "path/to/vscode-mock-debug/"
  }

  dap.configurations.markdown = {
     {
        type = "mock",
        request = "launch",
        name = "mock test",
        program = "/path/to/a/readme.md",
        stopOnEntry = true,
        debugServer = 4711
     }
   }
```

## Go

- Install [delve](https://github.com/go-delve/delve/tree/master/Documentation/installation)
  - `go install github.com/go-delve/delve/cmd/dlv@latest`
  - or via package manager (`pacman -S delve`)
- Install [vscode-go](https://github.com/golang/vscode-go)
  - `git clone https://github.com/golang/vscode-go`
  - `cd vscode-go`
  - `npm install`
  - `npm run compile`

- Add the adapter and configuration:


```lua
dap.adapters.go = {
  type = 'executable';
  command = 'node';
  args = {os.getenv('HOME') .. '/dev/golang/vscode-go/dist/debugAdapter.js'};
}
dap.configurations.go = {
  {
    type = 'go';
    name = 'Debug';
    request = 'launch';
    showLog = false;
    program = "${file}";
    dlvToolPath = vim.fn.exepath('dlv')  -- Adjust to where delve is installed
  },
}
```

## Go (using delve directly)

Newer version of delve experimentally implement the DAP directly so that it can be used without installing vscode-go.
[More info](https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md)

Install delve:

- `go install github.com/go-delve/delve/cmd/dlv@latest`
- or via package manager. For example `pacman -S delve`

Once delve is installed you can use [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) (a nvim-dap extension) to automatically configure `delve` running in dap mode. The extension also allows debugging individual Go tests.

If you prefer to provide your own configuration, you will need to setup the `dap.adapters.go` and the `dap.configurations.go` like:

```lua
dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = {'dap', '-l', '127.0.0.1:${port}'},
  }
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages 
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  } 
}
```

If you prefer to start delve manually, you can use the following adapter definition instead:

```lua
  dap.adapters.delve = {
    type = "server",
    host = "127.0.0.1",
    port = 38697,
  }
```

And start delve like this:

```bash
dlv dap -l 127.0.0.1:38697 --log --log-output="dap"
```


## Ruby


Via [nvim-dap-ruby](https://github.com/suketa/nvim-dap-ruby) or manually:

### with Ruby Debug

Add [`debug`](https://github.com/ruby/debug) to your `Gemfile`

```lua
dap.adapters.ruby = function(callback, config)
  callback {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
      command = "bundle",
      args = { "exec", "rdbg", "-n", "--open", "--port", "${port}",
        "-c", "--", "bundle", "exec", config.command, config.script,
      },
    },
  }
end

dap.configurations.ruby = {
  {
    type = "ruby",
    name = "debug current file",
    request = "attach",
    localfs = true,
    command = "ruby",
    script = "${file}",
  },
  {
    type = "ruby",
    name = "run current spec file",
    request = "attach",
    localfs = true,
    command = "rspec",
    script = "${file}",
  },
}
```

### with redapt
- Install [readapt](https://github.com/castwide/readapt)
- Add the adapter and configuration:

```lua
local dap = require('dap')
dap.adapters.ruby = {
  type = 'executable';
  command = 'bundle';
  args = {'exec', 'readapt', 'stdio'};
}

dap.configurations.ruby = {
  {
    type = 'ruby';
    request = 'launch';
    name = 'Rails';
    program = 'bundle';
    programArgs = {'exec', 'rails', 's'};
    useBundler = true;
  },
}
```



## Dart
See https://github.com/puremourning/vimspector/issues/4 for reference.

This installation might change over time as the debugger doesn't officially support
being used as a standalone, but the maintainer is trying to be accomodating however the path to the executable
or the variables might change in the future

ensure you have `node` installed

  - git clone [`Dart-Code`](https://github.com/Dart-Code/Dart-Code) (the debug adapter is not avaliable as a standalone)
  - cd into the `Dart-Code` directory and run `npx webpack --mode production`
  - this will create `out/dist/debug.js` which is the executable file

*NOTE*: your `flutterSdkPath` might not be in `~/` this can vary depending on your installation method e.g. `snap`

```lua
  dap.adapters.dart = {
    type = "executable",
    command = "node",
    args = {"<path-to-Dart-Code>/out/dist/debug.js", "flutter"}
  }
  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch flutter",
      dartSdkPath = os.getenv('HOME').."/flutter/bin/cache/dart-sdk/",
      flutterSdkPath = os.getenv('HOME').."/flutter",
      program = "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    }
  }

```


## Haskell

- Install [haskell-debug-adapter][2]
  - `stack install haskell-dap ghci-dap haskell-debug-adapter`
- Add the adapter and configuration:


```lua
dap.adapters.haskell = {
  type = 'executable';
  command = 'haskell-debug-adapter';
  args = {'--hackage-version=0.0.33.0'};
}
dap.configurations.haskell = {
  {
    type = 'haskell',
    request = 'launch',
    name = 'Debug',
    workspace = '${workspaceFolder}',
    startup = "${file}",
    stopOnEntry = true,
    logFile = vim.fn.stdpath('data') .. '/haskell-dap.log',
    logLevel = 'WARNING',
    ghciEnv = vim.empty_dict(),
    ghciPrompt = "λ: ",
    -- Adjust the prompt to the prompt you see when you invoke the stack ghci command below 
    ghciInitialPrompt = "λ: ",
    ghciCmd= "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
  },
}
```

## Javascript


- Install [node-debug2][3]
  - `mkdir -p ~/dev/microsoft`
  - `git clone https://github.com/microsoft/vscode-node-debug2.git ~/dev/microsoft/vscode-node-debug2`
  - `cd ~/dev/microsoft/vscode-node-debug2`
  - `npm install`
  - `NODE_OPTIONS=--no-experimental-fetch npm run build`

- Add the adapter and configuration:


```lua
local dap = require('dap')
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}
```



Using [vscode-js-debug](https://github.com/microsoft/vscode-js-debug) instead
of [node-debug2][3] is not supported directly because it requires undocumented
debug-adapter-protocol extensions. See https://github.com/microsoft/vscode-js-debug/issues/969

There is, however, a language specific extension [nvim-dap-vscode-js][dap-vscode-js] which provides support for these dap extensions. See the documentation on that repo for installation instructions.

## Javascript Chrome

- build vscode-chrome-debug
  - git clone https://github.com/Microsoft/vscode-chrome-debug
  - cd ./vscode-chrome-debug
  - npm install
  - npm run build

- add the adapter cfg:

```lua
dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {os.getenv("HOME") .. "/path/to/vscode-chrome-debug/out/src/chromeDebug.js"} -- TODO adjust
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}

dap.configurations.typescriptreact = { -- change to typescript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}
```

note: chrome has to be started with a remote debugging port
```google-chrome-stable --remote-debugging-port=9222```

## Javascript Firefox

- build vscode-firefox-debug
  - git clone https://github.com/firefox-devtools/vscode-firefox-debug.git
  - cd vscode-firefox-debug
  - npm install
  - npm run build

`adapter.bundle.js` depends on other files from the dist folder. If you want to change the output files' location, make sure you copy the whole dist folder - **DO NOT** try to copy adapter.bundle.js **on its own** to some other folder.

- add the adapter cfg:

```lua
local dap = require('dap')
dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/path/to/vscode-firefox-debug/dist/adapter.bundle.js'},
}

dap.configurations.typescript = {
  {
    name = 'Debug with Firefox',
    type = 'firefox',
    request = 'launch',
    reAttach = true,
    url = 'http://localhost:3000',
    webRoot = '${workspaceFolder}',
    firefoxExecutable = '/usr/bin/firefox'
  }
}
```

## PHP

Install [vscode-php-debug](https://github.com/xdebug/vscode-php-debug):
 - `git clone https://github.com/xdebug/vscode-php-debug.git`
 - `cd vscode-php-debug`
 - `npm install && npm run build`

If you have not configured Xdebug, read **Installation** at
[vscode-php-debug](https://github.com/xdebug/vscode-php-debug#installation).
 
Add the adapter configuration:
```lua
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/path/to/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9000
  }
}
```
Supported configuration options for PHP can be found under *Supported launch.json settings* at the
[vscode-php-debug](https://github.com/xdebug/vscode-php-debug#supported-launchjson-settings) repo.

## Scala

Possible via [nvim-metals](https://github.com/scalameta/nvim-metals)


## Neovim Lua

Possible via [one-small-step-for-vimkind][4]


## Dotnet

Install [netcoredbg](https://github.com/Samsung/netcoredbg), either via:

 - Your package manager
 - Downloading it from the release page and extracting it to a folder
 - Building from source by following the instructions in the netcoredbg repo.


Add the adapter configuration:

```lua

dap.adapters.coreclr = {
  type = 'executable',
  command = '/path/to/dotnet/netcoredbg/netcoredbg',
  args = {'--interpreter=vscode'}
}
```

Add a configuration:

```lua
dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}
```

## Unity

Install [vscode-unity-debug](https://github.com/Unity-Technologies/vscode-unity-debug)

Install [mono](https://github.com/mono/mono) dependency if doesn't exist

Add the adapter configuration:

```lua
dap.adapters.unity = {
  type = 'executable',
  command = '<path-to-mono-directory>/Commands/mono',
  args = {'<path-to-unity-debug-directory>/unity.unity-debug-x.x.x/bin/UnityDebug.exe'}
}
```

Add a configuration:

```lua
dap.configurations.cs = {
  {
  type = 'unity',
  request = 'attach',
  name = 'Unity Editor',
  }
}

```

## Elixir

Install [elixir-ls](https://github.com/elixir-lsp/elixir-ls#building-and-running).

Add the adapter configuration:

```lua

dap.adapters.mix_task = {
  type = 'executable',
  command = '/path/to/elixir-ls/debugger.sh', -- debugger.bat for windows
  args = {}
}
```

Add a configuration ([see configuration options](https://github.com/elixir-lsp/elixir-ls#debugger-support)):

```lua
dap.configurations.elixir = {
  {
    type = "mix_task",
    name = "mix test",
    task = 'test',
    taskArgs = {"--trace"},
    request = "launch",
    startApps = true, -- for Phoenix projects
    projectDir = "${workspaceFolder}",
    requireFiles = {
      "test/**/test_helper.exs",
      "test/**/*_test.exs"
    }
  },
}
```

## Godot GDScript

Godot 4.0 includes support for the debug adapter protocol.

You need to have a Godot instance running to use it.


Adapter definition:

```lua
local dap = require('dap')
dap.adapters.godot = {
  type = "server",
  host = '127.0.0.1',
  port = 6006,
}
```

The port must match the Godot setting. Go to **Editor** -> **Editor Settings**,
then find **Debug Adapter** under **Network**:

![image](https://user-images.githubusercontent.com/38700/186951662-8a9e340a-498a-48f9-931d-dae0bffe67bd.png)



Configuration:

```lua
dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    launch_scene = true,
  }
}
```

See the `Configuration` section in the
[godot-vscode-plugin](https://github.com/godotengine/godot-vscode-plugin#gdscript-debugger)
README for a description of the configuration properties.

# Bash

Add the adapter configuration :
```lua
dap.adapters.bashdb = {
  type = 'executable';
  command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter';
  name = 'bashdb';
}
```
Add the configuration :
```lua
dap.configurations.sh = {
  {
    type = 'bashdb';
    request = 'launch';
    name = "Launch file";
    showDebugOutput = true;
    pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb';
    pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir';
    trace = true;
    file = "${file}";
    program = "${file}";
    cwd = '${workspaceFolder}';
    pathCat = "cat";
    pathBash = "/bin/bash";
    pathMkfifo = "mkfifo";
    pathPkill = "pkill";
    args = {};
    env = {};
    terminalKind = "integrated";
  }
}
```


[1]: https://github.com/mfussenegger/nvim-dap-python
[2]: https://github.com/phoityne/haskell-debug-adapter
[3]: https://github.com/microsoft/vscode-node-debug2
[4]: https://github.com/jbyuki/one-small-step-for-vimkind
[dap-vscode-js]: https://github.com/mxsdev/nvim-dap-vscode-js
