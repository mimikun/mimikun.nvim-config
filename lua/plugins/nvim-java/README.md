

## :computer: APIs

<details>

<summary>:small_orange_diamond:details</summary>

### Build

- `build.build_workspace` - Runs a full workspace build

```lua
require('java').build.build_workspace()
```

- `build.clean_workspace` - Clear the workspace cache
  (for now you have to close and reopen to restart the language server after
  the deletion)

```lua
require('java').build.clean_workspace()
```

### Runner

- `built_in.run_app` - Runs the application or selected main class (if there
  are multiple main classes)

```lua
require('java').runner.built_in.run_app({})
require('java').runner.built_in.run_app({'arguments', 'to', 'pass', 'to', 'main'})
```

- `built_in.stop_app` - Stops the running application

```lua
require('java').runner.built_in.stop_app()
```

- `built_in.toggle_logs` - Toggle between show & hide runner log window

```lua
require('java').runner.built_in.toggle_logs()
```

### DAP

- `config_dap` - DAP is autoconfigured on start up, but in case you want to force
  configure it again, you can use this API

```lua
require('java').dap.config_dap()
```

### Test

- `run_current_class` - Run the test class in the active buffer

```lua
require('java').test.run_current_class()
```

- `debug_current_class` - Debug the test class in the active buffer

```lua
require('java').test.debug_current_class()
```

- `run_current_method` - Run the test method on the cursor

```lua
require('java').test.run_current_method()
```

- `debug_current_method` - Debug the test method on the cursor

```lua
require('java').test.debug_current_method()
```

- `run_all_tests` - Run all tests in the workspace

```lua
require('java').test.run_all_tests()
```

- `debug_all_tests` - Debug all tests in the workspace

```lua
require('java').test.debug_all_tests()
```

- `view_report` - Open the last test report in a popup window

```lua
require('java').test.view_last_report()
```

### Profiles

```lua
require('java').profile.ui()
```

### Refactor

- `extract_variable` - Create a variable from value at cursor/selection

```lua
require('java').refactor.extract_variable()
```

- `extract_variable_all_occurrence` - Create a variable for all occurrences from
  value at cursor/selection

```lua
require('java').refactor.extract_variable_all_occurrence()
```

- `extract_constant` - Create a constant from the value at cursor/selection

```lua
require('java').refactor.extract_constant()
```

- `extract_method` - Create method from the value at cursor/selection

```lua
require('java').refactor.extract_method()
```

- `extract_field` - Create a field from the value at cursor/selection

```lua
require('java').refactor.extract_field()
```

### Settings

- `change_runtime` - Change the JDK version to another

```lua
require('java').settings.change_runtime()
```

</details>

## :clamp: How to Use JDK X.X Version?

<details>
  
<summary>:small_orange_diamond:details</summary>

Use `vim.lsp.config()` to override the default JDTLS settings:

```lua
vim.lsp.config('jdtls', {
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-21",
            path = "/opt/jdk-21",
            default = true,
          }
        }
      }
    }
  }
})
```

</details>

## :wrench: Configuration

<details>

<summary>:small_orange_diamond:details</summary>

For most users changing the default configuration is not necessary. But if you
want, following options are available:

```lua
require('java').setup({
  -- Startup checks
  checks = {
    nvim_version = true,        -- Check Neovim version
    nvim_jdtls_conflict = true, -- Check for nvim-jdtls conflict
  },

  -- JDTLS configuration
  jdtls = {
    version = '1.43.0',
    path = nil,
    auto_install = true,
  },

  -- Extensions
  lombok = {
    enable = true,
    version = '1.18.40',
    path = nil,
    auto_install = true,
  },

  java_test = {
    enable = true,
    version = '0.40.1',
    path = nil,
    auto_install = true,
  },

  java_debug_adapter = {
    enable = true,
    version = '0.58.2',
    path = nil,
    auto_install = true,
  },

  spring_boot_tools = {
    enable = true,
    version = '1.55.1',
    path = nil,
    auto_install = true,
  },

  -- JDK installation
  jdk = {
    auto_install = true,
    version = '17',
    path = nil,
  },

  -- Logging
  log = {
    use_console = true,
    use_file = true,
    level = 'info',
    log_file = vim.fn.stdpath('state') .. '/nvim-java.log',
    max_lines = 1000,
    show_location = false,
  },
})
```

Set `path` when a tool is managed externally. When `path` is set, nvim-java
uses that path and does not install the tool. Set
`auto_install = false` on a tool to fail instead of downloading when no path is
configured. Note: `path` has no effect when the tool is disabled
(`enable = false`) — the tool is simply not loaded.

Path meanings:

- `jdtls.path`: directory containing `plugins/` and platform `config_*`
  directories
- `lombok.path`: path to `lombok.jar`
- `java_test.path`, `java_debug_adapter.path`, `spring_boot_tools.path`: VS Code
  extension root containing `package.json`
- `jdk.path`: JDK home containing `bin/java`

</details>


