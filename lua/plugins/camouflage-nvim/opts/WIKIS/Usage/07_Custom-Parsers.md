# Custom Parsers

For file formats not covered by the built-in parsers (env, json, yaml, toml, properties, netrc, xml, http, hcl, dockerfile), you can register your own parser at runtime. Three levels of integration are supported, from a one-line regex shortcut to a full TreeSitter-backed parser.

If you only need a quick regex over an unsupported file type, see [[Custom Patterns]] instead — it's a thin config-only path. **Custom Parsers** is the programmatic API for plugin authors and power users.

## Why a Custom Parser?

| Need | Use |
|---|---|
| Mask values in a one-off file with a simple regex | [[Custom Patterns]] |
| Register a reusable parser tied to filetypes / glob patterns | `register_pattern` (below) |
| Implement a stateful parser with full Lua logic | `register_parser` (below) |
| Leverage TreeSitter for structured parsing | `register_parser` with `treesitter` field |

## Quick Start — Pattern Parser

For simple `key = value` style formats, `register_pattern` wraps a Lua pattern in a parser:

```lua
require('camouflage').register_pattern({
  name = 'kdl_tokens',
  file_patterns = { '*.kdl' },
  pattern = '(%w+)%s+"([^"]+)"',
  key_capture = 1,
  value_capture = 2,
})
```

The plugin will now mask quoted string values in `.kdl` files. The same shape as `custom_patterns` in setup, but registered through the API and addressable by name.

## Full Parser

For anything more complex, register a parser table with a `parse` function:

```lua
require('camouflage').register_parser({
  name = 'my_format',
  filetypes = { 'myft' },          -- match by vim filetype
  file_patterns = { '*.myft' },    -- and/or by basename glob
  priority = 60,                   -- default 50; higher wins on conflict
  parser = {
    parse = function(content, bufnr)
      -- Return an array of ParsedVariable tables.
      return {
        {
          key = 'token',
          value = 'abc123',
          start_index = 12,        -- byte offset in `content` where the value starts
          end_index = 18,          -- byte offset where it ends
          line_number = 0,         -- 0-indexed
          is_nested = false,
          is_commented = false,
        },
      }
    end,
  },
})
```

### ParsedVariable Shape

| Field | Type | Description |
|---|---|---|
| `key` | `string` | Variable name (used by yank picker, reveal, etc.) |
| `value` | `string` | The actual unmasked value |
| `start_index` | `integer` | Byte offset of value start in the full buffer content |
| `end_index` | `integer` | Byte offset of value end (exclusive) |
| `line_number` | `integer` | 0-indexed line |
| `is_nested` | `boolean` | Whether this key is nested (e.g. `database.password`) |
| `is_commented` | `boolean` | Whether the line is a comment |
| `is_multiline` | `boolean?` | Optional: value spans multiple lines |

### Parser Spec Fields

| Field | Type | Required | Description |
|---|---|---|---|
| `name` | `string` | yes | Unique identifier (used by `:CamouflageParsers`, unregister) |
| `parser` | `table` | yes | Table with `parse(content, bufnr)` function |
| `filetypes` | `string[]` | no | Vim filetypes to match (e.g. `{'json', 'jsonc'}`) |
| `file_patterns` | `string[]` | no | Basename globs (e.g. `{'*.kdl', 'Dockerfile*'}`) |
| `priority` | `integer` | no | Higher priority wins when multiple parsers match (default `50`) |
| `treesitter` | `table` | no | `{ lang, query, query_file }` — see below |

## TreeSitter-Backed Parser

For formats with a TreeSitter grammar, you can register an inline query without dropping files in `queries/`:

```lua
require('camouflage').register_parser({
  name = 'kdl_ts',
  filetypes = { 'kdl' },
  file_patterns = { '*.kdl' },
  parser = {
    parse = function(content, bufnr)
      return require('camouflage.treesitter').parse(bufnr, 'kdl', content) or {}
    end,
  },
  treesitter = {
    lang = 'kdl',
    query = [[
      (node (identifier) @key
            (string (string_fragment) @value))
    ]],
  },
})
```

The `treesitter.query` is stored in the in-memory query registry and overrides any `queries/<lang>/camouflage.scm` file. See [[TreeSitter]] for query syntax details.

## Public API Reference

| Function | Purpose |
|---|---|
| `require('camouflage').register_parser(spec)` | Register a full parser (see fields above) |
| `require('camouflage').register_pattern(spec)` | Shorthand for a Lua-pattern based parser |
| `require('camouflage').unregister_parser(name)` | Remove a parser; works on builtins too |
| `require('camouflage').list_parsers()` | List all currently registered parsers |
| `require('camouflage').get_parser(name)` | Look up a parser by name |
| `:CamouflageParsers` | Inspect the live registry from a command line |

## Resolution Order

When opening a file, the plugin picks a parser in this order:

1. `config.patterns` (the built-in defaults the plugin ships with — `.env*` → env, `*.json` → json, etc.)
2. Parsers registered with metadata (`filetypes` / `file_patterns`), sorted by priority desc; ties broken by user-registered > builtin
3. `config.custom_patterns` (regex parsers from setup)

If your registered parser doesn't fire, check `:CamouflageParsers` to see what's registered and confirm your `file_patterns` actually match the buffer's basename.

## Overriding a Built-in Parser

You can replace a built-in parser entirely:

```lua
require('camouflage').unregister_parser('json')
require('camouflage').register_parser({
  name = 'json',
  filetypes = { 'json' },
  file_patterns = { '*.json' },
  parser = { parse = my_custom_json_parser },
})
```

## See Also

- [[Custom Patterns]] — simpler config-only regex path
- [[Events and Hooks]] — `variable_detected` hook to filter or augment parsed values
- [[TreeSitter]] — TreeSitter query syntax and file-based queries
- [[API]] — full Lua API reference
