# Architecture

This page describes the internal architecture of camouflage.nvim for contributors and users who want to understand how the plugin works.

## Module Overview

```
lua/camouflage/
├── init.lua                  # Main module & public API
├── config.lua                # Configuration management
├── state.lua                 # Per-buffer state tracking
├── core.lua                  # Core decoration engine
├── autocmds.lua              # Autocommand setup
├── commands.lua              # User command registration
├── hooks.lua                 # Event system
├── reveal.lua                # Reveal & follow cursor
├── yank.lua                  # Yank/copy values
├── audit.lua                 # Redacted workspace audit engine
├── policy.lua                # Data-only masking policy evaluator
├── position.lua              # Byte offset to line/column helpers
├── offsets.lua               # Offset helpers used by parsers
├── styles.lua                # Masking style generators
├── treesitter.lua            # TreeSitter utilities
├── log.lua                   # Logging
├── init_command.lua          # :CamouflageInit command
├── project_config.lua        # .camouflage.yaml loader
├── project_config_watch.lua  # Config file watcher
├── parsers/
│   ├── init.lua              # Parser registry
│   ├── custom.lua            # Custom pattern parser
│   ├── env.lua               # .env parser
│   ├── json.lua              # JSON parser
│   ├── yaml.lua              # YAML parser
│   ├── toml.lua              # TOML parser
│   ├── properties.lua        # Properties/INI parser
│   ├── netrc.lua             # .netrc parser
│   ├── xml.lua               # XML parser
│   ├── http.lua              # HTTP parser
│   ├── hcl.lua               # HCL/Terraform parser
│   └── dockerfile.lua        # Dockerfile parser
├── checks/
│   ├── init.lua              # Check aggregator
│   ├── store.lua             # Per-buffer, per-line check result store
│   ├── badges.lua            # Shared badge renderer
│   ├── registry.lua          # Public custom check registry
│   ├── weak_secret.lua       # Offline weak-secret quality check
│   └── expiry/
│       ├── init.lua          # JWT expiry hint check
│       ├── jwt.lua           # JWT parsing
│       └── base64url.lua     # Pure-Lua base64url decoder
├── pwned/
│   ├── init.lua              # HIBP orchestrator
│   ├── api.lua               # API client
│   ├── cache.lua             # In-memory cache
│   ├── check.lua             # Check orchestrator
│   ├── hash.lua              # SHA-1 hashing
│   └── ui.lua                # Visual indicators
└── templates/
    └── project_config.yaml   # Template for :CamouflageInit
```

## Initialization Flow

```
require('camouflage').setup(opts)
    │
    ├─ config.setup(opts)
    │   ├── Validate options (style, max_lines)
    │   ├── Store user_options
    │   ├── Load project config (.camouflage.yaml)
    │   └── Merge: defaults ← user_options ← project_config → effective
    │
    ├─ reconfigure_runtime()
    │   ├── setup_highlight()              — Create highlight groups
    │   ├── autocmds.setup()               — Register BufEnter, TextChanged, etc.
    │   ├── setup_integrations()           — Telescope, Snacks, nvim-cmp
    │   └── autocmds.apply_to_loaded_buffers()
    │
    ├─ hooks.setup(hooks_config)           — Initialize event system
    ├─ parsers.setup()                     — Register all built-in parsers
    ├─ commands.setup()                    — Register user commands
    ├─ pwned.setup()                       — Setup HIBP highlights
    ├─ checks.expiry.setup()               — Setup JWT expiry hints
    ├─ checks.weak_secret.setup()          — Setup offline weak-secret check
    ├─ project_config_watch.setup()        — Start file watcher
    │
    └─ If reveal.follow_cursor == true:
        └── reveal.start_follow_cursor()
```

## Masking Flow (Per Buffer)

This is the core flow that happens when a buffer is opened or text changes:

```
Autocmd fires (BufEnter / TextChanged)
    │
    ▼
core.apply_decorations(bufnr)
    │
    ├─ Check config.is_enabled() → if false, clear decorations
    ├─ Check max_lines → skip if file too large
    ├─ Clear existing extmarks (nvim_buf_clear_namespace)
    ├─ Get buffer content (nvim_buf_get_lines)
    │
    ├─ parsers.find_parser_for_file(filename)
    │   ├── Match config.patterns
    │   ├── Check runtime parser registrations by priority
    │   └── Fall back to config.custom_patterns
    │
    ├─ HOOK: emit('before_decorate', bufnr, filename)
    │   └── If any listener returns false → abort
    │
    ├─ parser.parse(content, bufnr)
    │   ├── Try TreeSitter (if parser installed)
    │   │   ├── Check parser availability (cached)
    │   │   ├── Load query file or inline fallback
    │   │   ├── Parse tree, iterate @key/@value captures
    │   │   └── Return ParsedVariable[]
    │   └── Fall back to regex parsing
    │
    ├─ policy.filter_variables(...)
    │   ├── Apply terminal_path_ignores
    │   ├── Apply ordered ignore/mask rules
    │   └── Attach redacted policy metadata and stats
    │
    ├─ For each policy-surviving variable:
    │   ├── HOOK: emit('variable_detected', bufnr, var)
    │   │   ├── Built-in local checks such as weak_secret and expiry subscribe here
    │   │   └── If returns false → skip this variable
    │   └── Add to filtered_variables
    │
    ├─ state.set_variables(bufnr, filtered_variables)
    ├─ checks.registry.run(...)
    │   ├── Run enabled public custom checks
    │   ├── Validate and redact check results
    │   └── Publish badges through checks.store/checks.badges
    ├─ Compute line offsets (for O(1) position lookup)
    │
    ├─ For each filtered variable:
    │   └── apply_single_decoration(bufnr, var, cfg, lines, offsets)
    │       ├── Convert byte offset to (line, col) via binary search
    │       ├── styles.generate_hidden_text(style, length, original)
    │       │   ├── 'stars':    string.rep(mask_char, length)
    │       │   ├── 'dotted':   string.rep('•', length)
    │       │   ├── 'text':     config.hidden_text
    │       │   └── 'scramble': deterministic Fisher-Yates shuffle
    │       ├── Single-line: nvim_buf_set_extmark with virt_text overlay
    │       └── Multi-line: one extmark per line
    │
    └─ HOOK: emit('after_decorate', bufnr, filtered_variables)
```

## Key Design Decisions

### Extmarks (Zero File Modification)

All masking uses Neovim's extmark API (`nvim_buf_set_extmark` with `virt_text` overlay). The actual file content is never modified. This means:
- `git diff` shows no changes
- Saving the file writes the original content
- Other plugins see the real content
- Undo/redo works normally

### Namespace Isolation

All extmarks use a single namespace (`camouflage`) created in `state.lua`. This allows efficient bulk operations:
- `nvim_buf_clear_namespace` clears all camouflage marks at once
- No interference with other plugins' extmarks

### Parser Priority

Parser selection follows this order:

1. `config.patterns`, including the built-in defaults
2. Runtime parser registrations with `filetypes` or `file_patterns`, sorted by priority
3. `config.custom_patterns`

Runtime registrations can override other runtime entries by priority. `:CamouflageParsers` shows the live registry.

### TreeSitter with Regex Fallback

Every TreeSitter-capable parser implements both strategies. TreeSitter availability is checked once per language and cached. This ensures the plugin works regardless of TreeSitter installation status.

### Debounced Re-decoration

Text changes trigger re-decoration with a configurable debounce (`debounce_ms`, default 150ms). This prevents excessive re-parsing during rapid editing. Each buffer has its own debounce timer.

### Configuration Layering

Four layers merge using `vim.tbl_deep_extend`:

```
defaults ← setup() ← .camouflage.yaml ← vim.b.camouflage_*
```

Buffer-local variables are checked at decoration time, not at merge time, allowing dynamic per-buffer overrides.

### Policy Before Hooks and Checks

Policy runs after parsing and before `variable_detected` hooks. Hooks and registered checks only see variables that survived policy. This keeps ignore rules consistent across live masking and workspace audit.

### Shared Check Badges

HIBP, weak-secret, JWT expiry, and custom checks all write `CheckResult` entries into `checks.store`. `checks.badges` composes one badge extmark per line, sorted by check name order (`pwned`, `weak_secret`, `expiry`, then custom checks alphabetically). The highest-severity result owns the sign column and whole-line highlight.

## State Management

### Buffer State

Each buffer tracks:

```lua
{
  enabled = boolean,           -- Whether masking is active
  variables = ParsedVariable[],-- Detected variables
  parser = string|nil,         -- Parser name used
}
```

State is stored in `state.buffers[bufnr]` and cleaned up on `BufDelete`.

### Global State

- `config.options` — Effective merged configuration
- `hooks.listeners` — Registered event listeners
- `pwned.cache` — In-memory HIBP result cache
- `reveal.state` — Follow cursor and reveal state
- `checks.store` — Per-buffer check badge results
- `checks.registry` — Runtime public check registrations

## See Also

- [[API]] — Public Lua API
- [[Events and Hooks]] — Event system details
- [[TreeSitter]] — TreeSitter query details
