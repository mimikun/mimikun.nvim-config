# Install nvim-java on Kickstart

We have [this repository](https://github.com/nvim-java/starter-kickstart) that's preconfigured for java development. You can directly clone the repository and personalize from there.

## Instruction to Setup

- Install `nvim-java` plugin

```lua
'nvim-java/nvim-java'
```

- Add `jdtls` setup function to `mason-lspconfig` setup `handlers`

```lua
jdtls = function()
  require('java').setup {
    -- Your custom jdtls settings goes here
  }

  require('lspconfig').jdtls.setup {
    -- Your custom nvim-java configuration goes here
  }
end
```

- Add `java` treesitter parser to `ensure_installed` list

```lua
ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'java' },
```

- Enable debugging by uncommenting following line

```lua
-- require 'kickstart.plugins.debug',
```