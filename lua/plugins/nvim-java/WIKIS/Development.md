# How the hell code actions work

<details>

<summary>Details</summary>

- There are `java.*` actions that's being called by Language Servers. Following are the defined [commands in VSCode](
https://github.com/redhat-developer/vscode-java/blob/fdfccb29a6dbafaf4cda35ff7693e05bfd0f4eeb/src/commands.ts)

- As client, [nvim-java-refactor](https://github.com/nvim-java/nvim-java-refactor) registers client commands to `vim.lsp.commands` at jdtls LS attach live we have done [here](https://github.com/nvim-java/nvim-java-refactor/blob/ea1420fed5463c9cc976c2b4175f434b3646f0f7/lua/java-refactor/init.lua?plain=1#L20-L22)

- God knows where is the documentation that defines the approach to handle the action on client side but we could try to replicate what VSCode is doing.

  1. First of all, I would start by grep searching the command in VSCode Java project. Ex:- `java.action.overrideMethodsPrompt`
  2. Commands are defined as constants in [commands.ts](https://github.com/redhat-developer/vscode-java/blob/fdfccb29a6dbafaf4cda35ff7693e05bfd0f4eeb/src/commands.ts) file
  3. Do a reference check and find the client command implementation. Ex:- [source](https://github.com/redhat-developer/vscode-java/blob/fdfccb29a6dbafaf4cda35ff7693e05bfd0f4eeb/src/sourceAction.ts?plain=1#L43-L87)
  4. Sometimes we might have to send some LSP requests to complete the command. [source](https://github.com/redhat-developer/vscode-java/blob/fdfccb29a6dbafaf4cda35ff7693e05bfd0f4eeb/src/sourceAction.ts?plain=1#L81-L84)
  5. Some functions such as `apply_workspace_edit` is available through `vim.lsp.util`

</details>

# VSCode to Neovim Guide

<details>

<summary>Details</summary>

We are using `request` function of `vim.lsp.Client` function to communicate with
the `jdtls`.

```lua
fun(method: string, params: table?, handler: lsp.Handler?, bufnr: integer?): boolean, integer?`)
```

This has almost 1 to 1 mapping with `vscode` APIs most of the time.

```typescript
await this.languageClient.sendRequest(
  method: string,
  params: any,
  // handler is not passed since there is async / await
  // buffer I'm guessing is set to current buffer by default???
);
```

However, some APIs sends more arguments, to which we don't have a Neovim lua
equivalent I'm guessing. Following is an example.

```typescript
await this.languageClient.sendRequest(
  CompileWorkspaceRequest.type,
  isFullCompile,
  token,
);
```

To make this request, probably `client.rpc.request` should be used without
`request()` wrapper.
</details>