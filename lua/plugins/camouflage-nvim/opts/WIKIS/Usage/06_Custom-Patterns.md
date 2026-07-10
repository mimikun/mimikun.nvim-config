# Custom Patterns

For file types not supported by the built-in parsers, you can define custom detection patterns using Lua patterns.

> **Note:** `config.patterns` and runtime parsers take priority over custom patterns. If a file already matches a configured parser (for example `.json` or `.env`) or a parser registered with `register_parser`, the custom pattern will not be used for that file.
> Custom patterns are opt-in for unsupported filenames; for example, `*.myconfig` files are ignored until a matching `custom_patterns` entry is configured.

## Basic Usage

```lua
require('camouflage').setup({
  custom_patterns = {
    {
      file_pattern = { '*.myconfig' },   -- Glob pattern(s) for file matching
      pattern = '^%s*@([%w_]+)%s*=%s*(.+)', -- Lua pattern with capture groups
      key_capture = 1,                    -- Capture group for key (optional)
      value_capture = 2,                  -- Capture group for value (required)
    },
  },
})
```

## Options

| Option | Type | Required | Description |
|--------|------|----------|-------------|
| `file_pattern` | `string` or `string[]` | Yes | Glob pattern(s) for matching files |
| `pattern` | `string` | Yes | Lua pattern with capture groups |
| `key_capture` | `number` | No | Capture group number for the key. If omitted, keys are auto-generated as `custom_1`, `custom_2`, etc. |
| `value_capture` | `number` | Yes | Capture group number for the value to mask |

## Examples

### Key = Value format

```lua
-- Matches: @variable = value
{
  file_pattern = '*.myconfig',
  pattern = '^%s*@([%w_]+)%s*=%s*(.+)',
  key_capture = 1,
  value_capture = 2,
}
```

### Value-only format

```lua
-- Matches: SECRET: value
-- Keys are auto-generated (custom_1, custom_2, ...)
{
  file_pattern = '*.secret',
  pattern = 'SECRET:%s*(.+)',
  value_capture = 1,
}
```

### Shell-like variables

```lua
-- Matches: $VAR=value
{
  file_pattern = '*.shellvars',
  pattern = '%$([%w_]+)=([^%s]+)',
  key_capture = 1,
  value_capture = 2,
}
```

### Double-colon separator

```lua
-- Matches: key :: value
{
  file_pattern = '*.colonconfig',
  pattern = '([%w_]+)%s*::%s*(.+)',
  key_capture = 1,
  value_capture = 2,
}
```

### Arrow syntax

```lua
-- Matches: key -> value
{
  file_pattern = '*.arrowconfig',
  pattern = '([%w_]+)%s*%->%s*(.+)',
  key_capture = 1,
  value_capture = 2,
}
```

### Bracketed values

```lua
-- Matches: key = [value]
{
  file_pattern = '*.bracketed',
  pattern = '([%w_]+)%s*=%s*%[(.-)%]',
  key_capture = 1,
  value_capture = 2,
}
```

### Multiple file patterns

```lua
{
  file_pattern = { '*.myconfig', '*.myrc', '.myapp' },
  pattern = '([%w_]+)%s*=%s*(.+)',
  key_capture = 1,
  value_capture = 2,
}
```

## Lua Pattern Reference

Custom patterns use [Lua patterns](https://www.lua.org/pil/20.2.html), not regular expressions. Key differences:

| Lua Pattern | Meaning |
|-------------|---------|
| `%w` | Alphanumeric character |
| `%d` | Digit |
| `%s` | Whitespace |
| `%a` | Letter |
| `%p` | Punctuation |
| `.` | Any character |
| `+` | One or more |
| `*` | Zero or more |
| `-` | Zero or more (non-greedy) |
| `(...)` | Capture group |
| `[%w_]` | Character class (alphanumeric + underscore) |
| `%` | Escape special characters |

## How It Works

1. When a buffer is opened, camouflage checks `config.patterns`
2. If no configured parser matches, runtime parser registrations with `filetypes` or `file_patterns` are checked by priority
3. If no parser matches, `custom_patterns` are checked
4. Each matching line is evaluated against the Lua `pattern`
5. Captured groups are extracted based on `key_capture` and `value_capture`
6. Matched values are masked like any other detected secret

## See Also

- [[Supported File Formats]] — Built-in parsers
- [[Custom Parsers]] — Runtime parser registration for reusable parser logic
- [[Configuration]] — Full config reference
