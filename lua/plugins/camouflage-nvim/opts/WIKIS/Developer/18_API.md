# API Reference

camouflage.nvim exposes a Lua API through `require('camouflage')`.

## Core API

### `setup(opts?)`

Initialize the plugin with optional configuration.

```lua
require('camouflage').setup({
  style = 'stars',
  auto_enable = true,
})
```

### `enable()`

Enable camouflage globally and apply masking to all visible buffers.

```lua
require('camouflage').enable()
```

### `disable()`

Disable camouflage globally and clear all decorations.

```lua
require('camouflage').disable()
```

### `toggle()`

Toggle camouflage on/off.

```lua
require('camouflage').toggle()
```

### `is_enabled()`

Check if camouflage is currently enabled.

```lua
local enabled = require('camouflage').is_enabled()
-- Returns: boolean
```

### `refresh()`

Force refresh decorations on all visible buffers.

```lua
require('camouflage').refresh()
```

### `version`

The current plugin version string.

```lua
print(require('camouflage').version)
-- "0.11.0"
```

## Reveal API

### `reveal.reveal_line()`

Reveal masked values on the current line. Values auto-hide when the cursor moves to another line.

```lua
require('camouflage').reveal.reveal_line()
```

### `reveal.hide()`

Force hide any currently revealed values.

```lua
require('camouflage').reveal.hide()
```

### `reveal.toggle()`

Toggle reveal on the current line.

```lua
require('camouflage').reveal.toggle()
```

### `reveal.is_revealed()`

Check if any line is currently revealed.

```lua
local revealed = require('camouflage').reveal.is_revealed()
-- Returns: boolean
```

## Follow Cursor API

### `start_follow_cursor()`

Enable follow cursor mode. The current line's masked values are automatically revealed as you navigate.

```lua
require('camouflage').start_follow_cursor()
```

### `stop_follow_cursor()`

Disable follow cursor mode.

```lua
require('camouflage').stop_follow_cursor()
```

### `toggle_follow_cursor(opts?)`

Toggle follow cursor mode. When `opts.force_disable = true`, forces the mode off.

```lua
require('camouflage').toggle_follow_cursor()
require('camouflage').toggle_follow_cursor({ force_disable = true })
```

### `is_follow_cursor_enabled()`

Check if follow cursor mode is active.

```lua
local active = require('camouflage').is_follow_cursor_enabled()
-- Returns: boolean
```

## Yank API

### `yank.yank()`

Copy the unmasked value at the cursor position to the clipboard.

```lua
require('camouflage').yank.yank()
```

### `yank.yank_with_picker()`

Show a picker (`vim.ui.select`) to choose which value to copy.

```lua
require('camouflage').yank.yank_with_picker()
```

## Have I Been Pwned API

> Requires Neovim 0.10+ and `curl`. SHA-1 hashing is done in-process with the bundled pure-Lua implementation.

### `pwned_check()`

Check if the value under the cursor has been exposed in data breaches.

```lua
require('camouflage').pwned_check()
```

### `pwned_check_line()`

Check all masked values on the current line.

```lua
require('camouflage').pwned_check_line()
```

### `pwned_check_buffer()`

Check all masked values in the entire buffer.

```lua
require('camouflage').pwned_check_buffer()
```

### `pwned_clear()`

Clear all pwned indicators (signs, virtual text, highlights) from the buffer.

```lua
require('camouflage').pwned_clear()
```

### `pwned_is_available()`

Check if the HIBP feature is available (Neovim 0.10+, required tools installed).

```lua
local available = require('camouflage').pwned_is_available()
-- Returns: boolean
```

## Parser API

### `register_parser(spec)`

Register a custom parser. Runtime registrations that include `file_patterns` refresh automatic masking immediately.

```lua
require('camouflage').register_parser({
  name = 'my_format',
  filetypes = { 'myft' },
  file_patterns = { '*.myft' },
  priority = 60,
  parser = {
    parse = function(content, bufnr)
      return {
        {
          key = 'token',
          value = 'abc123',
          start_index = 12,
          end_index = 18,
          line_number = 0,
          is_nested = false,
          is_commented = false,
        },
      }
    end,
  },
})
```

### `register_pattern(spec)`

Register a simple Lua-pattern parser.

```lua
require('camouflage').register_pattern({
  name = 'kdl_tokens',
  file_patterns = { '*.kdl' },
  pattern = '(%w+)%s+"([^"]+)"',
  key_capture = 1,
  value_capture = 2,
})
```

### `unregister_parser(name)`

Remove a parser by name. Built-in parsers can also be unregistered.

```lua
require('camouflage').unregister_parser('json')
```

### `list_parsers()` / `get_parser(name)`

Inspect the parser registry.

```lua
local parsers = require('camouflage').list_parsers()
local json = require('camouflage').get_parser('json')
```

See [[Custom Parsers]] for parser spec details.

## Custom Check API

### `register_check(spec)`

Register a trusted Lua check that runs for parsed variables that survive policy and hooks.

```lua
require('camouflage').register_check({
  name = 'local_policy',
  priority = 60,
  run = function(ctx)
    if ctx.var.key:match('TOKEN') and ctx.var.value == 'changeme' then
      return {
        severity = 'warning',
        text = '[policy]',
        hl_group = 'DiagnosticWarn',
        data = { reason = 'placeholder', key = ctx.var.key },
      }
    end
  end,
})
```

### `unregister_check(name)`

Remove a registered check and clear its rendered results from loaded buffers.

```lua
require('camouflage').unregister_check('local_policy')
```

### `list_checks()` / `get_check(name)`

Inspect registered checks.

```lua
local checks = require('camouflage').list_checks()
local check = require('camouflage').get_check('local_policy')
```

See [[Custom Check API]] for sync/async checks, result validation, and privacy rules.

## Workspace Audit API

The audit module is available for advanced use:

```lua
local audit = require('camouflage.audit')

local result = audit.run({
  path = vim.fn.getcwd(),
})

audit.set_list(result, {
  destination = 'quickfix',
  open = true,
})
```

`result.findings` contains redacted metadata only. It does not include plaintext values.

See [[Workspace Audit]] for result shape and async usage.

## Event API

### `on(event, callback) -> id`

Register a listener for an event. Returns a listener ID for later removal.

```lua
local id = require('camouflage').on('variable_detected', function(bufnr, var)
  -- Return false to skip masking this variable
  if var.key == 'PUBLIC_KEY' then
    return false
  end
  return true
end)
```

### `once(event, callback) -> id`

Register a one-time listener that is automatically removed after firing once.

```lua
require('camouflage').once('after_decorate', function(bufnr, variables)
  print('First decoration complete: ' .. #variables .. ' variables')
end)
```

### `off(event, id) -> boolean`

Remove a previously registered listener by its ID.

```lua
local id = require('camouflage').on('after_decorate', my_callback)
-- Later...
require('camouflage').off('after_decorate', id)
```

See [[Events and Hooks]] for the full list of available events.

## Project Config API

### `project_config_status()`

Get the current project config load status. Shows the loaded file path, parsed settings, and any errors.

```lua
require('camouflage').project_config_status()
```

### `project_config_refresh()`

Force reload the project config from `.camouflage.yaml`.

```lua
require('camouflage').project_config_refresh()
```

### `project_config_watch_status()`

Get the status of the config file watcher (which backends are active, watched roots, etc.).

```lua
require('camouflage').project_config_watch_status()
```

### `init_project_config(opts?)`

Create a `.camouflage.yaml` template in the project root.

```lua
require('camouflage').init_project_config()
require('camouflage').init_project_config({ force = true })  -- Overwrite existing
```

## State Inspection

For debugging, you can inspect the internal state directly:

### View parsed variables for current buffer

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

## ParsedVariable Type

Variables detected by parsers have this structure:

```lua
---@class ParsedVariable
---@field key string           -- Variable name/path (e.g., "database.password")
---@field value string         -- Actual value to mask
---@field start_index number   -- Byte offset where value starts
---@field end_index number     -- Byte offset where value ends
---@field line_number number   -- 0-indexed line number
---@field is_nested boolean    -- Whether key is a nested path
---@field is_commented boolean -- Whether from a commented line
---@field is_multiline boolean|nil -- Whether value spans multiple lines
```

## See Also

- [[Events and Hooks]] — Full event reference
- [[Custom Parsers]] — Parser registration details
- [[Custom Check API]] — Check registration details
- [[Workspace Audit]] — Audit module usage
- [[Configuration]] — Configuration options
- [[Architecture]] — Internal code flow
