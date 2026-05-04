---@type string | "npm" | "yarn" | "pnpm" | "bun"
local package_manager = "pnpm"

---@type table
local opts = {
  -- Check `:help nvim_set_hl()` for more attributes.
  highlights = {
    -- highlight for up to date dependency virtual text
    up_to_date = {
      fg = "#3C4048",
    },
    -- highlight for outdated dependency virtual text
    outdated = {
      fg = "#d19a66",
    },
    -- highlight for invalid dependency virtual text
    invalid = {
      fg = "#ee4b2b",
    },
  },
  icons = {
    -- Whether to display icons
    enable = true,
    style = {
      -- Icon for up to date dependencies
      up_to_date = "|  ",
      -- Icon for outdated dependencies
      outdated = "|  ",
      -- Icon for invalid dependencies
      invalid = "|  ",
    },
  },
  -- Whether to display notifications when running commands
  notifications = true,
  -- Whether to autostart when `package.json` is opened
  autostart = true,
  -- It hides up to date versions when displaying virtual text
  hide_up_to_date = false,
  -- It hides unstable versions from version list e.g next-11.1.3-canary3
  hide_unstable_versions = false,
  -- Can be `npm`, `yarn`, `pnpm` or `bun`.
  -- Used for `delete`, `install` etc...
  -- The plugin will try to auto-detect the package manager based on `yarn.lock`, `package-lock.json` or `bun.lock`.
  -- If none are found it will use the provided one, if nothing is provided it will use `npm`
  ---@type string | "npm" | "yarn" | "pnpm" | "bun"
  package_manager = package_manager,
}

return opts
