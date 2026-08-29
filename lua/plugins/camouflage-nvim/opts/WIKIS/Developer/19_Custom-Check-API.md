# Custom Check API

Custom checks let trusted Lua code inspect parsed variables during masking and render redacted badges through the shared checks pipeline.

Use this for local policy hints, organization-specific validators, or carefully controlled async checks. Check functions receive plaintext values in `ctx.var.value`, so only register code you trust.

## Quick Start

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
        data = {
          reason = 'placeholder',
          key = ctx.var.key,
          value_length = #ctx.var.value,
        },
      }
    end
  end,
})
```

## Public API

| Function | Description |
|---|---|
| `require('camouflage').register_check(spec)` | Register a trusted Lua check |
| `require('camouflage').unregister_check(name)` | Remove a check and clear its rendered results |
| `require('camouflage').list_checks()` | List registered checks sorted by priority descending, then name |
| `require('camouflage').get_check(name)` | Fetch one registered check |

## Spec Fields

| Field | Type | Required | Description |
|---|---|---:|---|
| `name` | `string` | yes | Stable check name. Must start with a letter and contain only letters, digits, `_`, or `-` |
| `run` | `function` | yes | Sync form `run(ctx)` or async form `run(ctx, done)` |
| `async` | `boolean` | no | Defaults to `false` |
| `priority` | `integer` | no | Defaults to `50`; higher runs first |
| `default_enabled` | `boolean` | no | Defaults to `true` |

Names are limited to 64 characters and duplicate names are rejected.

## Context

Each check receives a context table:

| Field | Description |
|---|---|
| `bufnr` | Buffer number |
| `filename` | Filename used for parser selection |
| `parser_name` | Parser that produced the variable |
| `var` | Parsed variable. `ctx.var.value` is plaintext |
| `config` | Effective data table from `checks.<name>` |
| `run_id` | Decoration run id |
| `check_name` | Registered check name |

Checks run after [[Rule Based Policy]] and `variable_detected` hooks, so they only inspect variables that will actually be masked.

## Result Fields

A check can return `nil` for no badge, or a table:

| Field | Type | Description |
|---|---|---|
| `severity` | `'info' \| 'warning' \| 'error'` | Required |
| `text` | `string` | Badge text; keep it redacted |
| `hl_group` | `string` | Virtual text highlight group |
| `sign_text` | `string` | Optional sign column text |
| `sign_hl` | `string` | Optional sign highlight group |
| `line_hl` | `string` | Optional whole-line highlight group |
| `priority` | `integer` | Optional result metadata |
| `data` | `table` | Optional data-only metadata |

Unknown result fields are ignored. `data` may contain only primitive values and tables.

camouflage drops a result when `text` or `data` directly contains the exact plaintext value. This prevents accidental leaks in the rendered badge or metadata, but check authors should still intentionally return only redacted output.

## Async Checks

Async checks must opt in with `async = true` and call `done(result)`:

```lua
require('camouflage').register_check({
  name = 'remote_policy',
  async = true,
  run = function(ctx, done)
    vim.defer_fn(function()
      done({
        severity = 'info',
        text = '[checked]',
      })
    end, 10)
  end,
})
```

Old async completions are ignored when:

- the buffer changed
- the buffer was deleted
- the check was unregistered
- a newer decoration run superseded the old run
- the variable no longer matches the original line/range/key/value identity

## Configuration

Registered checks read data options from `checks.<name>`. `enabled = false` disables that check.

```lua
require('camouflage').setup({
  checks = {
    local_policy = {
      enabled = false,
      label = 'team',
      severity = 'warning',
    },
  },
})
```

Inside the check:

```lua
run = function(ctx)
  if ctx.config.enabled == false then
    return
  end
  vim.notify(ctx.config.label)
end
```

Project config can provide data under `checks.<name>`, but it cannot register executable check code.

## Badge Composition

Custom checks render through the same badge renderer as built-in checks. Built-ins render first in this order:

1. `pwned`
2. `weak_secret`
3. `expiry`

Unlisted checks render after those, alphabetically by check name. The highest-severity result on a line owns the sign column and whole-line highlight.

## Lifecycle

```lua
local camouflage = require('camouflage')

camouflage.register_check({
  name = 'org_policy',
  run = function(ctx)
    -- ...
  end,
})

for _, check in ipairs(camouflage.list_checks()) do
  print(check.name, check.priority)
end

camouflage.unregister_check('org_policy')
```

`unregister_check()` clears rendered results for that check from loaded buffers.

## See Also

- [[Weak Secret Check]] — built-in offline check
- [[JWT Expiry Hints]] — built-in local JWT check
- [[API]] — complete public Lua API
