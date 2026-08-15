---@type CodexNvimConfig
local opts = {
  -- "terminal" or "app_server"
  ---@type CodexNvimBackend | string | "terminal" | "app_server"
  backend = "terminal",

  ---@type string[]
  cmd = require("plugins.codex-nvim.opts.cmd"),

  -- passed to terminal and app-server processes
  ---@type table<string, string>
  env = require("plugins.codex-nvim.opts.env"),

  ---@type CodexNvimCwdPolicy | string | "root" | "file" | "nvim" | fun(ctx: CodexNvimCwdContext): string?
  cwd = function(_ctx)
    return "root"
  end,

  ---@type string[]
  root_markers = require("plugins.codex-nvim.opts.root_markers"),

  -- applies to both backends
  ---@type boolean
  focus_after_send = false,

  ---@type CodexNvimTerminalConfig
  terminal = require("plugins.codex-nvim.opts.terminal"),

  ---@type CodexNvimContextConfig
  context = require("plugins.codex-nvim.opts.context"),

  ---@type { cmd: string[] }
  app_server = require("plugins.codex-nvim.opts.app_server"),
}

return opts
