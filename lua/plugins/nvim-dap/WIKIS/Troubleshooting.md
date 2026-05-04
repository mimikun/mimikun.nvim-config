## Checklist
* Is the according adapter and nvim-dap [installed](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation) (`whereis ADAPTER`)?
* Are adapter and nvim-dap [configured](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode)?
* Check the output of `file BINARY_NAME` for debug symbols
  * If the output shows no debug symbols or stripped ones: fix the build command. [How to enable debug symbols in various languages and build systems.]()
* Does the sign on the left side show a `R` for `DapBreakpointRejected`?
  * If yes: Symbols may be resolved at compilation time (ie C macros). Use the according compiler to debug those.
  * If yes: Otherwise your binary must load in future as shared library or this behavior is wrong.
* Can you make nvim-dap pause execution with a breakpoint?
  * Try the `main` or `_start` method or the according entry point of your program or language.
* Could your code use undefined behavior?
  * Try to use breakpoints or logging instructions at or near function beginnings.