This page documents extended / advanced configurations for specific sources. 

The configurations here are user-maintained and not guaranteed to work. If something is broken, fix it! If something is missing, add it!

# HTML 

## djhtml 
### set tabwidth from buffer shiftwidth 
Helpful when you have projects with different tabwidth in HTML, often in combination with `.editorconfig`. 
```lua
null_ls.builtins.formatting.djhtml.with({
    extra_args = function(params)
        return {
            "--tabwidth",
            vim.api.nvim_buf_get_option(params.bufnr, "shiftwidth"),
        }
    end,
}),
```

# Python

## pydocstyle

The `pydocstyle` config discovery ignores the CWD and searches configuration starting at the file location. Since null-ls has to use a temporary file to call `pydocstyle` it won't find the project configuration.

A workaround is to pass the config-filename to use:

```lua
local sources = {
  null_ls.builtins.diagnostics.pydocstyle.with({
    extra_args = { "--config=$ROOT/setup.cfg" }
  }),
}
```

# Rust

## rustfmt

### specifying edition

> Note: If you are using `rust-analyzer`, format with `rust-analyzer`. It reads edition from `Cargo.toml`.

Choose one of the following:

1. specify in [`rustfmt.toml`](https://rust-lang.github.io/rustfmt/?version=v1.4.38&search=).

```toml
edition = "2021"
```

2. hardcode it.

```lua
null_ls.builtins.formatting.rustfmt.with({
  extra_args = { "--edition=2021" }
})
```

3. read from `Cargo.toml`.

```lua
null_ls.builtins.formatting.rustfmt.with({
    extra_args = function(params)
        local Path = require("plenary.path")
        local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

        if cargo_toml:exists() and cargo_toml:is_file() then
            for _, line in ipairs(cargo_toml:readlines()) do
                local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
                if edition then
                    return { "--edition=" .. edition }
                end
            end
        end
        -- default edition when we don't find `Cargo.toml` or the `edition` in it.
        return { "--edition=2021" }
    end,
})
```
