# Rule Based Policy

Rule-based policy lets you declare data-only rules for deciding which already-detected variables should be masked or ignored.

Policy can be configured in `setup()` or `.camouflage.yaml`. It never executes project code and it cannot make unsupported files parseable. A `mask` rule can only affect values that a parser or custom pattern already found.

## Precedence

Policy decisions are deterministic:

1. `terminal_path_ignores` ignore matching root-relative paths first.
2. A matching `action = 'mask'` rule with `allow_force = true` can override a terminal path ignore.
3. For normal ordered rules, the first matching rule wins.
4. A later `allow_force = true` mask rule can override an earlier broad ignore rule.
5. If nothing matches, `default_action` is used. The default is `mask`.

When policy is disabled, variables are masked normally and policy reports `policy_disabled`.

## Configuration

```lua
require('camouflage').setup({
  policy = {
    enabled = true,
    default_action = 'mask', -- 'mask' | 'ignore'
    terminal_path_ignores = { '.git/**', 'node_modules/**' },
    rules = {
      {
        id = 'ignore-debug-flags',
        action = 'ignore',
        key = { '^DEBUG$', '^PORT$' },
        parser = { 'env', 'json', 'yaml' },
      },
      {
        id = 'force-client-secrets',
        action = 'mask',
        allow_force = true,
        key = { 'client[_%.%-]?secret', 'private[_%.%-]?key' },
      },
    },
  },
})
```

The same policy can live in `.camouflage.yaml`:

```yaml
version: 1
policy:
  enabled: true
  default_action: mask
  terminal_path_ignores:
    - .git/**
    - node_modules/**
  rules:
    - id: ignore-debug-flags
      action: ignore
      key: ['^DEBUG$', '^PORT$']
      parser: [env, json, yaml]
    - id: force-client-secrets
      action: mask
      allow_force: true
      key:
        - client[_%.%-]?secret
        - private[_%.%-]?key
```

## Rule Fields

| Field | Type | Description |
|---|---|---|
| `id` | `string` | Stable identifier shown in redacted metadata |
| `action` | `'mask' \| 'ignore'` | Decision when the rule matches |
| `allow_force` | `boolean` | Lets a mask rule override path ignores or broad ignore rules |
| `path` | `string|string[]` | Project-root-relative glob |
| `basename` | `string|string[]` | Basename glob |
| `parser` | `string|string[]` | Parser name such as `env`, `json`, `yaml`, `toml`, `hcl` |
| `key` | `string|string[]` | Lua pattern matched against parsed variable keys |
| `nested` | `boolean` | Match nested-key metadata |
| `commented` | `boolean` | Match commented-line metadata |
| `value_length` | `{ min?: number, max?: number }` | Match plaintext length without exposing the value |
| `value_shape` | `string|string[]` | Safe shape predicate, listed below |
| `value_prefix` | `string|string[]` | Literal prefix predicate |
| `value_suffix` | `string|string[]` | Literal suffix predicate |

Supported `value_shape` values:

| Shape | Matches |
|---|---|
| `empty` | Empty string |
| `non_empty` | Any non-empty string |
| `numeric` | Numeric-looking values |
| `boolean` | `true` or `false` |
| `quoted` | Single- or double-quoted values |
| `jwt_like` | Three base64url-ish JWT segments |
| `token_like` | Non-space token-like values with at least 8 characters |

Value predicates inspect the value only to make the decision. Warnings, status output, audit findings, and policy stats do not include plaintext values.

## Common Patterns

Ignore safe operational toggles:

```yaml
policy:
  rules:
    - id: ignore-non-secret-flags
      action: ignore
      key: ['^DEBUG$', '^LOG_LEVEL$', '^PORT$']
      value_shape: [boolean, numeric, non_empty]
```

Ignore fixture directories but force real-looking secrets back on:

```yaml
policy:
  terminal_path_ignores:
    - tests/fixtures/**
  rules:
    - id: force-private-keys
      action: mask
      allow_force: true
      key: ['private[_%.%-]?key']
```

Mask only specific keys by default:

```yaml
policy:
  default_action: ignore
  rules:
    - id: mask-sensitive-keys
      action: mask
      key:
        - password
        - secret
        - token
        - api[_%-]*key
```

## Status and Audit

`:CamouflageStatus` reports whether policy is enabled and how many variables were ignored in the current buffer.

[[Workspace Audit]] applies the same policy and includes redacted policy metadata in each finding.

## See Also

- [[Project Config]] — using policy in `.camouflage.yaml`
- [[Workspace Audit]] — policy-aware audit output
- [[Configuration]] — full configuration reference
