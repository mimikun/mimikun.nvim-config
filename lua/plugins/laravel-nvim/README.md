## Default keymaps

The keymaps below ship in the lazy snippet above. `Laravel.commands.run("…")` accepts any of the signatures listed in the [Features](#features) section.

| Keys | Action |
| --- | --- |
| `<leader>ll` | Open the master Laravel picker |
| `<leader>la` | Open the Artisan command picker |
| `<leader>lr` | Open the routes picker |
| `<leader>lm` | Open the `make:*` picker |
| `<leader>lc` | Open your custom-commands picker |
| `<leader>lo` | Open the resources picker |
| `<leader>lt` | Open the code-actions picker |
| `<leader>lu` | Open the Artisan Hub |
| `<leader>lp` | Open the Command Center |
| `<leader>lh` | Open `artisan docs` in a popup |
| `<c-g>` | View finder (jump to definition / usage) |
| `gf` (expression) | Laravel-aware `gf` (route/view/config/env/Inertia) |

## Configuration

`laravel.setup({...})` accepts the same shape as [`lua/laravel/options/default.lua`](lua/laravel/options/default.lua).

### Top-level options

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `features.pickers.enable` | `boolean` | `true` | Toggle every picker. |
| `features.pickers.provider` | `'telescope' \| 'fzf-lua' \| 'snacks' \| 'ui.select'` | `'telescope'` | Picker backend. |
| `eloquent_generate_doc_blocks` | `boolean` | `true` | Generate the typed doc-block file in `vendor/` that makes Eloquent chains LSP-discoverable. |
| `debug_level` | `vim.log.levels` | `DEBUG` | Floor for the file-based logger. |
| `commands_options.<name>` | `table` | `{}` | Per-subcommand runner options (e.g. `commands_options.docs = { ui = "popup" }`). |
| `ui` | `table` | see [`default.lua`](lua/laravel/options/default.lua#L24) | Layout options for the runner / prompt / help windows. |
| `environments` | `table` | see below | Multi-environment config. |
| `resources` | `table` | see [Resources](#resources) | Directories the resources picker groups files under. |
| `user_commands` | `table` | see [User commands](#user-commands) | Custom quick actions. |
| `extensions` | `table` | see [Extensions](#extensions) | Per-extension toggles and per-extension options. |
| `providers` | `table` | internal | Override / extend the DI providers (advanced). |
| `user_providers` | `table` | `{}` | Add your own providers (see [Extending](#extending)). |

### Environments

The plugin uses your environment to decide which executable actually runs `php`, `composer`, `npm`, `yarn`, and (by extension) `artisan`. Pick one per project via `:lua Laravel.commands.run("env:configure")`.

Built-in definitions (see [`lua/laravel/options/environments.lua`](lua/laravel/options/environments.lua)):

| Name | `php` runs as | Notes |
| --- | --- | --- |
| `local` | `php` | Default. Uses whatever is on `$PATH`. |
| `sail` | `vendor/bin/sail php` | Laravel Sail. |
| `docker-compose` | `docker compose exec -it app php` | Classic `docker-compose` v2. |
| `herd` | `herd php` | [Laravel Herd](https://herd.laravel.com). |
| `valet` | `valet php` | [Laravel Valet](https://laravel.com/docs/valet). |
| `symfony` | `symfony php` | [Symfony CLI](https://symfony.com/download). |

To add your own (e.g. `lando`, `devilbox`, custom container names):

```lua
require("laravel").setup({
  environments = {
    default = "lando",
    ask_on_boot = false, -- prompt for the environment when opening a project
    definitions = {
      {
        name = "lando",
        map = {
          php = { "lando", "php" },
          composer = { "lando", "composer" },
          npm = { "lando", "npm" },
        },
      },
    },
  },
})
```

### Resources

`resources` is the directory map used by the resources picker. Default entries are in [`lua/laravel/options/resources.lua`](lua/laravel/options/resources.lua); add your own to fit non-standard layouts:

```lua
require("laravel").setup({
  resources = {
    DTOs = "app/Dto",
    Enums = "app/Enums",
    Filament = "app/Filament/Resources",
  },
})
```

### User commands

Define quick actions for things you run all the time. They appear in the **custom-commands picker** (`<leader>lc`) and can be invoked with `:lua Laravel.run("<executable>", { ... })`.

```lua
require("laravel").setup({
  user_commands = {
    artisan = {
      ["db:fresh --seed"] = {
        cmd = { "migrate:fresh", "--seed" },
        desc = "Drop, re-migrate and seed the database",
      },
    },
    npm = {
      build = { cmd = { "run", "build" }, desc = "Production build" },
      dev   = { cmd = { "run", "dev"   }, desc = "Vite dev server" },
    },
    composer = {
      autoload = { cmd = { "dump-autoload" }, desc = "Regenerate the autoloader" },
    },
  },
})
```

### Extensions

Every extension can be disabled or have its own options overridden:

| Extension | Default | Effect when disabled |
| --- | --- | --- |
| `artisan_hub` | enabled | Removes the `<leader>lu` Artisan Hub. |
| `command_center` | enabled | Removes the `<leader>lp` Command Center. |
| `completion` | enabled | Stops registering the `cmp` / `blink` source. |
| `composer_info` | enabled | Stops annotating `composer.json` with version info. |
| `diagnostic` | enabled | Stops flagging missing views / Inertia pages. |
| `model_info` | enabled | Stops showing DB / table / columns above models. |
| `override` | enabled | Stops placing the override sign on methods. |
| `route_info` | enabled | Stops showing method/URI/middleware above controller methods. |
| `tinker` | enabled | Removes `tinker:open`, `tinker:create`, `tinker:select` and the `.tinker` filetype UI. |

Example — pick a different route-info style:

```lua
require("laravel").setup({
  extensions = {
    route_info = { enable = true, view = "top" }, -- "simple" | "top" | "right"
  },
})
```

### Per-project overrides

Anything stored at setup time is layered with the project-specific overrides file at:

```
stdpath('data') .. '/laravel/config.json'
```

The most common project override is the environment itself — when you run `:lua Laravel.commands.run("env:configure")`, the choice is saved there keyed by `cwd`, so each project gets its own environment on next open. Open it directly with `:lua Laravel.commands.run("env:configure:open")`.

## How it works

```
┌────────────────────────────────────────────────────────────┐
│                          laravel.nvim                       │
│                                                              │
│   ┌──────────────┐    ┌──────────────────────────────────┐  │
│   │  App (DI)    │───▶│  Providers                       │  │
│   │  container   │    │  • laravel  • extensions  • …    │  │
│   └──────┬───────┘    └────────────┬─────────────────────┘  │
│          │                         │                         │
│          ▼                         ▼                         │
│   ┌──────────────┐    ┌──────────────────────────────────┐  │
│   │  Services    │    │  Extensions                      │  │
│   │  • model     │    │  • model_info • route_info      │  │
│   │  • class     │    │  • tinker      • artisan_hub     │  │
│   │  • composer  │    │  • composer_info • diagnostic    │  │
│   │  • gf • …    │    │  • completion • override         │  │
│   └──────┬───────┘    │  • command_center                │  │
│          │            └──────────────────────────────────┘  │
│          ▼                                                 │
│   ┌──────────────┐    ┌─────────────┐  ┌────────────────┐  │
│   │  Loaders     │    │  Pickers    │  │  Listeners     │  │
│   │  (artisan,   │    │  (provider- │  │  (history,     │  │
│   │  routes, …)  │    │   agnostic) │  │   cache, …)    │  │
│   └──────┬───────┘    └─────────────┘  └────────────────┘  │
│          │                                                 │
│          ▼                                                 │
│   ┌──────────────────────────────────────────────────────┐ │
│   │           server-side helpers in vendor/             │ │
│   │  Eloquent introspection · route list · Inertia …     │ │
│   └──────────────────────────────────────────────────────┘ │
└────────────────────────────────────────────────────────────┘
```

The `vendor/` helpers are tiny, self-contained PHP files generated on demand (models, configs, inertia pages, paths, tinker) that JSON-encode what the plugin needs. They are regenerated automatically when the watcher detects changes under `app/`, `app/Models/`, and `database/migrations/`. A file-based cache (with TTLs) keeps everything fast.

The plugin is gated on a Laravel environment: if you open a non-Laravel project, the plugin becomes a no-op and only `:checkhealth laravel` complains.

## Features

### Pickers

Every picker accepts the same `Laravel.pickers.<name>()` call style. The set of names available depends on your configured provider.

| Picker | telescope | fzf-lua | snacks | ui.select |
| --- | :---: | :---: | :---: | :---: |
| `artisan` | ✓ | ✓ | ✓ | ✓ |
| `routes` | ✓ | ✓ | ✓ | ✓ |
| `make` | ✓ | ✓ | ✓ | ✓ |
| `related` | ✓ | ✓ | ✓ | ✓ |
| `resources` | ✓ | ✓ | ✓ | ✓ |
| `commands` | ✓ | ✓ | ✓ | ✓ |
| `composer` | ✓ | ✓ | ✓ | ✓ |
| `history` | ✓ | ✓ | ✓ | ✓ |
| `laravel` (master) | ✓ | — | ✓ | — |

| Picker | `Laravel.pickers.<name>()` | What it shows |
| --- | --- | --- |
| Master | `laravel()` | All built-in `Laravel.commands.run` signatures, searchable. |
| Artisan | `artisan()` | Every `php artisan` command, with usage preview. |
| Routes | `routes()` | `php artisan route:list` rows, with method, URI, middleware, action. Selecting opens the controller at the right method. |
| Make | `make()` | Subset of artisan commands whose name starts with `make:`. |
| Resources | `resources()` | Top-level project directories (Controllers, Models, Migrations, Livewire, …). |
| Related | `related()` | From a model, lists its observers, relations, and policy. |
| Composer | `composer()` | `composer` commands with usage preview. |
| Custom commands | `commands()` | Your `user_commands` groups. |
| History | `history()` | Every command run through `Laravel.run`, with re-run. |

`Laravel.pickers.list()` returns the available picker names for the current provider.

![artisan-picker](imgs/artisan-picker.png)

### Virtual information

Three virtual-text overlays render on `BufEnter` / `BufWritePost`.

- **model_info** — `[ Database: pgsql Table: users Attributes: id, email, name, … ]` above the class declaration of an Eloquent model.
- **route_info** — method / URI / middleware above each controller method that backs a route. Missing methods (route → no method) become `vim.diagnostic` errors on the class. Three styles ship: `simple` (default, single line), `top` (multi-line above), `right` (inline virt text). Switch with `extensions.route_info.view`.
- **composer_info** — current version after each dependency in `composer.json` and an `^ new-version` marker when the package is outdated.

![model-info](imgs/model-info.png)
![route-info](imgs/route-info.png)
![composer-info](imgs/composer-info.png)

### Completion

The completion source is registered automatically for both `nvim-cmp` and `blink.cmp`. The list of triggers:

| Trigger | Source | Notes |
| --- | --- | --- |
| `view('…')` / `View::make('…')` | `views_loader` | Includes vendor views. |
| `inertia('…')` / `Inertia::render('…')` | `inertia_loader` | Uses `inertia.page_paths` from your project. |
| `config('…')` | `configs_loader` | Every key in `config/*.php`. |
| `route('…')` | `routes_loader` | Only named routes; documentation shows method, URI and middleware. |
| `env('…')` | `environment_variables_loader` | Parses the project `.env`. |
| `Model::where(…)`, `Model::orderBy(…)`, `$instance->where(…)` … | `model_completion` | Columns, with type / cast / fillable / nullable shown in documentation. Uses a tree-sitter–based resolver to chase variables. |

**`nvim-cmp`** — automatic, registered as source name `laravel`.

**`blink.cmp`** — automatic if `blink.cmp` is loaded.

If you use a different completion engine, `blink.compat` works:

```lua
{ "Saghen/blink.compat" }
-- in your blink config
sources = {
  default = { "lsp", "path", "snippets", "buffer" },
  providers = {
    laravel = {
      name = "laravel",
      module = "blink.compat.source",
      score_offset = 95, -- show above lsp
    },
  },
}
```

### Actions

A code-action system inspired by LSP, but Laravel-aware. Each action declares a `check(bufnr)` predicate and a `format()` label; only the actions that match the current buffer appear in the picker.

Run with `:lua Laravel.commands.run("actions")` (default keymap `<leader>lt`).

| Action | Applies to | Effect |
| --- | --- | --- |
| **Fillable Fields** | Eloquent models | Generates a `$fillable` array on the model using its real columns (skipping `id`, timestamps, `deleted_at`). Replaces the existing `fillable` property if present. |
| **Add relation** | Eloquent models | Lets you pick another model and a relation type (`BelongsTo` / `HasMany` / `HasOne`); inserts the method, the import, and the model import. Pluralizes the method name where appropriate. |
| **Go To Migration of `<Model>`** | Eloquent models | `ripgrep`s the project for `Schema::create('table_name')` / `Schema::table('table_name')` and jumps to (or lets you pick) the migration. |
| **Create new Listener** | Any class in an `Events` namespace | Runs `artisan make:listener` with `-e <EventClass>`. |
| **Copy Component** | Livewire v3 components | Runs `artisan livewire:copy`. |
| **Move Component** | Livewire v3 components | Runs `artisan livewire:move`. |
| **Delete Component** | Livewire v3 components | Runs `artisan livewire:delete`. |
| **Open env file** | Any PHP file | Opens `.env`. |

### `gf` override

`gf` becomes Laravel-aware inside PHP files. The smart override detects the resource the cursor is on and opens its definition:

| Cursor on | Opens |
| --- | --- |
| `route('users.index')` | The controller method that backs that named route. |
| `view('auth.login')` | `resources/views/auth/login.blade.php`. |
| `Inertia::render('Dashboard')` | The Inertia page file. |
| `config('app.timezone')` | The file in `config/` where `app.timezone` is defined, scrolled to the line. |
| `env('APP_URL')` | `.env`, with the cursor on the matching key. |

The default `gf` is used as a fallback when the cursor is not on a recognised resource.

### `view:finder`

Tied to `<c-g>` by default; behaviour depends on the current filetype:

- **In a `*.blade.php` file** — finds every PHP file that references this view (via `view('…')` or `View::make('…')`) and opens the first match, or prompts if there are several.
- **In a PHP file** — extracts every `view('…')` call, and opens the first one, or lets you pick.

### Tinker

Laravel Tinker reimagined for Neovim. Drop a `main.tinker` (or any `*.tinker`) file in your project root and the plugin opens a side-by-side layout:

![tinker-ui](imgs/tinker-ui.png)

- **Left** — the file you're editing, with full PHP syntax highlighting (auto-prefixed with `<?php`).
- **Right** — the live result of executing it. The result is formatted for Eloquent models and collections (key/value tables) and for query builders (raw SQL + bindings + EXPLAIN).
- **Footer** — execution time and peak memory in MB.

Keymaps inside the Tinker window:

| Key | Action |
| --- | --- |
| `<CR>` | Run the file, switch the result buffer to a terminal. |
| `<Tab>` | Jump to the other window. |
| `q` | Close the Tinker window. |

Commands:

```lua
Laravel.extensions.tinker()         -- same as :open
Laravel.extensions.tinker.open()    -- explicit
Laravel.extensions.tinker.create()  -- prompt for a new .tinker filename
Laravel.extensions.tinker.select()  -- pick from existing .tinker files (depth 4)
```

Or via commands:

```vim
:Laravel tinker:open
:Laravel tinker:create
:Laravel tinker:select
```

### Artisan Hub

A tabbed terminal UI for long-running commands. The first time you open the Hub with `:lua Laravel.commands.run("hub")` (default `<leader>lu`) it starts four tabs: `Serve`, `Assets` (vite), `Pail`, and `Logs`. From there you control them entirely with keymaps:

| Key | Action |
| --- | --- |
| `q` | Close the Hub. |
| `a` | Add a new tab (prompts for a name + command). |
| `d` | Delete the current tab. |
| `r` | Restart the current tab. |
| `s` | Stop the current tab. |
| `e` | Re-execute the current tab. |
| `<Tab>` / `<S-Tab>` | Next / previous tab. |

Add an extra tab on the fly with `:lua Laravel.commands.run("hub:add")`. The default tab set is configured in [`lua/laravel/extensions/artisan_hub/provider.lua`](lua/laravel/extensions/artisan_hub/provider.lua); override it via `setup({ extensions = { artisan_hub = { commands = { … } } } })`.

### Command Center

A REPL-with-autocomplete. `:lua Laravel.commands.run("command_center")` (default `<leader>lp`) opens a small popup with an input box and a live preview pane. As you type `artisan …` or `composer …`, the preview lists the matching commands and their `usage`. `<CR>` runs the line through the same runner as the Hub.

### Diagnostics

Two diagnostic streams run on `BufEnter` / `BufWritePost` for `*.php` files (the second is only active for `*Controller.php`):

- **View existence** — `view('…')`, `View::make('…')` and `Inertia::render('…')` calls whose argument does not resolve to a real file on disk are surfaced as `vim.diagnostic` errors with source `laravel.nvim`.
- **Route existence** — if a route points at a controller method that does not exist, an error is raised on the controller class declaration.

Both are part of the `diagnostic` extension; disable it with `extensions.diagnostic.enable = false`.

### Override signs

A passive extension: on every `BufEnter` / `BufWritePost` for `*.php`, the plugin runs a `ReflectionClass` introspection and places the `LaravelOverride` sign on any method that overrides a parent or implements an interface (PHP `ReflectionMethod::hasPrototype()`). No file is modified; nothing happens unless you're looking at the sign column. Disable with `extensions.override.enable = false`.

### Lualine integration

A `status` service polls `php artisan about --json` every two minutes and exposes `Laravel.app("status"):get("laravel")` and `Laravel.app("status"):get("php")`. Use them in your `lualine` config:

```lua
{
  {
    function()
      local ok, v = pcall(function() return Laravel.app("status"):get("laravel") end)
      return ok and v or nil
    end,
    icon = { " ", color = { fg = "#F55247" } },
    cond = function()
      local ok, has = pcall(function() return Laravel.app("status"):has("laravel") end)
      return ok and has
    end,
  },
  {
    function()
      local ok, v = pcall(function() return Laravel.app("status"):get("php") end)
      return ok and v or nil
    end,
    icon = { " ", color = { fg = "#AEB2D5" } },
    cond = function()
      local ok, has = pcall(function() return Laravel.app("status"):has("php") end)
      return ok and has
    end,
  },
}
```

![lualine](imgs/lualine.png)

### Eloquent completion & doc-blocks

The model completion source uses a tree-sitter–based type resolver to figure out which Eloquent model is on the receiving end of a chain. It only fires on the first parameter of `where`/`order`/`orderBy` and similar methods, and the result includes a documentation block with the column's type, cast, fillable/hidden, nullable, and unique flags.

To make those methods resolve correctly, the plugin generates a small PHP file in `vendor/` with `@method` and `@property` doc-blocks for every model and its query-builder returns. This is on by default (`eloquent_generate_doc_blocks = true`). For large models the generated file can exceed the LSP server's default `maxSize`; raise it:

```lua
vim.lsp.config('intelephense', {
  settings = {
    intelephense = { files = { maxSize = 2000000 } },
  },
})
```

To turn doc-block generation off:

```lua
require("laravel").setup({ eloquent_generate_doc_blocks = false })
```

## Extending

The plugin is a small DI container. You can add actions, providers, listeners, and completion sources without forking it.

### Custom action

Actions live in `lua/laravel/actions/*_action.lua` and follow this shape:

```lua
-- lua/laravel/actions/say_hello_action.lua
local Class = require("laravel.utils.class")

---@class laravel.actions.say_hello_action
local action = Class({}, { info = nil })

function action:check(_)
  return vim.bo.filetype == "php" -- show only in PHP buffers
end

function action:format()
  return "Say Hello"
end

function action:run()
  vim.notify("Hello from laravel.nvim", vim.log.levels.INFO)
end

return action
```

Add the file under `lua/laravel/actions/` (filename must end in `_action.lua`) — the `actions_provider` will pick it up automatically.

### User provider

Anything you put in `user_providers` is registered and booted using the same `register(app)` / `boot(app)` lifecycle as built-in providers:

```lua
require("laravel").setup({
  user_providers = {
    {
      name = "my.extension",
      register = function(app)
        app:bind("my.service", function() return { greeting = "hi" } end)
      end,
      boot = function(app)
        -- create autocmds, register commands, etc.
        vim.api.nvim_create_user_command("SayHi", function()
          vim.notify(app("my.service").greeting)
        end, {})
      end,
    },
  },
})
```

### Listener

The plugin dispatches a small in-process event bus. Built-in events: `command_run`, `cache_flushed`, `entity_created`. Listeners are modules that export `event` + `handle`:

```lua
-- lua/my-listeners/audit_log.lua
return {
  event = require("laravel.events.command_run_event"),
  handle = function(data, app)
    app("log"):info(string.format("ran %s %s", data.cmd, table.concat(data.args, " ")))
  end,
}
```

Register the listener module through a user provider (see above) using `app:bindIf("my.listener", "my-listeners.audit_log")`, then call it on boot — for the simple case, listeners can be invoked from inside a provider's `boot` by `app("my.listener")` once it is bound.

### Completion source

For a new `somethingCompletion` source, mirror one of the modules under [`lua/laravel/extensions/completion/`](lua/laravel/extensions/completion/): a module with `complete(loader, templates, params, callback)` and `shouldComplete(text)`, then dispatch to it from the appropriate `source.lua` / `blink.lua` trigger check.

## Health & troubleshooting

Run `:checkhealth laravel` first. It reports the picker provider, the current environment, the composer executable, and every registered extension.

Useful built-in commands:

| Command | Purpose |
| --- | --- |
| `Laravel.commands.run("env:configure")` | Pick the environment for the current project. |
| `Laravel.commands.run("env:configure:open")` | Open the per-project config JSON in your `stdpath('data')`. |
| `Laravel.commands.run("cache:flush")` | Drop the in-memory cache. Cache is also flushed automatically on `composer` and `artisan` runs (the `cache_invalidation_listener`). |
| `Laravel.commands.run("plugin-logs:open")` | Open the rotating log file at `stdpath('data')/laravel/logs/`. |
| `Laravel.commands.run("picker:history")` | Re-run a previous command. |

Common issues:

- **"Picker provider not found"** — install the provider you selected in `features.pickers.provider` (or switch providers).
- **Completion items missing** — the `cmp` / `blink` source is registered under the name `laravel`; make sure it is enabled in your completion config. The source only fires inside `php`, `blade`, and `tinker` buffers, and only when the plugin is active (Laravel project open and environment configured).
- **No model info / route info** — the watchers only fire on files inside the project; `vendor/` is excluded. If you've moved things around, run `Laravel.commands.run("cache:flush")`.
- **Tinker "Tinker Initialization Error"** — usually an autoload issue; ensure `composer dump-autoload` is healthy and that the project's `bootstrap/app.php` is reachable.
- **"Environment is not configured"** — run `Laravel.commands.run("env:configure")` and pick the environment for this project.

