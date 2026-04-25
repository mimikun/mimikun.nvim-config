-- Text configuration
---@type CordTextConfig
local text = {
  -- Default text for all activities
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  default = nil,

  -- Text for workspace activity
  --[[
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  workspace = function(opts)
    local workspace

    -- Normal
    --workspace = string.format("In %s", opts.workspace)
    workspace = ""
    -- Time-Based Status
    --local hour = tonumber(os.date('%H'))
    --local status =
    --  hour >= 22 and '🌙 Late night coding' or
    --  hour >= 18 and '🌆 Evening session' or
    --  hour >= 12 and '☀️ Afternoon coding' or
    --  hour >= 5 and '🌅 Morning productivity' or
    --  '🌙 Midnight hacking'
    --workspace=string.format('%s: %s', status, opts.filename)

    return workspace
  end,
  ]]

  -- Async Git Branch
  -- use the variable if available, otherwise fallback
  workspace = require("cord.core.async").wrap(function(opts)
    local workspace
    local branch = opts:git_branch():await()
    if branch then
      workspace = string.format("In %s (%s)", opts.workspace, branch)
      return workspace
    end
    workspace = string.format("In %s", opts.workspace)
    return workspace
  end),

  -- Text for viewing activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  viewing = function(opts)
    local viewing

    viewing = string.format("Viewing %s", opts.filename)

    return viewing
  end,

  -- Text for editing activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  editing = function(opts)
    local editing

    -- Normal
    editing = string.format("Editing %s", opts.filename)
    -- Editing with Cursor Position
    --editing = string.format("Editing %s - %s:%s", opts.filename, opts.cursor_line, opts.cursor_char)
    -- Indicate Modified Buffers
    --editing = string.format("Editing %s", opts.filename)
    --if vim.bo.modified then
    --  editing = string.format("%s [+]", editing)
    --end

    return editing
  end,

  -- Text for file browser activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  file_browser = function(opts)
    local file_browser

    file_browser = string.format("Browsing files in %s", opts.name)

    return file_browser
  end,

  -- Text for plugin manager activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  plugin_manager = function(opts)
    local plugin_manager

    plugin_manager = string.format("Managing plugins in %s", opts.name)

    return plugin_manager
  end,

  -- Text for LSP manager activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  lsp = function(opts)
    local lsp

    lsp = string.format("Configuring LSP in ", opts.name)

    return lsp
  end,

  -- Text for documentation activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  docs = function(opts)
    local docs

    docs = string.format("Reading %s", opts.name)

    return docs
  end,

  -- Text for VCS activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  vcs = function(opts)
    local vcs

    vcs = string.format("Committing changes in %s", opts.name)

    return vcs
  end,

  -- Text for notes activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  notes = function(opts)
    local notes

    notes = string.format("Taking notes in %s", opts.name)

    return notes
  end,

  -- Text for debugging-related plugin activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  debug = function(opts)
    local de_bug

    de_bug = string.format("Debugging in %s", opts.name)

    return de_bug
  end,

  -- Text for testing-related plugin activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  test = function(opts)
    local test

    test = string.format("Testing in %s", opts.name)

    return test
  end,

  -- Text for diagnostics activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  diagnostics = function(opts)
    local diagnostics

    diagnostics = string.format("Fixing problems in %s", opts.name)

    return diagnostics
  end,

  -- Text for games activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  games = function(opts)
    local games

    games = string.format("Playing %s", opts.name)

    return games
  end,

  -- Text for terminal activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  terminal = function(opts)
    local terminal

    terminal = string.format("Running commands in %s", opts.name)

    return terminal
  end,

  -- Text for dashboard activity
  ---@type string | fun(opts: CordOpts):string | boolean| nil
  dashboard = function(opts)
    local dashboard

    dashboard = "Home"

    return dashboard
  end,
}

return text
