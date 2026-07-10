# Events and Hooks

camouflage.nvim provides an event system for extending and customizing plugin behavior. There are three ways to hook into events.

## Registration Methods

### 1. Config-based Hooks

Set callback functions in `setup()`:

```lua
require('camouflage').setup({
  hooks = {
    on_before_decorate = function(bufnr, filename)
      -- Called before masking is applied
    end,
    on_variable_detected = function(bufnr, var)
      -- Called for each detected variable
      -- Return false to skip masking
    end,
    on_after_decorate = function(bufnr, variables)
      -- Called after all decorations are applied
    end,
  },
})
```

### 2. Dynamic Listeners

Register and unregister listeners at runtime:

```lua
local camouflage = require('camouflage')

-- Register
local id = camouflage.on('variable_detected', function(bufnr, var)
  return var.key:match('PASSWORD')
end)

-- Register one-time listener
camouflage.once('after_decorate', function(bufnr, variables)
  print('Masked ' .. #variables .. ' variables')
end)

-- Unregister
camouflage.off('variable_detected', id)
```

### 3. Vim Autocmd Events

camouflage.nvim fires `User` autocmds that you can listen to with standard Vim autocommands:

```lua
vim.api.nvim_create_autocmd('User', {
  pattern = 'CamouflageBeforeDecorate',
  callback = function(args)
    local bufnr = args.data.bufnr
    local filename = args.data.filename
    -- ...
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'CamouflageAfterDecorate',
  callback = function(args)
    local bufnr = args.data.bufnr
    local filename = args.data.filename
    local variables = args.data.variables
    -- variables are redacted: value is omitted, value_length is included
    -- ...
  end,
})
```

In-process Lua hooks (`setup({ hooks = ... })`, `on()`, `once()`) receive the normal `ParsedVariable` table, including plaintext `var.value`. Public `User` autocmd payloads are redacted and omit plaintext values.

## Available Events

### Decoration Lifecycle

| Event | Arguments | Filter? | Description |
|-------|-----------|---------|-------------|
| `before_decorate` | `(bufnr, filename)` | Yes | Fired before masking is applied. Return `false` to cancel decoration |
| `variable_detected` | `(bufnr, var)` | Yes | Fired for each detected variable. Return `false` to skip masking this variable |
| `after_decorate` | `(bufnr, variables[])` | No | Fired after all decorations are applied |

### Reveal Events

| Event | Arguments | Filter? | Description |
|-------|-----------|---------|-------------|
| `before_reveal` | `(bufnr, line)` | Yes | Before a line is revealed. Return `false` to cancel |
| `after_reveal` | `(bufnr, line)` | No | After a line is revealed |

### Yank Events

| Event | Arguments | Filter? | Description |
|-------|-----------|---------|-------------|
| `before_yank` | `(bufnr, var)` | Yes | Before a value is yanked. Return `false` to cancel |
| `after_yank` | `(bufnr, var, register)` | No | After a value is yanked |

### Follow Cursor Events

| Event | Arguments | Filter? | Description |
|-------|-----------|---------|-------------|
| `before_follow_start` | (none) | Yes | Before follow cursor mode starts. Return `false` to cancel |
| `after_follow_start` | (none) | No | After follow cursor mode starts |
| `before_follow_stop` | (none) | Yes | Before follow cursor mode stops. Return `false` to cancel |
| `after_follow_stop` | (none) | No | After follow cursor mode stops |

### Vim User Autocmd Events

| Autocmd Pattern | Data | Description |
|----------------|------|-------------|
| `CamouflageBeforeDecorate` | `{bufnr, filename}` | Before decoration |
| `CamouflageAfterDecorate` | `{bufnr, filename, variables}` | After decoration; `variables` omits plaintext and includes `value_length` |
| `CamouflageConfigChanged` | — | Config changed (triggers refresh) |

There is intentionally no public `User` autocmd for `variable_detected`; it is too frequent and would expose plaintext values through autocmd data.

## Use Cases

### Filter Variables by Key Name

Only mask variables containing specific keywords:

```lua
require('camouflage').on('variable_detected', function(bufnr, var)
  local sensitive_patterns = { 'SECRET', 'PASSWORD', 'API_KEY', 'TOKEN', 'PRIVATE' }
  for _, pattern in ipairs(sensitive_patterns) do
    if var.key:upper():match(pattern) then
      return true
    end
  end
  return false  -- Skip masking
end)
```

### Skip Masking for Specific Files

```lua
require('camouflage').on('before_decorate', function(bufnr, filename)
  -- Don't mask example/template files
  if filename:match('example') or filename:match('template') then
    return false
  end
end)
```

### Log All Yank Operations

```lua
require('camouflage').on('after_yank', function(bufnr, var, register)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  vim.notify(string.format(
    'Yanked "%s" from %s to register %s',
    var.key, vim.fn.fnamemodify(filename, ':t'), register
  ))
end)
```

### Count Masked Variables

```lua
require('camouflage').on('after_decorate', function(bufnr, variables)
  if #variables > 0 then
    vim.notify(string.format('Masked %d sensitive values', #variables), vim.log.levels.INFO)
  end
end)
```

### Conditional Follow Cursor

```lua
require('camouflage').on('before_follow_start', function()
  -- Only allow follow cursor in specific file types
  local ft = vim.bo.filetype
  if ft ~= 'yaml' and ft ~= 'json' then
    vim.notify('Follow cursor only available for YAML/JSON', vim.log.levels.WARN)
    return false
  end
end)
```

## See Also

- [[API]] — Lua API reference (`on`, `once`, `off`)
- [[Architecture]] — How events flow through the system
