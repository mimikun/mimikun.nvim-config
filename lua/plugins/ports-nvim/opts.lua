---@type ports.Config
local opts = {
  -- Stale dev-server detection.
  -- Each enabled rule annotates matching dev servers with a human-readable reason shown in the UI.
  stale = {
    enabled = true,
    -- working directory no longer exists
    -- Flag dev servers whose working directory no longer exists on disk.
    orphaned = true,

    -- another server in the same project directory
    -- Flag multiple dev servers running from the same project directory.
    duplicates = true,

    -- flag servers older than N seconds (0 = off)
    -- Flag dev servers running longer than this many seconds. 0 disables.
    max_age = 0,
  },

  --- Which listeners to display.
  scan = {
    -- 127.0.0.1 / ::1
    include_loopback = true,

    -- 0.0.0.0 / *
    include_any = true,

    -- bound to a specific external interface
    include_external = true,
  },

  browser = {
    -- nil → use `vim.ui.open` (cross-platform).
    -- A string is run as `{cmd, url}`.
    -- A function receives the URL and is fully responsible.
    ---@type string | fun(url: string) | nil
    cmd = nil,
    scheme = "http",
    host = "localhost",
  },

  ui = {
    border = "rounded",
    -- Fractions of the editor (0–1) or absolute columns/rows (>1).
    width = 0.82,

    height = 0.6,

    -- Use Nerd Font glyphs for the type column.
    icons = true,

    -- Auto-refresh interval in ms while the window is open.
    -- 0 disables.
    auto_refresh = 0,
  },

  -- Send SIGTERM first;
  -- the UI offers an escalation to SIGKILL.
  kill = {
    signal = "TERM",
    confirm = true,
  },

  ---@type table<string, string | false>
  keymaps = {
    -- open in browser
    open = "o",

    -- terminate process (SIGTERM)
    kill = "K",

    -- terminate process (SIGKILL)
    force_kill = "X",

    -- tail logs
    logs = "L",

    -- show full details for the entry
    info = "i",

    -- copy the URL to the clipboard
    yank = "y",

    -- rescan
    refresh = "r",

    -- toggle stale-only filter
    stale = "s",

    -- toggle the keymap legend
    help = "?",

    -- close the window
    quit = "q",
  },
}

return opts
