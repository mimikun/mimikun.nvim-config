---@type table
local opts = {
  -- kubectl command timeout in milliseconds (default: 30000)
  timeout = 30000,
  -- Default namespace (default: "default")
  default_namespace = "default",
  -- Default resource kind (default: "Pod")
  default_kind = "Pod",
  -- Transparent window background (default: false)
  transparent = false,
  -- Debug container image for kubectl debug (default: "busybox")
  debug_image = "busybox",
  -- Custom keymaps (optional, organized by view type)
  keymaps = {
    -- Global keymaps (shared across all views)
    global = {
      quit = { key = "q", desc = "Hide" },
      close = { key = "<C-c>", desc = "Close" },
      back = { key = "<C-h>", desc = "Back" },
      forward = { key = "<C-l>", desc = "Forward" },
      help = { key = "?", desc = "Help" },
    },
    -- Pod list view
    pod_list = {
      describe = { key = "K", desc = "Describe" },
    },
    -- Deployment list view
    deployment_list = {
      scale = { key = "S", desc = "Scale" },
    },
    -- Secret describe view keymaps
    secret_describe = {
      toggle_secret = { key = "S", desc = "ToggleSecret" },
    },
    -- Port forward list keymaps
    port_forward_list = {
      stop = { key = "D", desc = "Stop" },
    },
  },
}

return opts
