local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.maplocalleader = "\\"

require("lazy").setup({
  root = vim.fn.stdpath("data") .. "/lazy",
  defaults = {
    lazy = true,
  },
  spec = {
    { import = "plugins" },
    { import = "colorschemes" },
  },
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  ---@type number? limit the maximum amount of concurrent tasks
  concurrency = jit.os:find("Windows") and (vim.uv.available_parallelism() * 2) or nil,
  git = {
    -- rate of network related git operations (clone, fetch, checkout)
    throttle = {
      enabled = false, -- not enabled by default
      -- max 2 ops every 5 seconds
      rate = 2,
      duration = 5 * 1000, -- in ms
    },
    -- Time in seconds to wait before running fetch again for a plugin.
    -- Repeated update/check operations will not run again until this
    -- cooldown period has passed.
    cooldown = 0,
  },
  pkg = {
    cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
  },
  rocks = {
    root = vim.fn.stdpath("data") .. "/lazy-rocks",
  },
  dev = {
    path = "~/projects",
    fallback = false,
  },
  install = {
    colorscheme = { "habamax" },
  },
  ui = {
    border = "none",
    -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
    backdrop = 60,
    ---@type string "center" | "left" | "right"
    title_pos = "center",
    icons = {
      cmd = " ",
      config = "",
      debug = "● ",
      event = " ",
      favorite = " ",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      require = "󰢱 ",
      source = " ",
      start = " ",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
    -- how frequently should the ui process render events
    throttle = 1000 / 30,
  },
  diff = {
    ---@type string "browser" | "git" | "terminal_git" | "diffview.nvim"
    cmd = "git",
  },
  checker = {
    enabled = false,
    ---@type number? set to 1 to check for updates very slowly
    concurrency = nil,
    frequency = 3600, -- check for updates every hour
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  readme = {
    root = vim.fn.stdpath("state") .. "/lazy/readme",
  },
  state = vim.fn.stdpath("state") .. "/lazy/state.json",
  profiling = {
    loader = true,
    require = true,
  },
})
