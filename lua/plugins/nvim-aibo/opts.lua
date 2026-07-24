---@type table
local opts = {
  -- TODO: it
}
local basic = {
  submit_delay = 500, -- Delay in milliseconds (default: 500)
  submit_key = "<CR>", -- Key to send after submit (default: '<CR>')
  prompt_height = 10, -- Prompt window height (default: 10)
  prompt_blend_insert = 10, -- Prompt transparency in Insert mode 0-100 (default: 10)
  prompt_blend_normal = 30, -- Prompt transparency in Normal mode 0-100 (default: 30)
  -- prompt_blend = 20,       -- DEPRECATED: Use prompt_blend_insert/normal instead
  termcode_mode = "hybrid", -- Terminal escape sequence mode: 'hybrid', 'xterm', or 'csi-n' (default: 'hybrid')
  disable_startinsert_on_startup = false, -- Disable auto insert in prompt window when first opened (default: false)
  disable_startinsert_on_insert = false, -- Disable auto insert in prompt when entering insert from console (default: false)
}

local advanced = {
  -- Prompt buffer configuration
  prompt = {
    no_default_mappings = false, -- Set to true to disable default keymaps
    on_attach = function(bufnr, info)
      -- Custom setup for prompt buffers
      -- Runs AFTER ftplugin files
      -- info.type = "prompt"
      -- info.tool = tool name (e.g., "claude")
      -- info.aibo = aibo instance
    end,
  },

  -- Console buffer configuration
  console = {
    no_default_mappings = false,
    on_attach = function(bufnr, info)
      -- Custom setup for console buffers
      -- info.type = "console"
      -- info.cmd = command being executed
      -- info.args = command arguments
      -- info.job_id = terminal job ID
    end,
  },

  -- Tool-specific overrides, keyed by the tool name aibo dispatches on (the
  -- first word of the invoked command, e.g. "claude", "codex", "gemini", or
  -- a custom wrapper like "ollama" for `:Aibo ollama launch claude ...`).
  tools = {
    claude = {
      no_default_mappings = false,
      on_attach = function(bufnr, info)
        -- Custom setup for Claude buffers
        -- Called after prompt/console on_attach
      end,

      -- Live "/" completion: probes `claude` directly (does not speak ACP
      -- itself), no adapter, no Node.js, no npm. On by default -- there is
      -- no static fallback, so setting this to `false` means no "/"
      -- completion at all for this tool.
      completion = {
        claude = true,
        -- claude = { cmd = { "claude" }, timeout = 10000 },
        -- claude = false,
      },
    },
    codex = {
      -- Live "/" completion: probes `codex app-server` directly (does not
      -- speak ACP itself). On by default, same reasoning as Claude.
      completion = {
        codex = true,
        -- codex = { cmd = { "codex" }, timeout = 10000 },
        -- codex = false,
      },
    },
    gemini = {
      -- Gemini CLI speaks the Agent Client Protocol (ACP) natively, so its
      -- live "/" completion goes through the generic ACP client
      -- (`completion/acp.lua`) instead of a tool-specific protocol -- the
      -- source key is "acp", not "gemini". On by default, same reasoning.
      completion = {
        acp = true,
        -- acp = { cmd = { "gemini", "--acp" }, timeout = 10000 },
        -- acp = false,
      },
    },
    -- A custom tool profile can opt into any completion module, not just
    -- the one matching its own name -- e.g. a wrapper that launches a
    -- claude-flavored model can reuse Claude's probe:
    -- ["my-ollama-wrapper"] = {
    --   completion = { claude = true },
    -- },
  },

  -- Live "/" completion sources, one key per tool. Each source probes the
  -- agent's own live command/skill list -- no static table, no disk scan --
  -- so it needs no manual updates and can't drift out of sync. No prompt is
  -- ever sent, so it consumes no tokens.
  completion = {
    -- Claude does not speak ACP itself; probes `claude` directly. Needs
    -- nothing beyond a logged-in `claude` already on PATH -- no adapter,
    -- no Node.js, no npm. On by default: there is no static fallback, so
    -- setting this to `false` means no "/" completion at all for Claude.
    claude = true,
    -- claude = {
    --   cmd = { "claude" }, -- command to probe, looked up on PATH
    --   timeout = 10000,    -- probe timeout (ms)
    -- },
    -- claude = false,      -- disable "/" completion for Claude entirely

    -- Codex does not speak ACP itself; probes `codex app-server` directly.
    -- Needs nothing beyond `codex` already on PATH. On by default: there is
    -- no static fallback, so `false` means no "/" completion for Codex.
    codex = true,
    -- codex = {
    --   cmd = { "codex" },
    --   timeout = 10000,
    -- },
    -- codex = false,       -- disable "/" completion for Codex entirely

    -- Generic Agent Client Protocol (ACP) client, for agents that speak ACP
    -- natively. Currently used by Gemini CLI (`gemini --acp`). On by
    -- default: same reasoning as Claude/Codex -- no static fallback.
    acp = true,
    -- acp = {
    --   cmd = { "gemini", "--acp" },
    --   timeout = 10000,
    -- },
    -- acp = false,         -- disable "/" completion for Gemini entirely
  },
}

return opts
