# Sync Formatting

This is the most reliable way to format on save, since it blocks Neovim until results are applied (or the source times out).

## Code

```lua
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
})
```

# Async Formatting

## Caveats (please read!)

Async formatting works by sending a formatting request, then applying and writing results once they're received. This lets you move the cursor, scroll, and otherwise interact with the window while waiting for results, which can make formatting *seem* more responsive (but doesn't actually speed it up).

The async formatting implementation here comes with the following caveats:

- If you edit the buffer in between sending a request and receiving results, those results won't be applied.

- Each save will result in writing the file to the disk twice.

- `:wq` will **not** format the file before quitting.

The most reliable way to format files on save is to use a sync formatting method, as described above.

## Code
**NOTE**: This snippet is not part of null-ls. If it doesn't work for you, please open a discussion (not an issue). If you want to solve a bug or improve its behavior, feel free to edit this page.

```lua
local async_formatting = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    vim.lsp.buf_request(
        bufnr,
        "textDocument/formatting",
        vim.lsp.util.make_formatting_params({}),
        function(err, res, ctx)
            if err then
                local err_msg = type(err) == "string" and err or err.message
                -- you can modify the log message / level (or ignore it completely)
                vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
                return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
                return
            end

            if res then
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd("silent noautocmd update")
                end)
            end
        end
    )
end

local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    -- add your sources / config options here
    sources = ...,
    debug = false,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    async_formatting(bufnr)
                end,
            })
        end
    end,
})
```

# Choosing a client for formatting

On Neovim v0.8+, when calling `vim.lsp.buf.format` as done in the examples above, you may want to filter the available formatters so that only null-ls receives the formatting request:

```lua
local callback = function()
    vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
            return client.name == "null-ls"
        end
    })
end,
```

Otherwise, when calling `vim.lsp.buf.format`, other formatters from other clients attached to the buffer may attempt to perform a format.

# Plugins

- [lsp-format.nvim](https://github.com/lukas-reineke/lsp-format.nvim): sets up async formatting on save in a single line