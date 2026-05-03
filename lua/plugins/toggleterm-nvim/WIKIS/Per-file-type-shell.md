The function `shell` defined by your config is called two times: first in the buffer of the file you call it from, which has its own filetype, and the return value is ignored, and the second time in the buffer of the terminal, with filetype `toggleterm`, and the return value is used as the shell to call.

Thus, to change the shell on the basis of file type, we need to process the file type the first time the function is called, save the shell we want to call, and then return that value the second time.

Here is an example that will call radian for R files, ipython for python files, and the default shell for all other files.

On top of you config file, put:

```
local shell = nil
```

In your `require("toggleterm").setup` function, use:

```
shell = function()
  ft = vim.bo.filetype
  vim.print("File type: "..ft)
  if ft == "r" then
    shell = "radian"
  elseif ft == "python" then
    shell = "ipython"
  elseif ft == "toggleterm" then
    return shell
  else
    shell = vim.o.shell
  end
  return shell
end,
``` 