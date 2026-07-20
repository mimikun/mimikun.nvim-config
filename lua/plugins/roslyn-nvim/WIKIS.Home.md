# Tips and tricks

I ideally want this plugin to be pretty minimal, and mostly just a wrapper to start the roslyn server. I am not envisioning some big dev kit like vscode's plugin C# dev kit. I might add some custom handlers for the roslyn server, but I don't want to add everything.

This will be a wiki with some tips and tricks that I will probably update if there is some requests that I don't want to add to this plugin, but instead think the users can add to their config if they want this

## Diagnostic refresh

Currently, the diagnostics are a bit of a hack, and they might not always update correctly. However, it is possible to retrieve them as often as you would like with something like this:

```lua
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    pattern = "*",
    callback = function()
        local clients = vim.lsp.get_clients({ name = "roslyn" })
        if not clients or #clients == 0 then
            return
        end

        local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
        local buffers = vim.lsp.get_buffers_by_client_id(ctx.client_id)
        for _, buf in ipairs(buffers) do
            local params = { textDocument = vim.lsp.util.make_text_document_params(buf) }
            client:request("textDocument/diagnostic", params, nil, buf)
        end
    end,
})
```

Just change the `InsertLeave` event to whichever events you would like


## Remove unnecessary using directives

This is already provided with the code actions if you have the cursor over the using statements. I therefore will not add a special command for this. If you however want this, you could do something like this:

```lua
vim.api.nvim_create_user_command("CSFixUsings", function()
    local bufnr = vim.api.nvim_get_current_buf()

    local clients = vim.lsp.get_clients({ name = "roslyn" })
    if not clients or vim.tbl_isempty(clients) then
        vim.notify("Couldn't find client", vim.log.levels.ERROR, { title = "Roslyn" })
        return
    end

    local client = clients[1]
    local action = {
        kind = "quickfix",
        data = {
            CustomTags = { "RemoveUnnecessaryImports" },
            TextDocument = { uri = vim.uri_from_bufnr(bufnr) },
            CodeActionPath = { "Remove unnecessary usings" },
            Range = {
                ["start"] = { line = 0, character = 0 },
                ["end"] = { line = 0, character = 0 },
            },
            UniqueIdentifier = "Remove unnecessary usings",
        },
    }

    client:request("codeAction/resolve", action, function(err, resolved_action)
        if err then
            vim.notify("Fix using directives failed", vim.log.levels.ERROR, { title = "Roslyn" })
            return
        end
        vim.lsp.util.apply_workspace_edit(resolved_action.edit, client.offset_encoding)
    end)
end, { desc = "Remove unnecessary using directives" })
```

## textDocument/_vs_onAutoInsert

![Image](https://github.com/user-attachments/assets/321bdfd5-e437-4a45-8f8e-5da468163190)

```lua
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    if client and (client.name == "roslyn" or client.name == "roslyn_ls") then
      vim.api.nvim_create_autocmd("InsertCharPre", {
        desc = "Roslyn: Trigger an auto insert on '/'.",
        buffer = bufnr,
        callback = function()
          local char = vim.v.char

          if char ~= "/" then
            return
          end

          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          row, col = row - 1, col + 1
          local uri = vim.uri_from_bufnr(bufnr)

          local params = {
            _vs_textDocument = { uri = uri },
            _vs_position = { line = row, character = col },
            _vs_ch = char,
            _vs_options = {
              tabSize = vim.bo[bufnr].tabstop,
              insertSpaces = vim.bo[bufnr].expandtab,
            },
          }

          -- NOTE: We should send textDocument/_vs_onAutoInsert request only after
          -- buffer has changed.
          vim.defer_fn(function()
            client:request(
              ---@diagnostic disable-next-line: param-type-mismatch
              "textDocument/_vs_onAutoInsert",
              params,
              function(err, result, _)
                if err or not result then
                  return
                end

                vim.snippet.expand(result._vs_textEdit.newText)
              end,
              bufnr
            )
          end, 1)
        end,
      })
    end
  end,
})
```

## Unity

If you are unsure about how to use unity with neovim, you can try to check out this https://github.com/walcht/neovim-unity which is a very detailed documentation on how to do it.

## Session persistence of source generated files

When using plugins to restore session there might be an issue when buffer with
source generated content will be left open. Since those buffer are temporary by
design, roslyn will try to fetch content of it on session restore, which will cause
an error since id of document representing source generated content will be different.

To prevent such error it's good idea to omit saving such buffers into session state
so neovim will not try to reopen them.

### `persistence.nvim`

```lua
vim.api.nvim_create_autocmd("User", {
   pattern = "PersistenceSavePre",
   callback = function()
     for _, buf in ipairs(vim.api.nvim_list_bufs()) do
       local name = vim.api.nvim_buf_get_name(buf)
       if name:match("roslyn%-source%-generated://") then
         vim.api.nvim_buf_delete(buf, { force = true })
       end
     end
   end,
 })
```

