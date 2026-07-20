---@type table
local opts = {
  -- TODO: it
}

local readme = {
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
}
--[[
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
]]

return opts
