---
# ⚡ Workspace Symbols Search

> [!CAUTION]
> Telescope doesn't seem to work stably for symbol search. We highly recommend using Fzf-lua instead!

<details>

<summary>Solution</summary>

- Using Fzf-lua

```vim
:FzfLua lsp_live_workspace_symbols
```
![image](https://github.com/nvim-java/nvim-java/assets/18459807/09932ab9-f9eb-40fc-b302-081256e48adf)

- Using telescope

```vim
:Telescope lsp_dynamic_workspace_symbols
```

![image](https://github.com/nvim-java/nvim-java/assets/18459807/5c3be6a3-16ee-4745-a202-71d17ea0f130)

</details>

---
# ⚡ Running Code Actions

> [!WARNING]
> We are still working on some of the code actions. If a code actions is missing you really want, request the feature [here](https://github.com/nvim-java/nvim-java/issues/new?assignees=&labels=enhancement&projects=&template=feature_request.yml&title=feature%3A+).
> This helps us to prioritize the most requested features first.

<details>

<summary>Solution</summary>

## Basics

Code actions can be run using the `vim.lsp.buf.code_action()` but if you want to perform a specific code action, you can use following. 

```lua
vim.lsp.buf.code_action({
  context = { only = { "<code_action>" } },
                     -- ^^^^^^^^^^^^^ Replace the actual code action you want to perform
  apply = true,
  -- ^^ if there is only one action, directly apply it without selection prompt
})
```

## Available code actions

- `quickassist`
- `refactor.assign.field`
- `refactor.assign.variable`
- `refactor.change.signature`
- `refactor.extract.constant`
- `refactor.extract.field`
- `refactor.extract.function`
- `refactor.extract.interface`
- `refactor.extract.variable`
- `refactor.introduce.parameter`
- `refactor.move`
- `source.generate`
- `source.generate.accessors`
- `source.generate.constructors`
- `source.generate.delegateMethods`
- `source.generate.finalModifiers`
- `source.generate.hashCodeEquals`
- `source.generate.toString`
- `source.organizeImports`
- `source.overrideMethods`
- `source.sortMembers`

## Keymap for Code Action

Following will set <kbd>leader</kbd> + <kbd>c</kbd> + <kbd>o</kbd>. 
By registering the keymap on `jdtls` `on_attach` event, we can make sure it's only added within Java projects.

```lua
vim.keymap.set('n', '<leader>co', function()
  vim.lsp.buf.code_action({
    context = { only = { 'source.organizeImports' } },
    apply = true,
  })
end)
```

</details>