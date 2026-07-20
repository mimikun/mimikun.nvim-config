## Quick start

**Recommended setup:** If you don't use `before_init` for anything else, you can use it as a global hook
to look for local config files for all LSPs:

```lua
vim.lsp.config('*', {
  before_init = function(_, config)
    local codesettings = require('codesettings')
    codesettings.with_local_settings(config.name, config)
  end,
})
```

**Alternatively,** you can configure it on a per-server basis.

```lua
-- you can also still use `before_init` here
-- if you want codesettings to be `require`d
-- lazily
local codesettings = require('codesettings')
vim.lsp.config(
  'yamlls',
  codesettings.with_local_settings('yamlls', {
    settings = {
      yaml = {
        validate = true,
        schemaStore = { enable = true },
      },
    },
  }, {
    -- you can also pass custom merge opts on a per-server basis
    list_behavior = 'replace',
  })
)

-- or from a config file under `/lsp/rust-analyzer.lua` in your config directory.
-- if you use rustaceanvim to configure rust-analyzer, see the `rustaceanvim` section below
return codesettings.with_local_settings('rust-analyzer', {
  settings = {
    -- ...
  },
})
```

### Rustaceanvim

`codesettings.nvim` works with
[rustaceanvim](https://github.com/mrcjkb/rustaceanvim) >= v7.0.9. You just need a
`before_init` hook like any other LSP.

<details>

<summary>If you use a `rustaceanvim` version older than v7.0.9, you need some configuration</summary>

Older `rustaceanvim` does its own VS Code settings loading by default, but your
global settings override the local ones; `codesettings.nvim` does the opposite.
To make `rustaceanvim` respect workspace files via `codesettings.nvim`, you
need to load them manually:

```lua
return {
  'mrcjkb/rustaceanvim',
  ft = 'rust',
  version = '^6',
  dependencies = { 'mrjones2014/codesettings.nvim' },
  init = function()
    vim.g.rustaceanvim = {
      -- the rest of your settings go here...

      -- I want VS Code settings to override my settings,
      -- not the other way around, so use codesettings.nvim
      -- instead of rustaceanvim's built-in vscode settings loader
      load_vscode_settings = false,
      -- the global hook doesn't work when configuring rust-analyzer with rustaceanvim
      settings = function(_, settings)
        -- Note the exact way this is invoked to work with rustaceanvim:
        -- - passed in settings are wrapped like `{ settings = settings }`
        -- - the returned value is the `.settings` subtable
        return require('codesettings').with_local_settings('rust-analyzer', { settings = settings }).settings
      end,
      default_settings = {
        ['rust-analyzer'] = {
          -- your global LSP settings go here
        },
      },
    }
  end,
}
```

</details>

Some rust-analyzer settings need to be included in the init params as well as
the default settings, in particular for non-Cargo build systems. Here is the
recommended `before_init` hook:

```lua
vim.lsp.config('rust-analyzer', {
  before_init = function(init_params, config)
    local codesettings = require('codesettings')
    codesettings.with_local_settings(config.name, config)
    -- Some settings must be passed at init time, for example rust-analyzer.workspace.discoverConfig
    if config.default_settings and config.default_settings[config.name] then
      init_params.initializationOptions = config.default_settings[config.name]
    end
  end,
})
```

---

## Features

- Minimal API: one function you call per server setup, or with a global hook (see example above)
- `jsonc` filetype for local config files
- Live reload: automatically reload settings when config files change (opt-in via `live_reload = true`)
- Configure the `codesettings.nvim` plugin itself in local config JSON files
- Supports a subset of [VS Code variable interpolation](https://code.visualstudio.com/docs/reference/variables-reference) ([Loader Extensions](#loader-extensions))
- `jsonls` integration for schema-based completion of LSP settings in JSON(C) configuration files
  ![jsonls integration](https://github.com/user-attachments/assets/5d37f0bb-0e07-4c22-bc6b-16cf3e65e201)
- Lua type annotations generated from schemas for autocomplete when writing LSP configs in Lua, with optional `lua_ls` integration
  ![lua type annotations](https://github.com/user-attachments/assets/86d85ff3-1467-4c0b-9542-02cc831951dc)
- Supports custom config file names/locations
- Custom one-shot loaders with configuration that differs from the plugin's global config (see [Advanced Usage](#advanced-usage))
- Supports mixed nested and dotted key paths, for example, this project's `codesettings.json` looks like:

```jsonc
{
  "Lua": {
    "runtime.version": "LuaJIT",
    "workspace": {
      "library": ["${3rd}/luassert/library", "${addons}/busted/library"],
      "checkThirdParty": false,
    },
    "diagnostics.globals": ["vim", "setup", "teardown"],
  },
}
```

To get autocomplete in Lua files, either set `config.lua_ls_integration = true`, or (for `lua_ls` only, not `emmylua_ls`) use
`---@module 'codesettings'` which will tell `lua_ls` to act as though `codesettings` has been `require`d, then you will
have access to `---@type lsp.server_name` generated type annotations.

```lua
-- for example, for lua_ls
vim.lsp.config('lua_ls', {
  -- this '@module' annotation makes lua_ls import the library from codesettings,
  -- where the annotations come from; this isn't needed if you use `lua_ls_integration = true`
  -- and `codesettings.nvim` is loaded
  ---@module 'codesettings'
  -- then you will have access to the generated type annotations
  ---@type lsp.lua_ls
  settings = {},
})
```

---

## API

- `require('codesettings').setup(opts?: CodesettingsConfig)`
  - Initialize the plugin. Not needed if you are only using the API, but must be called to set up additonal functionality or to configure `codesettings.nvim` itself with local files.

- `require('codesettings').with_local_settings(lsp_name: string, config: table, opts: CodesettingsConfigOverrides?): table`
  - Loads settings from the configured files, extracts relevant settings for the given LSP based on its schema, and deep-merges into `config.settings`. Returns the merged config.
  - This **mutates the input `config` table.** This is necessary for some workflows to ensure the `vim.lsp` module sees the updated settings.

- `require('codesettings').local_settings(opts: CodesettingsConfigOverrides?): Settings`
  - Loads and parses the settings file(s) for the current project. Returns a `Settings` object.
  - `Settings` object provides some methods like:
    - `Settings:schema(lsp_name)` - Filter the settings down to only the keys that match the relevant schema e.g. `settings:schema('eslint')`
    - `Settings:merge(settings, key, opts)` - merge another `Settings` object into this one, optionally specify a sub-key to merge, and control merge behavior with the 2nd and 3rd parameter, respectively (e.g. `{ merge_lists = 'replace' }`)
    - `Settings:get(key)` - returns the value at the specified key; supports dot-separated key paths like `Settings:get('some.sub.property')`
    - `Settings:get_subtable(key)` - like `Settings:get(key)`, but returns a `Settings` object if the path is a table, otherwise `nil`
    - `Settings:clear()` - remove all values
    - `Settings:set(key, value)` - supports dot-separated key paths like `some.sub.property`

Example using `local_settings()` directly:

```lua
local codesettings = require('codesettings')
local eslint_settings = c.local_settings()
  :schema('eslint')
  :merge({
    eslint = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = 'sameLine',
        },
      },
    },
  })
  :get('eslint.codeAction') -- get the codeAction subtable
```

---

## How merging works

Follows the semantics of `vim.tbl_deep_extend('force', your_config, local_config)`, essentially:

- The plugin deep-merges plain tables (non-list tables)
- List/array values are appended by default; you can change this behavior in configuration or through the API
- Your provided `config` is the base; values from the settings file override or extend it within `config.settings`

---

## Advanced Usage

### One-shot Loaders

`codesettings.nvim` provides a fluent `ConfigBuilder` API that lets you override plugin options for a single load of local settings, without affecting the
global configuration. This is useful, for example, for multi-root projects where you might have a separate instance of the LSP server per-root.

```lua
vim.lsp.config('rust-analyzer', {
  before_init = function(init_params, config)
    local c = require('codesettings')
    c
      -- starts from the plugin's global config as a base
      .loader()
      -- override the root directory from the LSP config, which might be a sub-root
      :root_dir(config.root_dir)
      -- merge local settings according to the configuration specified
      -- by this `ConfigBuilder`
      :with_local_settings(
        config.name,
        config
      )
    -- Some settings must be passed at init time, for example rust-analyzer.workspace.discoverConfig
    if config.default_settings and config.default_settings[config.name] then
      init_params.initializationOptions = config.default_settings[config.name]
    end
  end,
})
```

See [codesettings.config.schema](https://github.com/mrjones2014/codesettings.nvim/tree/master/lua/codesettings/config/schema.lua)
for the full available API and which settings can be overridden.

### Loader Extensions

`codesettings.nvim` allows for custom post-processing of your local config files. Extensions can be registered globally,
or through the `ConfigBuilder` for one-shot loaders. Extensions can be registered directly, or via a string which will be
`require`d. **_Only the VS Code variable interpolation extension (`codesettings.extensions.vscode`) is loaded by default.
All other extensions must be explicitly configured._**

```lua
-- To add additional extensions while keeping the default VS Code extension,
-- you must explicitly include BOTH in the list (this replaces the default):
require('codesettings').setup({
  loader_extensions = {
    'codesettings.extensions.vscode', -- Keep the default VS Code extension
    'codesettings.extensions.env', -- Add environment variable support
    require('some-3rdparty-ext'), -- you can also put inline extension modules
    -- you can also put extension constructors for stateful extensions
    function()
      return SomeExtension.new()
    end,
  },
})

-- Or for one-shot loaders:
require('codesettings')
  .loader()
  :loader_extensions({
    'codesettings.extensions.vscode',
    'codesettings.extensions.env',
  })
  :with_local_settings('lua_ls', {
    -- ...
  })
```

`codesettings.nvim` provides the following built-in loader extensions:

- `codesettings.extensions.vscode` **(loaded by default)**
  - Expand VS Code variable interpolation syntax in JSON config files.
  - Supports a subset of VS Code variables applicable to Neovim:
    - `${userHome}` - User's home directory
    - `${workspaceFolder}` - Project root directory
    - `${workspaceFolderBasename}` - Project root directory name
    - `${cwd}` - Current working directory
    - `${pathSeparator}` - OS-specific path separator (`/` or `\`)
    - `${/}` - Shorthand for `${pathSeparator}`
  - **Note:** Variables requiring a currently open file (like `${file}`, `${relativeFile}`, etc.) or currently selected text are not supported.
  - **Important:** If combining with `codesettings.extensions.env`, this extension must be listed **first** (see [Extension Ordering](#extension-ordering) below).
- `codesettings.extensions.env`
  - Expand environment variables in JSON config files.
  - Supports `$ENV_VAR`, `${ENV_VAR}`, and `${ENV_VAR:-/some/default/path}` syntax.
  - **Not loaded by default** - must be explicitly added to `loader_extensions`.
- `codesettings.extensions.neoconf`
  - Enables compatibility on a best-effort basis with existing `.neoconf.json` files.
  - You will need to configure the plugin to look for those files via the `config_file_paths` option.
  - **Not loaded by default** - must be explicitly added to `loader_extensions`.

#### Extension Ordering

When using multiple loader extensions, **order matters**. Extensions are applied sequentially, with each extension seeing the result of the previous extension's transformation.

**Important for VS Code + Environment Variable Extensions:**

If you want to use both `codesettings.extensions.vscode` (loaded by default) and `codesettings.extensions.env`, you must ensure the VS Code extension runs **before** the env extension:

```lua
require('codesettings').setup({
  loader_extensions = {
    'codesettings.extensions.vscode', -- Must be first
    'codesettings.extensions.env', -- Then env vars
  },
})
```

**Why does order matter?**

Both extensions use the `${...}` syntax for variable interpolation:

- VS Code extension expands specific variables like `${workspaceFolder}`, `${userHome}`, etc.
- Env extension expands any `${VARIABLE}` to environment variables

If the env extension runs first, it will expand `${workspaceFolder}` to an empty string (since there's no such environment variable), and then the VS Code extension will see `/src` instead of `${workspaceFolder}/src`, preventing it from working correctly.

By putting VS Code first, it expands `${workspaceFolder}` to the project root, and then the env extension can expand any remaining environment variables.

**If you only use the default configuration** (VS Code extension only), no special ordering considerations are needed.

**To disable the default VS Code extension:**

If you don't want VS Code variable interpolation, set `loader_extensions` to an empty list or your preferred extensions:

```lua
require('codesettings').setup({
  loader_extensions = {}, -- No extensions
  -- or
  loader_extensions = { 'codesettings.extensions.env' }, -- Only env vars
})
```

#### Extension API

The extension API expects extensions to be modules that provide at least one of two API functions. The
types that describe an extension are:

```lua
---@class CodesettingsLoaderExtensionContext
---@field parent table? The immediate parent table/list of this node
---@field path string[] Full path from the root to this node
---@field key string|integer The key/index of this node in the parent
---@field list_idx integer? Index if parent is a list

---@class CodesettingsLoaderExtension
---Optional visitor for non-leaf nodes (tables or lists). Return a control code and optional replacement value.
---Note that the replacement value is only used if the control code is `REPLACE`.
---@field object (fun(node:any, ctx:CodesettingsLoaderExtensionContext): CodesettingsLoaderExtensionControl, any?)?
---Optional visitor for leaf nodes. Return a control code and optional replacement value.
---Note that the replacement value is only used if the control code is `REPLACE`.
---@field leaf (fun(value:any, ctx:CodesettingsLoaderExtensionContext): CodesettingsLoaderExtensionControl, any?)?

---@enum CodesettingsLoaderExtensionControl
M.Control = {
  ---Continue recursion (for objects) or leave leaf unchanged
  CONTINUE = 'continue',
  ---Skip recursion (objects only)
  SKIP = 'skip',
  ---Replace this node/leaf with provided replacement value (can be nil)
  REPLACE = 'replace',
}
```

Extensions support both simple table style extensions, as well as stateful method style extensions;
they will work whether your functions need to be called like `extension.leaf(value, ctx)` or
`extension:leaf(value, ctx)`. To make a stateful extension, your module should return a function
that constructs the extension instance.

See [codesettings.extensions.env](https://github.com/mrjones2014/codesettings.nvim/tree/master/lua/codesettings/extensions/env.lua)
for a simple example extension, and [codesettings.extensions.vscode](https://github.com/mrjones2014/codesettings.nvim/tree/master/lua/codesettings/extensions/vscode.lua)
for an example of a stateful extension.

