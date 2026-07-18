# Install nvim-java on Lazyvim

## Video
I have following video if you'd like to watch.

[![Watch the video](https://img.youtube.com/vi/CXv0WUX_E_Q/hqdefault.jpg)](https://youtu.be/CXv0WUX_E_Q)

## Java Playground
If you just want to try it out, I have [this devcontainer environment](https://github.com/nvim-java/play-lazyvim) that quickly spin up a new docker container with everything you need including nvim-java configured lazyvim, some maven & gradle java project for you to try. All the instructions are in the readme.

## Instruction to Setup

> [!IMPORTANT]
> For debugging, install `dap.core` `LazyExtra` package

Installing `nvim-java` is super easy

- Create a new file for java plugin `~/.config/nvim/lua/plugins/java/init.lua`
- Add the following content to the file

```lua
return {
  'nvim-java/nvim-java',
  config = false,
  dependencies = {
    {
      'neovim/nvim-lspconfig',
      opts = {
        servers = {
          jdtls = {
            -- Your custom jdtls settings goes here
          },
        },
        setup = {
          jdtls = function()
            require('java').setup({
              -- Your custom nvim-java configuration goes here
            })
          end,
        },
      },
    },
  },
}
```

- Enjoy
