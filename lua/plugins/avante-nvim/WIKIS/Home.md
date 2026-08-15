Welcome to the avante.nvim wiki!

## package managers.

we will only fully support `lazy.nvim`. Every other package manager are best-efforts. If you want to use anything else, please submit PR on how to make those better, thanks.

## secrets.

A more secure way to set API key is through secret manager. You can do that by prefixing `api_key_name` like so:

```lua
{
  "yetone/avante.nvim",
  opts = {
    provider = "claude",
    claude = {
      api_key_name = "cmd:bw get notes anthropic-api-key", -- the shell command must prefixed with `^cmd:(.*)`
      -- api_key_name = {"bw","get","notes","anthropic-api-key"}, -- if it is a table of string, then default to command.
    }
  }
}
```

## slash commands

In the input box, we have support a few slash commands. Try `/help` for more information.

## error when sending request to LLM?

Make sure that you have credits in your accounts 😃 

## copilot?

set `provider="copilot"`.

## pass in additional generation parameters.

You can just add any accepted body fields to `curl` for given LLM provider:

```lua
opts = {
  gemini = { -- see https://ai.google.dev/api/generate-content#request-body_1
    generationConfig = {
      stopSequences = {"test"},
    }
  }
}
```


## keymaps and API, i guess.

Since [#346](https://github.com/yetone/avante.nvim/pull/346), we will expose certain functions that are considered "public" API through [`avante.api`](https://github.com/yetone/avante.nvim/blob/main/lua/avante/api.lua). 

Additionally, we will safely add certain keymaps if users yet to set those (only applies for `lazy.nvim` users) for core functionality, including `AvanteAsk`, `AvanteEdit`, and `AvanteRefresh`

> [!IMPORTANT]
>
> This means <kbd>Leader</kbd><kbd>a</kbd><kbd>a</kbd> won't be set to `AvanteAsk` if you already set this mapping.

The following `<Plug>` will also be available for compatibility sake:

- `<Plug>(AvanteAsk)`
- `<Plug>(AvanteEdit)`
- `<Plug>(AvanteRefresh)`

Example settings for keys settings in `lazy.nvim`:

```lua
    keys = function(_, keys)
      ---@type avante.Config
      local opts =
        require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)

      local mappings = {
        {
          opts.mappings.ask,
          function() require("avante.api").ask() end,
          desc = "avante: ask",
          mode = { "n", "v" },
        },
        {
          opts.mappings.refresh,
          function() require("avante.api").refresh() end,
          desc = "avante: refresh",
          mode = "v",
        },
        {
          opts.mappings.edit,
          function() require("avante.api").edit() end,
          desc = "avante: edit",
          mode = { "n", "v" },
        },
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
    end,
```

> [!IMPORTANT]
>
> If you have different keybinding, then update `opts.mappings` so that hint works accordingly.
>
> If you are using `lazy.nvim` then use the snippet above.

```lua
{
  opts = {
    mappings = {
      ask = "<leader>ua", -- ask
      edit = "<leader>ue", -- edit
      refresh = "<leader>ur", -- refresh
    },
  }
}
```

## extends apis and keybindings.

Read https://github.com/yetone/avante.nvim/blob/main/lua/avante/api.lua

## custom `.avanterules`

All fields for all `.avanterules` are available [here](https://github.com/yetone/avante.nvim/blob/5fde5e03ea2365bfdf5e136fe32b002a2c2f872b/crates/avante-templates/src/lib.rs#L19)

## clipboard.

If you wish to load `img-clip.nvim` via keys, you can use the following:

```lua
    keys = {
      {
        "<leader>ip",
        function()
          return vim.bo.filetype == "AvanteInput" and require("avante.clipboard").paste_image()
            or require("img-clip").paste_image()
        end,
        desc = "clip: paste image",
      },
    }
```

## curl failed to writing to disk error

See https://github.com/yetone/avante.nvim/issues/315#issuecomment-2315957174

## convert generated conflict to quickfix items

```lua
_G.convert_to_qf = function()
  require('avante.diff').conflicts_to_qf_items(function(items)
    if #items > 0 then
      vim.fn.setqflist(items, "r")
      vim.cmd('copen')
    end
  end)
end
```

Then you can call this function in mappings or anything you want to do with it.

## dynamic window position

See https://github.com/yetone/avante.nvim/pull/527

## wsl

Try set `XDG_RUNTIME_DIR="/tmp/"`