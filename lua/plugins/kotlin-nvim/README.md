## ✨ Features

### Zero-Dependency Installation

When using the Mason-installed kotlin-lsp (v261+), no separate JDK installation is required. The language server includes platform-specific builds with a bundled JRE, providing a truly zero-dependency setup experience.

### JDK for Code Analysis

kotlin.nvim runs the language server through `bin/intellij-server`, which ships
its own bundled JBR — you do **not** need to install or configure a Java runtime
to *run* the server. The only Java-related option is which JDK your code is
*analyzed* against:

#### `jdk_for_symbol_resolution` - JDK for Code Analysis

**Purpose:** Specifies which JDK should be used to **analyze your Kotlin code** and resolve symbols/APIs.

**When to use:**
- Your project targets a specific Java version (e.g., Java 17 or 21)
- You need code completion for JDK-specific APIs
- You want symbol resolution against a particular JDK's standard library
- Different projects use different JDK versions

**Examples:**
```lua
-- Project targeting Java 17
jdk_for_symbol_resolution = "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home"

-- Project targeting Java 21
jdk_for_symbol_resolution = "/usr/lib/jvm/java-21-openjdk"

-- Per-project configuration (in .kotlin-lsp.lua)
return {
    jdk_for_symbol_resolution = "/path/to/project-specific/jdk"
}
```

**Recommendation:** Set this to match your project's target JDK version for accurate symbol resolution.

### Enhanced Code Completion

The latest kotlin-lsp versions offer significantly improved code completion:
- Suggestion ordering on par with IntelliJ IDEA
- ~30% better completion latency
- More relevant and context-aware suggestions

#### Completion insertion fix

kotlin-lsp does not put the inserted text in its completion items. Each item
carries an empty `textEdit` plus a `jetbrains.kotlin.completion.apply` command,
and the server applies the real text + caret afterwards via `workspace/applyEdit`
and `window/showDocument`. VS Code's client inserts nothing on accept and lets
the command do the work, so it just works there. Neovim frontends (builtin
completion, nvim-cmp, blink.cmp) insert the item text *and* run the command, so
the server's edit lands on top and the caret ends up mid-identifier — accepting
`App` produces `Ap|p`.

kotlin.nvim fixes this automatically by making Neovim behave like the VS Code
client: we turn the client's own insertion into a no-op and keep the apply
command, so the server performs the real insertion. You get the full
behaviour — text, **auto-import**, parentheses and caret — in every completion
engine (builtin completion, nvim-cmp, blink.cmp). No configuration required.

> [!NOTE]
> This relies on the frontend executing the completion item's `command` (builtin,
> nvim-cmp and blink.cmp all do). The proper fix is still upstream returning a
> real `textEdit`.

### Inlay Hints Support

Full support for LSP inlay hints matching the VSCode extension configuration. All hint types are supported with individual toggles.

#### Quick Start

Minimal configuration (enables all hints with defaults):

```lua
require("kotlin").setup {
    inlay_hints = {
        enabled = true,  -- Auto-enable on LSP attach
    },
}
```

#### All Available Settings

All settings default to `true` except `parameters_excluded`. Only specify settings you want to change:

```lua
require("kotlin").setup {
    inlay_hints = {
        enabled = true,  -- Master switch: enable/disable all inlay hints

        -- Parameter hints (show parameter names in function calls)
        parameters = true,  -- foo(name: "value", age: 42)
        parameters_compiled = true,  -- Show parameter names for compiled code
        parameters_excluded = false,  -- Show hints for excluded parameters (usually false)

        -- Type hints (show inferred types)
        types_property = true,  -- val name: String = "foo"
        types_variable = true,  -- val count: Int = 42
        function_return = true,  -- fun foo(): String { }
        function_parameter = true,  -- fun foo(name: String) { }

        -- Lambda hints
        lambda_return = true,  -- { x -> x * 2 }: (Int) -> Int
        lambda_receivers_parameters = true,  -- Show receivers and parameters

        -- Other hints
        value_ranges = true,  -- Show hints for ranges
        kotlin_time = true,  -- Show kotlin.time warnings
    },
}
```

#### Settings Reference

| Setting | Default | Description |
|---------|---------|-------------|
| `enabled` | `true` | Master switch to enable/disable all inlay hints |
| `parameters` | `true` | Show parameter names in function calls |
| `parameters_compiled` | `true` | Show parameter names for compiled/external functions |
| `parameters_excluded` | `false` | Show parameter names for excluded parameters |
| `types_property` | `true` | Show type hints for properties |
| `types_variable` | `true` | Show type hints for local variables |
| `function_return` | `true` | Show return type hints for functions |
| `function_parameter` | `true` | Show type hints for function parameters |
| `lambda_return` | `true` | Show return type hints for lambdas |
| `lambda_receivers_parameters` | `true` | Show receiver and parameter hints for lambdas |
| `value_ranges` | `true` | Show hints for value ranges |
| `kotlin_time` | `true` | Show kotlin.time package warnings |

#### Commands

- `:KotlinInlayHintsToggle` - Toggle inlay hints for the current buffer
- `:lua vim.lsp.inlay_hint.enable(true)` - Enable inlay hints
- `:lua vim.lsp.inlay_hint.enable(false)` - Disable inlay hints

#### Key Mapping Example

```lua
vim.keymap.set('n', '<leader>ih', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hints' })
```

**Note:** The `KotlinHintsToggle` command toggles diagnostic hints (HINT severity diagnostics), while `KotlinInlayHintsToggle` controls LSP inlay hints. These are two different features.

#### Implementation Note

Inlay hints work by implementing a `workspace/configuration` handler that responds to server requests for the `jetbrains.kotlin` configuration section. The handler builds a properly nested configuration object matching the VSCode extension format. This is crucial because kotlin-lsp requests configuration dynamically rather than using only the initial settings.

### Code Folding

When enabled (the default on kotlin-lsp v262.4739.0+ and Neovim 0.11+), the plugin wires `foldmethod=expr` with `foldexpr=v:lua.vim.lsp.foldexpr()` and sets `foldlevel=99` so files open with all folds expanded. Fold ranges (Kotlin functions, classes, blocks, imports, multiline comments) are pulled from kotlin-lsp via the standard `textDocument/foldingRange` request. To opt out, set `folding = { enabled = false }` in your setup.

Folding uses standard Vim keymaps — kotlin.nvim does not bind its own:

| Keymap | Action |
|--------|--------|
| `zo`   | Open fold under cursor |
| `zc`   | Close fold under cursor |
| `za`   | Toggle fold under cursor |
| `zR`   | Open all folds in the buffer |
| `zM`   | Close all folds in the buffer |
| `zj` / `zk` | Jump to next / previous fold |

See `:help fold-commands` for the full list.

### Available Commands

kotlin.nvim provides several commands for working with Kotlin code:

| Command | Description |
|---------|-------------|
| `:KotlinOrganizeImports` | Organize and optimize imports in the current file |
| `:KotlinFormat` | Format the current buffer using IntelliJ IDEA formatting rules |
| `:KotlinSymbols` | Show document symbols/outline for the current buffer (displays in trouble.nvim window) |
| `:KotlinWorkspaceSymbols` | Search for symbols across the entire workspace (displays in trouble.nvim window) |
| `:KotlinTypeDefinition` | Go to the type definition of the symbol under cursor (v262+) |
| `:KotlinImplementation` | Go to the implementation of the symbol under cursor (v262+) |
| `:KotlinIncomingCalls` | Show callers of the symbol under cursor (v262.4739.0+) |
| `:KotlinOutgoingCalls` | Show what the symbol under cursor calls (v262.4739.0+) |
| `:KotlinReferences` | Find all references to the symbol under cursor |
| `:KotlinRename` | Rename the symbol under cursor across the project |
| `:KotlinCodeActions` | Show all available code actions from kotlin-lsp |
| `:KotlinQuickFix` | Show quick fixes for diagnostics on current line |
| `:KotlinInlayHintsToggle` | Toggle inlay hints on/off for the current buffer |
| `:KotlinHintsToggle` | Toggle HINT severity diagnostics (if sent by the server) |
| `:KotlinNewFromTemplate` | Pick an IntelliJ-style file template and apply it to the current buffer (v262.4739.0+) |
| `:KotlinExportWorkspaceToJson` | Export workspace structure to `workspace.json` |
| `:KotlinCleanWorkspace` | Clear cached indices and JetBrains analyzer cache for the current project |
| `:KotlinShowLogs` | Open the kotlin-lsp server log (for the current project) and Neovim's LSP log |
| `:KotlinDebug [port]` | Attach debugger to a Kotlin/JVM process (JDWP port, default 5005; requires nvim-dap) |

> [!note]
> `:KotlinSymbols` and `:KotlinWorkspaceSymbols` require [trouble.nvim](https://github.com/folke/trouble.nvim) to display results in a clean, interactive window. These commands provide a better alternative to traditional location lists for browsing code structure.

**Key Mappings Example:**
```lua
-- Code actions and quick fixes
vim.keymap.set('n', '<leader>ka', ':KotlinCodeActions<CR>', { desc = 'Kotlin code actions' })
vim.keymap.set('n', '<leader>kq', ':KotlinQuickFix<CR>', { desc = 'Kotlin quick fix' })

-- Go to type definition
vim.keymap.set('n', '<leader>kt', ':KotlinTypeDefinition<CR>', { desc = 'Go to type definition' })

-- Go to implementation
vim.keymap.set('n', '<leader>ki', ':KotlinImplementation<CR>', { desc = 'Go to implementation' })

-- Organize imports
vim.keymap.set('n', '<leader>ko', ':KotlinOrganizeImports<CR>', { desc = 'Organize Kotlin imports' })

-- Format buffer
vim.keymap.set('n', '<leader>kf', ':KotlinFormat<CR>', { desc = 'Format Kotlin buffer' })

-- Show symbols
vim.keymap.set('n', '<leader>ks', ':KotlinSymbols<CR>', { desc = 'Show document symbols' })

-- Find references
vim.keymap.set('n', '<leader>kr', ':KotlinReferences<CR>', { desc = 'Find references' })

-- Rename symbol
vim.keymap.set('n', '<leader>kn', ':KotlinRename<CR>', { desc = 'Rename symbol' })

-- Toggle inlay hints
vim.keymap.set('n', '<leader>kh', ':KotlinInlayHintsToggle<CR>', { desc = 'Toggle inlay hints' })

-- Show LSP logs
vim.keymap.set('n', '<leader>kl', ':KotlinShowLogs<CR>', { desc = 'Show Kotlin LSP logs' })

-- Debug
vim.keymap.set('n', '<leader>kd', ':KotlinDebug<CR>', { desc = 'Debug Kotlin program' })
```

### Debugging Support

kotlin.nvim integrates with [nvim-dap](https://github.com/mfussenegger/nvim-dap) to provide debugging support through kotlin-lsp's built-in debug adapter. When you start a debug session, the plugin sends a `start_debug_server` command to kotlin-lsp, which spins up a DAP server, then attaches to your running JVM process via JDWP.

**Usage:**

1. Start your Kotlin application with JDWP debugging enabled:
```sh
# Gradle
./gradlew run --debug-jvm

# Maven (tests)
mvn test -Dmaven.surefire.debug
```
Both default to JDWP port **5005**.

2. Open a Kotlin file to activate kotlin-lsp

3. Set breakpoints and attach the debugger:
```vim
:KotlinDebug          " prompts for port (default 5005)
:KotlinDebug 5005     " attach to port 5005 directly
:KotlinDebug 8000     " attach to a custom port
```

The plugin registers a `kotlin` DAP adapter automatically. It is only set if not already configured by the user, so you can fully customize it in your nvim-dap setup.

For breakpoint, stepping, REPL, and variable inspection workflows, see `:help dap.txt`. These are standard nvim-dap features and are not Kotlin-specific.

> [!note]
> nvim-dap is an optional dependency. If it is not installed, DAP features are silently skipped and the rest of the plugin works normally.

### Shared Indices

Indices are now stored in a dedicated folder and properly shared between multiple projects and language server instances, improving performance and reducing disk usage.

## 📥 Language Server Installation

The plugin supports two installation methods for [kotlin-lsp][3]:

### Option 1: Mason Installation (Recommended)

You can easily install kotlin-lsp using [Mason][6] with the following command:

```vim
:MasonInstall kotlin-lsp
```

This is the recommended approach as Mason handles the installation automatically and includes platform-specific builds with a bundled JRE (zero-dependency installation). **No separate JDK installation is required** when using the Mason-installed kotlin-lsp.

The plugin launches kotlin-lsp through its `bin/intellij-server` native launcher (introduced in **v262.4739.0**), which manages its own bundled JBR. Older builds that only ship the `kotlin-lsp.sh` / `kotlin-lsp.cmd` shim are no longer supported — update your install if the launcher is missing.

### Option 2: Manual Installation

If you prefer not to use Mason or need to use a specific version of kotlin-lsp, you can install it manually and set the `KOTLIN_LSP_DIR` environment variable to point to your installation directory:

```bash
export KOTLIN_LSP_DIR=/path/to/your/kotlin-lsp
```

The plugin will automatically detect and use your manual installation when the environment variable is set. The install must contain the `bin/intellij-server` launcher (kotlin-lsp v262.4739.0+):

```
$KOTLIN_LSP_DIR/
├── bin/
│   └── intellij-server    (Unix/macOS launcher; .exe on Windows)
└── lib/
    └── ... (jar files)
```

> [!important]
> Download the official kotlin-lsp distribution from [GitHub releases](https://github.com/Kotlin/kotlin-lsp/releases) to make sure the `bin/intellij-server` launcher is bundled. Older builds that only ship the `kotlin-lsp.sh` / `kotlin-lsp.cmd` shim are no longer supported.

### Extra JVM Arguments

`bin/intellij-server` manages its own bundled JBR, so there is no JRE to configure. To pass extra JVM arguments (e.g., `-Xmx4g`) to the server, use the `jvm_args` option — they are forwarded via the `IJ_JAVA_OPTIONS` environment variable, which the kotlin-lsp server reads at startup.

```lua
require("kotlin").setup {
    jvm_args = { "-Xmx4g" },
}
```

> [!caution]
> If you use other tools like [nvim-lspconfig][8] or [mason-lspconfig][7], make sure to explicitly exclude the `kotlin_lsp` configuration there to avoid conflicts.

