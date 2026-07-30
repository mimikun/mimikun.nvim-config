---@module "chezmoi-template"
---@type chezmoi-template.Config
local opts = {
  -- chezmoi source directory;
  -- nil = auto-detect via `chezmoi source-path`
  ---@type string
  source_dir = nil,

  -- treesitter injection of the deployed target language into *.tmpl buffers
  ---@type chezmoi-template.Config.inject
  inject = {
    -- lua patterns for source paths to leave as plain gotmpl (no target injection)
    -- treesitter injection of the target language into *.tmpl buffers
    ---@type boolean
    enabled = true,

    -- lua patterns (matched on the normalized "/" path) to leave as plain gotmpl
    ---@type string[]
    exclude = {
      --it
    },
  },

  -- conform.nvim formatter that formats templates as their target filetype
  ---@type chezmoi-template.Config.format
  format = {
    -- conform formatter registration
    -- conform formatter that formats templates as their target filetype
    ---@type boolean
    enabled = true,

    -- depth-pad column-0 `{{-` directive blocks
    -- rewrite interior padding of column-0 `{{-` directives so template
    -- nesting depth reads as indentation: {{- lvl0 }}, {{-   lvl1 }}, …
    ---@type boolean
    indent_directives = true,
  },

  -- mini.icons resolution (no-op if absent)
  -- resolve chezmoi source names to target icons in mini.icons
  ---@type chezmoi-template.Config.icons
  icons = {
    -- resolve chezmoi source names to target icons in mini.icons
    ---@type boolean
    enabled = true,
  },

  -- run `chezmoi apply <target>` after writing a managed source file.
  -- force = pass --force (skip chezmoi's prompt on externally-modified targets).
  ---@type chezmoi-template.Config.apply
  apply = {
    -- chezmoi apply <target> after writing a source file
    -- run `chezmoi apply <target>` after writing a managed source file
    ---@type boolean
    on_save = true,

    -- notify on successful applies (failures always notify)
    -- pass --force (skip chezmoi's prompt on externally-modified targets)
    ---@type boolean
    notify = true,

    -- pass --force (skip chezmoi's prompt on modified targets)
    -- notify on successful applies (failures always notify)
    ---@type boolean
    force = false,
  },

  -- :Chezmoi preview rendered preview.
  -- live = re-render as you type (debounced, ms);
  -- false = re-render on write only.
  -- Invalid syntax keeps the last valid render until it parses again.
  -- slow_ms: if a render takes longer than this, live pauses to on-write (guards heavy secret-manager templates); 0 disables.
  -- split: "vertical" | "horizontal" preview window orientation
  ---@type chezmoi-template.Config.preview
  preview = {
    -- :Chezmoi preview re-renders as you type (false = on write)
    -- re-render :Chezmoi preview as you type (false = re-render on write only)
    ---@type boolean
    live = true,

    -- ms of idle before a live re-render
    ---@type integer
    debounce = 150,

    -- a renders slower than this pauses live preview to on-write;
    -- 0 disables
    ---@type integer
    slow_ms = 500,

    -- preview window orientation
    ---@type string | "vertical" | "horizontal"
    split = "vertical",
  },

  -- notify when opening a chezmoi-managed source file (à la chezmoi.nvim)
  ---@type boolean
  notify_on_open = false,

  -- opening a deployed managed file jumps to its chezmoi source (opt-in)
  ---@type boolean
  redirect = false,

  -- surface template errors (via `chezmoi execute-template`) as diagnostics on write
  ---@type chezmoi-template.Config.diagnostics
  diagnostics = {
    -- surface template errors as diagnostics on write
    ---@type boolean
    enabled = true,
  },

  -- blink.cmp source behavior
  ---@type chezmoi-template.Config.completion
  completion = {
    -- hide values of data keys matching these lua patterns in completion docs
    ---@type string[]
    mask = {
      "secret",
      "token",
      "passw",
      "key",
      "api",
    },
  },

  -- :Chezmoi pick source-file picker (a plain string is shorthand for { backend = ... })
  ---a backend-name string is shorthand for { backend = ... }
  ---@type chezmoi-template.Config.picker|string
  picker = {
    -- nil = auto-detect among loaded pickers, falling back to vim.ui.select
    ---@type string | "snacks" | "telescope" | "fzf-lua" | "mini" | "select" | nil
    backend = nil,

    -- entry labels: "target" = deployed names (dot_zshrc.tmpl -> .zshrc), "source" = raw source-relative names
    -- entry labels: "target" (.zshrc) or "source" (dot_zshrc.tmpl)
    -- entry labels: deployed names (.zshrc) or raw source names (dot_zshrc.tmpl)
    ---@type string | "target" | "source"
    display = "target",

    -- lua patterns (vs the source-relative path) hidden on top of the built-in
    -- internals list (picker.DEFAULT_EXCLUDE: .git/, .chezmoi.$FORMAT.tmpl,
    -- .chezmoiversion, .chezmoiroot, .chezmoidata.*); false = show everything
    -- lua patterns hidden on top of the internals list; false = show all
    -- lua patterns (vs the source-relative path) hidden on top of the built-in internals list; false = show everything
    ---@type string | false
    exclude = {
      --it
    },
  },

  -- transparent decrypt/encrypt of chezmoi-managed encrypted files (*.age, *.asc)
  -- via `chezmoi decrypt` / `chezmoi encrypt` (age/rage/builtin/gpg, identities,
  -- recipients all come from chezmoi's own encryption config)
  ---@type chezmoi-template.Config.encryption
  encryption = {
    -- opt-in; delegates to chezmoi decrypt/encrypt
    -- transparent decrypt/encrypt of chezmoi-managed encrypted files (*.age, *.asc)
    ---@type boolean
    enabled = false,

    -- lua patterns for *.age paths to leave untouched
    -- lua patterns (matched on the normalized "/" path) for *.age paths to leave untouched
    -- lua patterns for encrypted paths to leave untouched
    ---@type string[]
    exclude = {
      -- e.g. passphrase-encrypted bootstrap keys
      --"private%-keys",
    },
  },
}

return opts
