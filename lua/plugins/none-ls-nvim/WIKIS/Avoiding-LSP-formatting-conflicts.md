## Neovim 0.8

The recommended approach is to use the new `vim.lsp.buf.format` API, which makes it easy to select which server you want to use for formatting:

```lua
local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end
```

Another way is to block a client's formatting capabilities in your `on_attach` callback. This approach is not recommended versus the other approaches mentioned here:

```lua
local on_attach = function(client, bufnr)
    if client.name == "tsserver" then                                                                                                   
        client.resolved_capabilities.document_formatting = false -- 0.7 and earlier
        client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
    end
    -- rest of the initialization
end
```

## Neovim 0.7 and earlier

If a buffer is attached to more than one language server with formatting capabilities, Neovim's default formatting handler will ask you which server you want to use whenever you run `vim.lsp.buf.formatting()` or `vim.lsp.buf.formatting_sync()`. If you only want to use null-ls formatting, [you need to enable formatting only for the language server you choose to](https://github.com/neovim/nvim-lspconfig/wiki/Multiple-language-servers-FAQ#i-see-multiple-formatting-options-and-i-want-a-single-server-to-format-how-do-i-do-this). 

## Avoid breaking `formatexpr` (i.e. `gq`)

See [the discussion](https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131)

Neovim [automatically sets `formatexpr`](https://neovim.io/doc/user/lsp.html#lsp-config) (if unset) to `vim.lsp.formatexpr()` if the LSP server advertises the `documentRangeFormattingProvider` capability. Because there is no way to advertise this separately per-provider, Null-LS advertises [all capabilities it might potentially support](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/0180603b6f3cee40f83c6fc226b9ac5f85e691c4/lua/null-ls/rpc.lua#L27-L50).

This means `formatexpr` will be set whenever null-ls attaches to the buffer, whether or not any of the active sources provide a formatting method. `gq` will no-op.

A [workaround, provided by @Furkanzmc](https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131#issuecomment-1273843531), sets `formatexpr` appropriately depending on the available null-ls sources:

```lua
local function is_null_ls_formatting_enabled(bufnr)
    local file_type = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local generators = require("null-ls.generators").get_available(
        file_type,
        require("null-ls.methods").internal.FORMATTING
    )
    return #generators > 0
end

function on_attach(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
        if
            client.name == "null-ls" and is_null_ls_formatting_enabled(bufnr)
            or client.name ~= "null-ls"
        then
            vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
            vim.keymap.set("n", "<leader>gq", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
        else
            vim.bo[bufnr].formatexpr = nil
        end
    end
end
```