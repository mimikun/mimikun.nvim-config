-- GitHub star watcher.
-- Off by default:
-- the plugin will not reach out to the network on its own unless you enable this.
-- Requires `gh` authenticated.
local stars = {
  -- Start watching when Neovim opens
  enabled = false,

  ---@type string | "owner" | "contributor" | "all"
  scope = "owner",

  -- Seconds between checks (minimum 30)
  interval = 120,

  -- Accounts to watch;
  -- empty = whoever `gh` is logged in as
  owners = {},

  -- Accent colour: border, title and star
  color = "#E3B341",

  -- Custom title text;
  -- nil uses the translated one
  title = nil,

  -- Sound name, or false to notify silently
  sound = "achievement",
}

return stars
