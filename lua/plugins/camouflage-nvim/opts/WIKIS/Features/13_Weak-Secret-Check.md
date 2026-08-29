# Weak Secret Check

The weak-secret check is an offline quality hint for values that camouflage already parsed and masked. It flags high-confidence weak values without sending anything over the network.

It is intentionally conservative. For example, `PASSWORD=password` is flagged, while benign non-secret values such as `PORT=5432` and `DEBUG=true` are ignored.

## What It Flags

| Reason | Example class |
|---|---|
| `default` | Common defaults such as `password`, `secret`, `changeme`, `admin` |
| `placeholder` | Placeholder strings such as `your_secret_here`, `example_token`, `todo` |
| `repeated` | Repeated-character values |
| `sequence` | Simple sequences such as `123456`, `qwerty`, `abcdef` |
| `short` | Values below `min_sensitive_length` for sensitive keys |
| `entropy` | Token-like values with low Shannon entropy |

The check uses key context from `sensitive_key_patterns`, so the same value can be ignored under a non-sensitive key and flagged under `PASSWORD`, `API_KEY`, `TOKEN`, or similar keys.

## Configuration

```lua
require('camouflage').setup({
  checks = {
    weak_secret = {
      enabled = true,
      min_length = 8,
      min_sensitive_length = 12,
      entropy_threshold = 3.0,
      sensitive_key_patterns = {
        'password',
        'passwd',
        'passphrase',
        'secret',
        'token',
        'api[_%-]*key',
        'access[_%-]*key',
        'private[_%-]*key',
        'client[_%-]*secret',
        'auth[_%-]*token',
        'credential',
      },
      ignored_key_patterns = {},
      ignored_value_patterns = {},
      common_values = {
        'password',
        'password1',
        'password123',
        'secret',
        'secret123',
        'changeme',
        'changeit',
        'admin',
        'default',
        'test',
        'testing',
        'demo',
        'dummy',
        'qwerty',
        'letmein',
        'welcome',
        'hunter2',
      },
      show_sign = false,
      sign_text = '!',
      sign_hl = 'DiagnosticWarn',
      show_virtual_text = true,
      virtual_text_format = '[weak: %s]',
      virtual_text_hl = 'DiagnosticWarn',
      line_hl = nil,
    },
  },
})
```

## Options

| Option | Default | Description |
|---|---:|---|
| `enabled` | `true` | Enable the check |
| `min_length` | `8` | Minimum length used for token-like entropy checks |
| `min_sensitive_length` | `12` | Minimum length for sensitive keys |
| `entropy_threshold` | `3.0` | Shannon entropy threshold for token-like values |
| `sensitive_key_patterns` | built-in list | Lua patterns identifying sensitive keys |
| `ignored_key_patterns` | `{}` | Lua patterns for keys skipped by the check |
| `ignored_value_patterns` | `{}` | Lua patterns for values skipped by the check |
| `common_values` | built-in list | Values treated as common/default weak secrets |
| `show_sign` | `false` | Show a sign column indicator |
| `sign_text` | `'!'` | Sign text |
| `sign_hl` | `'DiagnosticWarn'` | Sign highlight |
| `show_virtual_text` | `true` | Show virtual text badge |
| `virtual_text_format` | `'[weak: %s]'` | Badge text format, where `%s` is the reason |
| `virtual_text_hl` | `'DiagnosticWarn'` | Badge highlight |
| `line_hl` | `nil` | Optional whole-line highlight |

## Suppressing Noise

Use ignored key or value patterns for project-specific false positives:

```lua
require('camouflage').setup({
  checks = {
    weak_secret = {
      ignored_key_patterns = { '^TEST_', '^EXAMPLE_' },
      ignored_value_patterns = { '^example$', '^dummy-token-for-docs$' },
    },
  },
})
```

The same configuration is allowed in `.camouflage.yaml` under `checks.weak_secret`.

## Commands

| Command | Description |
|---|---|
| `:CamouflageWeakSecretToggle` | Toggle weak-secret badges at runtime |

When re-enabled, loaded supported buffers are refreshed so badges appear without waiting for another edit.

## Privacy

The check runs locally and never performs network I/O. Badge text contains only the reason, such as `[weak: default]`.

Result metadata stores redacted context:

```lua
{
  reason = 'default',
  key = 'PASSWORD',
  value_length = 8,
  score = nil,
  sensitive_key = true,
}
```

Plaintext values are not stored in check results.

## Badge Composition

Weak-secret badges use the shared checks badge renderer with [[Have I Been Pwned]] and [[JWT Expiry Hints]]. The default render order is:

1. `pwned`
2. `weak_secret`
3. `expiry`
4. custom checks alphabetically

The highest-severity result on a line owns the sign column and whole-line highlight.

## See Also

- [[Configuration]] — `checks.weak_secret` reference
- [[Custom Check API]] — register your own checks
- [[Have I Been Pwned]] — network-backed breach checks
