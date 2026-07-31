# Integrations

## dpezto/chezmoi-template.nvim

### statuslines

For statusline/bufferline components, `require("chezmoi-template.icons").get(path)` returns the target's `glyph, hl` (or nil for non-chezmoi paths). lualine example:

```lua
local function file_icon()
  local icon, hl = require("chezmoi-template.icons").get(vim.api.nvim_buf_get_name(0))
  if not icon then
    return ""
  end
  return icon
end
```

#### Lua API

For statuslines, custom pickers, or scripts:

```lua
-- every managed file as { source = <abs>, target = <abs> } pairs
local files = require("chezmoi-template").list()

-- open the chezmoi source for a deploy target (~ is expanded)
require("chezmoi-template").edit("~/.zshrc")
```

`edit(target)` is the programmatic form of `:Chezmoi edit <target>`.

### saghen/blink.cmp

![Data-key completion inside an action, with type icons and masked secrets](assets/completion.gif)

Requires blink.cmp ≥ 0.13 (per-item `kind_icon`/`kind_hl`). Register the source in your blink opts:

```lua
sources = {
  default = { "chezmoi", "lsp", "path", "buffer" },
  providers = {
    chezmoi = { name = "chezmoi", module = "chezmoi-template.blink" },
  },
}
```

The source only activates in gotmpl buffers. Inside `{{ … }}` it narrows by cursor position (treesitter-driven, with a line-regex fallback): data keys after a dot, plus functions and keywords at command position, and nothing inside string literals; elsewhere it offers block snippets (`if` → `{{- if … }}\n…\n{{- end }}` etc.), so it stays out of the way of the target language's own completion. Note: templates using secret-manager functions (`onepassword`, `vault`, …) may make `:Chezmoi preview`/diagnostics slow or fail without auth — those calls run whatever your template runs.

### laytan/cloak.nvim , philosofonusus/ecolog.nvim

What the plugin does by itself:

- Decrypted buffers never persist plaintext: `swapfile`, `undofile` and swap are disabled, and writes go straight through `chezmoi encrypt` (no plaintext temp file).
- Completion docs hide values of data keys matching `completion.mask` (default: `secret`, `token`, `passw`, `key`, `api`) — the key still completes, the value shows as `•••••`.

What you should know:

- `:Chezmoi preview` and diagnostics run `chezmoi execute-template` on your buffer — templates calling secret managers (`onepassword`, `vault`, `pass`, …) will render real secrets into the preview split, and may be slow or fail without auth. Don't screen-share the preview of a secrets template.
- [cloak.nvim](https://github.com/laytan/cloak.nvim) composes well for masking secrets in decrypted buffers — its `file_pattern`s match the buffer name, which keeps its encrypted suffix: add `"*.age"`/`"*.asc"` (or specific names like `"*.json.age"`) to your cloak patterns.
- [ecolog.nvim](https://github.com/philosofonusus/ecolog.nvim) env completion works inside templates by mirroring its providers onto the `gotmpl` filetype; its shelter mode then masks env values in completion/peek as usual:

```lua
-- ecolog opts.providers: reuse shell providers for gotmpl buffers
providers = vim.tbl_map(function(p)
  return vim.tbl_extend("force", p, { filetype = "gotmpl" })
end, shell_providers),
```
