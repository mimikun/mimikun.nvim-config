# Troubleshooting

Common issues and their solutions.

## Masking Not Working

### 1. Check if the plugin is enabled

```vim
:CamouflageStatus
```

This shows whether camouflage is enabled and how many values are masked in the current buffer.

### 2. Verify the file type is supported

```vim
:echo expand('%:e')
```

See [[Supported File Formats]] for the full list. If your format isn't supported, see [[Custom Patterns]].

### 3. Check if the file exceeds max_lines

```vim
:echo line('$')
```

By default, files with more than 5000 lines are skipped. Adjust with:

```lua
require('camouflage').setup({ max_lines = 10000 })
```

### 4. Ensure setup() was called

```lua
:lua print(require('camouflage').is_enabled())
```

If this returns `false` or errors, `setup()` may not have been called.

### 5. Check for empty values

Parsers skip empty values. Ensure your key-value pairs have actual values:

```env
# This will NOT be masked (empty value)
API_KEY=

# This WILL be masked
API_KEY=secret123
```

## Values Not Being Detected

### .env files

Ensure proper format:
- `KEY=value`
- `export KEY=value`
- `KEY="quoted value"`

### JSON/YAML/XML files

Check nesting depth. Default max is 10:

```lua
require('camouflage').setup({
  parsers = {
    json = { max_depth = 20 },
    yaml = { max_depth = 20 },
  },
})
```

### Terraform/HCL files

Variable references (`var.xxx`, `local.xxx`) are intentionally skipped — only literal values are masked.

## Performance Issues

### Large files are slow

Reduce `max_lines`:

```lua
require('camouflage').setup({ max_lines = 1000 })
```

### Frequent re-decoration on typing

Increase debounce:

```lua
require('camouflage').setup({ debounce_ms = 300 })
```

### Disable auto-enable

Toggle manually instead:

```lua
require('camouflage').setup({ auto_enable = false })
```

## Telescope Preview Not Masked

1. Ensure Telescope integration is enabled (default: `true`):

```lua
require('camouflage').setup({
  integrations = { telescope = true },
})
```

2. Verify telescope.nvim is installed and loaded.

## Snacks.nvim Picker Not Masked

The Snacks.nvim integration is always enabled when Snacks is detected. If preview buffers aren't masked:

1. Verify snacks.nvim is installed
2. Check debug logs — enable `debug = true` and check `:messages`

## Completion Showing Secrets

If nvim-cmp is showing secret values in completion:

```lua
require('camouflage').setup({
  integrations = {
    cmp = { disable_in_masked = true },
  },
})
```

## Buffer-local Settings Not Applying

1. Set buffer variables **before** entering the buffer, or call `:CamouflageRefresh` after
2. Use correct variable names — `vim.b.camouflage_enabled` (not `vim.b.camouflage.enabled`)

## Have I Been Pwned Not Working

### Check requirements

```lua
:lua print(require('camouflage').pwned_is_available())
```

Requirements:
- Neovim 0.10+ (`vim.system()` is needed)
- `curl` in PATH

SHA-1 hashing is bundled and runs in-process, so `sha1sum` or `openssl` is not required.

### Verify from the command line

```bash
curl https://api.pwnedpasswords.com/range/5BAA6
```

### Clear cache and retry

```vim
:CamouflagePwnedClearCache
:CamouflagePwnedCheckBuffer
```

## Project Config Not Loading

### Check status

```vim
:CamouflageProjectConfigStatus
```

This shows:
- Whether a `.camouflage.yaml` was found
- The file path
- Any parse/validation errors

### Common issues

- Missing `version: 1` field (required)
- Unknown keys (typos in option names)
- Wrong types (e.g., string where boolean expected)
- YAML syntax errors

### Watcher not detecting changes

```vim
:CamouflageProjectConfigWatchStatus
```

Check which backends are active. Try forcing a specific backend:

```lua
require('camouflage').setup({
  project_config = {
    watch_backend = 'both',  -- Use both fs and autocmd
  },
})
```

## Debug Mode

Enable verbose logging to diagnose issues:

```lua
require('camouflage').setup({ debug = true })
```

Then check output with:

```vim
:messages
```

Debug logs include:
- pcall failures (extmarks, buffer operations)
- TreeSitter parser availability
- Integration detection results
- Parser selection and file matching

### Log Levels

| Level | When Shown |
|-------|-----------|
| TRACE, DEBUG, INFO | Only when `debug = true` |
| WARN, ERROR | Always shown |

## Inspecting Internal State

### View parsed variables

```lua
:lua print(vim.inspect(require('camouflage.state').get_variables(0)))
```

### View buffer state

```lua
:lua print(vim.inspect(require('camouflage.state').get_buffer(0)))
```

### View effective config

```lua
:lua print(vim.inspect(require('camouflage.config').get()))
```

## Getting Help

If none of the above resolves your issue:

1. Enable debug mode and collect the log output
2. Note your Neovim version (`:version`)
3. Note the plugin version (`require('camouflage').version`)
4. Open an issue at [GitHub](https://github.com/zeybek/camouflage.nvim/issues)

The project provides issue templates for bug reports and feature requests.

## See Also

- [[Configuration]] — Full configuration reference
- [[Architecture]] — Internal architecture details
