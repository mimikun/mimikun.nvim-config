---@type table
local opts = {
  -- Interface language: "en" (English) or "it" (Italian)
  ---@type string | "en" | "it"
  language = "en",

  -- Folders or Directories to automatically scan: { path, search_depth }
  roots = require("plugins.projecthub-nvim.opts.roots"),

  -- Standalone project directories
  extra = require("plugins.projecthub-nvim.opts.extra"),

  -- Your GitHub/GitLab usernames (for owner badge & author filtering)
  me = require("plugins.projecthub-nvim.opts.me"),

  -- Custom icons (Nerd Font unicode characters)
  icons = require("plugins.projecthub-nvim.opts.icons"),

  bots = require("plugins.projecthub-nvim.opts.bots"),

  -- Window layout and responsive split
  window = require("plugins.projecthub-nvim.opts.window"),

  -- Sound effects (bundled out-of-the-box, zero external downloads needed)
  -- UI Sound Effects (uisfx minimal preset)
  sound = require("plugins.projecthub-nvim.opts.sound"),

  github = require("plugins.projecthub-nvim.opts.github"),

  -- GitHub star watcher.
  -- Off by default:
  -- the plugin will not reach out to the network on its own unless you enable this.
  -- Requires `gh` authenticated.
  stars = require("plugins.projecthub-nvim.opts.stars"),

  -- Incoming commits.
  -- The history always shows your local repository;
  -- when upstream has newer commits a background `git fetch` picks them up and the inspector lists them above a divider, separated from the point you are synced at.
  -- The fetch only updates remote refs: HEAD, the index and the working tree are never touched.
  incoming = require("plugins.projecthub-nvim.opts.incoming"),

  -- How often to re-read git for projects you are not looking at.
  -- A project untouched for months does not change while the dashboard is open, and re-reading it every thirty seconds alongside the rest was most of the work the plugin did for nothing.
  -- Age is measured on the most recent of: anyone's last commit (including a collaborator's, even while it still sits on the remote branch) and the last file change.

  -- Whatever the band, these stay immediate:
  -- the selected project (every 5s - it is the one you are reading), returning to the window, and saving a file.
  polling = require("plugins.projecthub-nvim.opts.polling"),

  -- Custom open callback.
  -- If nil, defaults to: changing cwd (`cd`), opening README.md in main buffer, and opening Neo-tree.
  on_open = nil,
}

return opts
