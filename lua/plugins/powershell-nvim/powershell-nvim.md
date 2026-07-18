# DAP

By default, the plugin includes the following [nvim-dap](https://github.com/mfussenegger/nvim-dap) configurations:

```lua
dap.configurations.ps1 = {
  {
    name = "PowerShell: Launch Current File",
    type = "ps1",
    request = "launch",
    script = "${file}",
  },
  {
    name = "PowerShell: Launch Script",
    type = "ps1",
    request = "launch",
    script = function()
      return coroutine.create(function(co)
        vim.ui.input({
          prompt = 'Enter path or command to execute, for example: "${workspaceFolder}/src/foo.ps1" or "Invoke-Pester"',
          completion = "file",
        }, function(selected) coroutine.resume(co, selected) end)
      end)
    end,
  },
  {
    name = "PowerShell: Attach to PowerShell Host Process",
    type = "ps1",
    request = "attach",
    processId = "${command:pickProcess}",
  },
}
```

To use them, simply call `require('dap').continue()` inside of a `ps1` file.

