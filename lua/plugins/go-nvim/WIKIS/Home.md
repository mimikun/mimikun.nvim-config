# Install
https://github.com/ray-x/go.nvim#installation
If you install first time
```
GoInstallBinaries
```
And 
```
checkhealth
```
# Dependency
Some of the commands can work without other plugins: e.g. GoBuild
Recommend installing all dependencies
* guihua.lua
* treesitter
* lspconfig
* dap related
  * dap.nvim
  * dap-ui
  * dap-virtual-text

# Tips
* Lots of commands relay on treesitter, which means you need to put your cursor on correct text/context to make the plugin more efficient
  - e.g. to test a function, put cussor inside the function need to be test. To test a sub-test inside test function, put cursor on the sub test name.
         
