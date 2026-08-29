# JWT Expiry Hints

camouflage.nvim detects JSON Web Token (JWT) values among the secrets it has masked, decodes the `exp` claim, and renders a badge next to the masked line showing how much time is left before the token expires.

The badge is composed with any other check on the same line (such as [[Have I Been Pwned]] or [[Weak Secret Check]]) through a shared **badges renderer**, so checks do not visually conflict.

## Examples

```
JWT_TOKEN=*********  [Google expires in 2h]
SESSION=***********  [expired 3d ago]
PASSWORD=**********  [PWNED 5x] [Auth0 expires in 12m]
```

## How It Works

1. Every value produced by a parser is offered to the expiry check via the `variable_detected` hook.
2. The string is checked against a conservative JWT shape (`eyJ...` prefix, three url-safe-base64 segments separated by dots).
3. The header and payload are base64url-decoded with a **pure-Lua decoder**, then parsed with `vim.json.decode`.
4. The `exp` claim (Unix timestamp, seconds) is compared against the current time.
5. The remaining seconds are classified against configurable thresholds and a badge is written into the checks store; the badges renderer composes a single extmark per line from all check results.
6. A background timer (configurable interval, default 60s) re-classifies existing badges without re-parsing — `"expires in 2h"` becomes `"expires in 1h"` as time passes.

**No network calls. No signature verification.** This is a privacy-friendly, local hint, not a security check.

## Threshold Logic

```
remaining = exp − now

remaining ≤ 0                              → "expired Nd ago"      (error / red)
remaining < warn_threshold_seconds         → "expires in Nm"       (warning / yellow)
warn ≤ remaining < show_threshold_seconds  → "valid Nh"            (info / Comment)
remaining ≥ show_threshold_seconds         → no badge (too far out to be useful)
```

Defaults: `show_threshold_seconds = 86400` (24h), `warn_threshold_seconds = 3600` (1h).

## Configuration

```lua
require('camouflage').setup({
  checks = {
    -- Badges layer (shared by pwned + weak_secret + expiry + custom checks)
    badges = {
      position = 'right_align',  -- 'right_align' | 'eol' | 'inline'
      separator = ' ',           -- between adjacent badges
      separator_hl = 'Comment',
    },

    expiry = {
      enabled = true,
      show_threshold_seconds = 86400,
      warn_threshold_seconds = 3600,
      show_provider = true,            -- include name from `iss` claim
      refresh = {
        auto_interval = 60,            -- background re-render seconds, 0 disables
      },
      hl_valid = 'Comment',
      hl_warning = 'DiagnosticWarn',
      hl_expired = 'DiagnosticError',
    },
  },
})
```

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enabled` | `boolean` | `true` | Enable/disable the entire expiry check |
| `show_threshold_seconds` | `integer` | `86400` | Only show badge when remaining time is below this |
| `warn_threshold_seconds` | `integer` | `3600` | Switch badge to warning color when below this |
| `show_provider` | `boolean` | `true` | Prefix badge with provider name detected from `iss` |
| `refresh.auto_interval` | `integer` | `60` | Background timer seconds; `0` disables |
| `hl_valid` | `string` | `'Comment'` | Highlight when token is valid but within show threshold |
| `hl_warning` | `string` | `'DiagnosticWarn'` | Highlight when within warn threshold |
| `hl_expired` | `string` | `'DiagnosticError'` | Highlight when expired |

### Badge Position

JWTs are typically very long (200+ characters). With `virt_text_pos = 'eol'` the badge would land far off-screen on most monitors. The default `'right_align'` pins the badge to the right edge of the window so it stays visible regardless of line length.

| Position | Behavior |
|---|---|
| `right_align` (default) | Pinned to the right edge of the window |
| `eol` | At the end of the line — classic Neovim virtual text behavior |
| `inline` | Inserted after the line text — pushes content right |

## Recognized Providers

When `show_provider = true`, the `iss` claim is matched against this list. Unknown issuers get no provider tag.

| Provider | Matched on |
|---|---|
| Google | `accounts.google.com` |
| Auth0 | `*.auth0.com` |
| Microsoft | `login.microsoftonline.com`, `sts.windows.net` |
| GitHub | `github.com` |
| GitHub Actions | `token.actions.githubusercontent.com` |
| Cognito | `cognito-idp.*` |
| Okta | `*.okta.com` |
| Firebase | `*.firebaseapp.com`, `securetoken.google.com` |

## Commands

| Command | Description |
|---------|-------------|
| `:CamouflageExpiryToggle` | Toggle the expiry check on/off at runtime |

The hook system handles re-detection on every edit, and the background timer keeps badge text fresh, so no manual "check" or "refresh" command is needed.

## How it Composes with Pwned

Both checks write `CheckResult` entries into a per-buffer store, keyed by line. The shared badges renderer:

- Composes one extmark per line with all checks' `text` joined by `separator`.
- Sorts checks by a fixed order (`pwned` → `weak_secret` → `expiry` → custom checks alphabetically).
- Lets the highest-severity check own the sign column and line highlight (only one of each is possible per line — `error` > `warning` > `info`).

This is why a line with multiple findings can show `[PWNED 5x] [weak: default] [expires in 2h]` cleanly without overlapping virtual text.

## Caveats

- **Heuristic detection.** A value is treated as a JWT only when it starts with `eyJ` and has a valid base64url header containing an `alg` field. False positives are rare in practice; false negatives are possible for non-standard tokens.
- **No signature verification.** The plugin trusts the `exp` claim as-is. If you need cryptographic verification, this is not the tool.
- **`exp` is the only claim that matters.** Tokens without an `exp` claim never produce a badge.
- **Clock skew.** Comparison uses `os.time()`. If your local clock is wrong, badges will be wrong by the same amount.

## See Also

- [[Have I Been Pwned]] — sibling check that also renders through the badges layer
- [[Weak Secret Check]] — offline quality hints that share the same badges layer
- [[Events and Hooks]] — the `variable_detected` hook that expiry subscribes to
- [[Configuration]] — full configuration reference
