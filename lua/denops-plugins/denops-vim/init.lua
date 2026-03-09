---@type LazySpec
local spec = {
  "vim-denops/denops.vim",
  lazy = false,
  cmd = require("denops-plugins.denops-vim.cmds"),
  --keys = require("denops-plugins.denops-vim.keys"),
  --opts = require("denops-plugins.denops-vim.opts"),
  config = function()
    --- KEYBINDS
    -- Interrupt the process of plugins via <C-c>
    vim.keymap.set({ "n", "v", "x", "s", "o" }, "<C-c>", "<Cmd>call denops#interrupt()<CR><C-c>", { silent = true })
    vim.keymap.set("i", "<C-c>", "<Cmd>call denops#interrupt()<CR><C-c>", { silent = true })
    vim.keymap.set("c", "<C-c>", "<Cmd>call denops#interrupt()<CR><C-c>", { silent = true })

    --- USER COMMANDS
    -- Start Denops server
    vim.api.nvim_create_user_command("DenopsStart", function()
      vim.fn["denops#server#start"]()
    end, {})

    -- Stop Denops server
    vim.api.nvim_create_user_command("DenopsStop", function()
      vim.fn["denops#server#stop"]()
    end, {})

    -- Check status Denops server
    -- Status  Description
    -- "stopped"   Server is stopped.
    -- "starting"  Server is starting.
    -- "preparing" Server is preparing (initializing).
    -- "running"   Server is running (ready).
    -- "closing"   Server is closing (disconnecting).
    -- "closed"    Server is closed (disconnected but server is running).
    vim.api.nvim_create_user_command("DenopsStatus", function()
      vim.fn["denops#server#status"]()
    end, {})

    -- Restart Denops server
    vim.api.nvim_create_user_command("DenopsRestart", function()
      vim.fn["denops#server#restart"]()
    end, {})

    -- Fix Deno module cache issue
    vim.api.nvim_create_user_command("DenopsFixCache", function()
      vim.fn["denops#cache#update"]({ reload = true })
    end, {})

    --- VARIABLES
    -- Disables version check on startup.
    -- Use it to forcibly enable denops on unsupported versions of Vim/Neovim.
    -- Do not report any errors/issues on non-supported versions.
    -- Default: 0
    vim.g.denops_disable_version_check = 0

    -- Global denops server address in "{hostname}:{port}" format.
    -- If the value is not specified or invalid, denops starts a local denops server for each Vim/Neovim instance.
    -- Default: 0
    vim.g.denops_server_addr = "127.0.0.1:32123"

    -- Set to 1 to disable denops.
    -- Default: 0
    vim.g["denops#disabled"] = 0

    -- Executable program of Deno.
    -- Use it to specify the executable program of Deno if "deno" is not in PATH.
    -- Default: "deno"
    vim.g["denops#deno"] = "deno"

    -- Cache directory of Deno.
    -- If unspecified, the cache directory is determined by the DENO_DIR environment variable or internally by "deno".
    -- Default: v:null
    vim.g["denops#deno_dir"] = vim.NIL

    -- Set to 1 to enable debug mode.
    -- In debug mode, additional debug messages of denops itself will be shown.
    -- This variable must be configured prior to denops initialization.
    -- Default: 0
    vim.g["denops#debug"] = 0

    -- Set to 1 to disable deprecation warning messages.
    -- Default: 0
    vim.g["denops#disable_deprecation_warning_message"] = 0

    -- Executable program of Deno for starting a server.
    -- Default: g:denops#deno
    vim.g["denops#server#deno"] = vim.g["denops#deno"]

    -- Program arguments of Deno for starting a server.
    -- Default: ['-q', '--no-lock', '-A']
    vim.g["denops#server#deno_args"] = { "-q", "--no-lock", "-A" }

    -- The delay in milliseconds before restarting the server.
    -- This avoid #136. https://github.com/vim-denops/denops.vim/issues/136
    -- Default: 100
    vim.g["denops#server#restart_delay"] = 100

    -- Interval in milliseconds to avoid infinite errors.
    -- Denops will reset internal counter when the process keeps running more than this interval.
    -- Default: 10000
    vim.g["denops#server#restart_interval"] = 10000

    -- The number of restart counts on unexpected process termination within g:denops#server#restart_interval.
    -- Default: 3
    vim.g["denops#server#restart_threshold"] = 3

    -- The delay in milliseconds before reconnecting to the server.
    -- Default: 100
    vim.g["denops#server#reconnect_delay"] = 100

    -- Interval in milliseconds to avoid infinite errors.
    -- Denops will reset internal counter when the channel keeps connecting more than this interval.
    -- Default: 1000
    vim.g["denops#server#reconnect_interval"] = 1000

    -- The number of reconnect counts on connection failure within g:denops#server#reconnect_interval.
    -- Default: 3
    vim.g["denops#server#reconnect_threshold"] = 3

    -- Timeout in milliseconds to wait for the channel to close gracefully.
    -- If the timeout expires, the channel will be forcibly closed.
    -- Default: 5000
    vim.g["denops#server#close_timeout"] = 5000

    -- Interval in milliseconds for denops#server#wait().
    -- Default: 10
    vim.g["denops#server#wait_interval"] = 10

    -- Timeout in milliseconds for denops#server#wait().
    -- Default: 30000
    vim.g["denops#server#wait_timeout"] = 30000

    -- Interval in milliseconds for denops#plugin#wait().
    -- Default: 10
    vim.g["denops#plugin#wait_interval"] = 10

    -- Timeout in milliseconds for denops#plugin#wait().
    -- Default: 30000
    vim.g["denops#plugin#wait_timeout"] = 30000
  end,
  --cond = false,
  --enabled = false,
}

return spec
