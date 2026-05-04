## Adapter definition

The debug adapter for Java is an extension to [eclipse.jdt.ls][eclipse.jdt.ls]: [java-debug][java-debug].

That means in order to use the debug adapter you need a language-server-protocol client.
There is no standalone Java debug adapter

### Via nvim-jdtls

Install [nvim-jdtls][nvim-jdtls] and follow the instructions in the README to setup nvim-dap.

You **do not** have to define `dap.adapters.java` yourself.


### Via other language server clients

You'll need a LSP client that supports executing custom commands. You'll have to install [java-debug][java-debug] and configure eclipse.jdt.ls to load it, see [Usage with eclipse.jdt.ls](https://github.com/microsoft/java-debug#usage-with-eclipsejdtls)

Then you can define something like this:


```lua
local dap = require('dap')
dap.adapters.java = function(callback)
  -- FIXME:
  -- Here a function needs to trigger the `vscode.java.startDebugSession` LSP command
  -- The response to the command must be the `port` used below
  callback({
    type = 'server';
    host = '127.0.0.1';
    port = port;
  })
end
```


## Configuration

You may also want to add a configuration to debug remote applications:


```lua
local dap = require('dap')
dap.configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = "Debug (Attach) - Remote";
    hostName = "127.0.0.1";
    port = 5005;
  },
}
```

A configuration to launch a main class could look like this:


```lua
local dap = require('dap')
dap.configurations.java = {
  {
     -- You need to extend the classPath to list your dependencies.
     -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
    classPaths = {},

    -- If using multi-module projects, remove otherwise.
    projectName = "yourProjectName",

    javaExec = "/path/to/your/bin/java",
    mainClass = "your.package.name.MainClassName",

    -- If using the JDK9+ module system, this needs to be extended
    -- `nvim-jdtls` would automatically populate this property
    modulePaths = {},
    name = "Launch YourClassName",
    request = "launch",
    type = "java"
  },
}
```


To get an overview of all available `attach` and `launch` options, take a look at [java-debug options](https://github.com/microsoft/vscode-java-debug#options). Keep in mind that any `java.debug` options are settings of the vscode-java client extension and not understood by the debug-adapter itself.


[eclipse.jdt.ls]: https://github.com/eclipse/eclipse.jdt.ls
[java-debug]: https://github.com/microsoft/java-debug
[nvim-jdtls]: https://github.com/mfussenegger/nvim-jdtls

