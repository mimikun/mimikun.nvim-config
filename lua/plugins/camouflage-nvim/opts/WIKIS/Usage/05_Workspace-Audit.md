# Workspace Audit

Workspace audit scans supported files under a project root or explicit path and writes redacted findings to quickfix or the current window's location-list.

It uses the same parser registry as live masking, including built-in parsers, runtime parser registrations, and custom patterns. It does not create buffers, apply extmarks, run hooks, or run network checks.

## Commands

| Command | Destination | Description |
|---|---|---|
| `:CamouflageAudit` | `audit.destination` or quickfix | Scan the current project root |
| `:CamouflageAudit {path}` | `audit.destination` or quickfix | Scan a specific file or directory |
| `:CamouflageAudit!` | location-list | Scan the current project root into the current window's location-list |
| `:CamouflageAudit! {path}` | location-list | Scan a specific path into the current window's location-list |

If no path is provided, the root is resolved from the nearest `.camouflage.yaml`, then the nearest `.git` directory, then the current working directory.

## Privacy

Audit output never includes plaintext values. Findings include:

- file path
- line and column
- parser name
- key name
- nested/commented/multiline metadata
- value length
- redacted policy decision metadata, when policy is active

The audit engine does not run Have I Been Pwned or any other network-backed check. It also does not run `variable_detected` hooks, so hook code cannot inspect audit values.

## Configuration

```lua
require('camouflage').setup({
  audit = {
    ignore_patterns = { '.git', '.git/**', 'node_modules', 'node_modules/**' },
    max_files_per_chunk = 50,
    destination = 'quickfix', -- 'quickfix' | 'loclist'
    open = true,
    notify = true,
  },
})
```

| Option | Default | Description |
|---|---:|---|
| `ignore_patterns` | `{'.git', '.git/**', 'node_modules', 'node_modules/**'}` | Root-relative or basename globs skipped by audit |
| `max_files_per_chunk` | `50` | Files processed per scheduled async chunk |
| `destination` | `'quickfix'` | Default list target for `:CamouflageAudit` |
| `open` | `true` | Open quickfix/location-list when findings exist |
| `notify` | `true` | Show completion notifications |

`ignore_patterns` are simple globs, not full `.gitignore` semantics. Use explicit directory patterns such as `dist/**` or `.terraform/**`.

## Policy Interaction

Audit applies [[Rule Based Policy]] before reporting findings. Ignored variables are not listed, and audit stats include how many values policy ignored.

When policy metadata is attached to a finding, it is redacted:

```lua
{
  action = 'mask',
  reason = 'rule',
  rule_id = 'force-client-secrets',
}
```

## Lua API

The audit module is available for advanced workflows:

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

For async scanning:

```lua
local handle = require('camouflage.audit').run({
  path = vim.fn.getcwd(),
  async = true,
  on_complete = function(result)
    require('camouflage.audit').set_list(result)
  end,
})

-- Optional cancellation
handle.cancel()
```

## See Also

- [[Commands and Keymaps]] — command reference
- [[Rule Based Policy]] — policy filtering before audit output
- [[Supported File Formats]] — files audit can parse
