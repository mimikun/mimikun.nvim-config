---@type sidekick.Config
local opts = {
  nes = {
    ---@type boolean|fun(buf:integer):boolean?
    enabled = function(buf)
      return vim.g.sidekick_nes ~= false and vim.b.sidekick_nes ~= false
    end,
    debounce = 100,
    trigger = {
      -- events that trigger sidekick next edit suggestions
      events = {
        "ModeChanged i:n",
        "TextChanged",
        "User SidekickNesDone",
      },
    },
    clear = {
      -- events that clear the current next edit suggestion
      events = {
        "TextChangedI",
        "InsertEnter",
      },
      -- clear next edit suggestions when pressing <Esc>
      esc = true,
    },
    ---@type sidekick.diff.Opts
    diff = {
      -- Enable inline diffs
      ---@type string | "words" | "chars" | false
      inline = "words",

      -- `cursor` will only show the diff when the cursor is at the edit position.
      ---@type string | "always" | "cursor"
      show = "always",
    },
    -- show signs for next edit suggestions
    signs = true,
    -- add an entry to the jumplist
    jumplist = true,
  },
  -- Work with AI cli tools directly from within Neovim
  cli = {
    -- notify Neovim of file changes done by AI CLI tools
    watch = true,
    ---@type sidekick.win.Opts
    win = {
      -- This is run when a new terminal is created, before starting it.
      -- Here you can change window options `terminal.opts`.
      ---@param terminal sidekick.cli.Terminal
      config = function(terminal)
        -- NOTE: it
      end,
      ---@type vim.wo
      wo = {},
      ---@type vim.bo
      bo = {},
      ---@type string | "float" | "left" | "bottom" | "top" | "right"
      layout = "right",
      --- Options used when layout is "float"
      ---@type vim.api.keyset.win_config
      float = {
        width = 0.9,
        height = 0.9,
      },
      -- Options used when layout is "left"|"bottom"|"top"|"right"
      ---@type vim.api.keyset.win_config
      split = {
        -- set to 0 for default split width
        width = 80,
        -- set to 0 for default split height
        height = 20,
      },
      -- CLI Tool Keymaps (default mode is `t`)
      ---@type table<string, sidekick.cli.Keymap|false>
      keys = {
        buffers = {
          "<c-b>",
          "buffers",
          mode = "nt",
          desc = "open buffer picker",
        },
        files = {
          "<c-f>",
          "files",
          mode = "nt",
          desc = "open file picker",
        },
        hide_n = {
          "q",
          "hide",
          mode = "n",
          desc = "hide the terminal window",
        },
        hide_ctrl_q = {
          "<c-q>",
          "hide",
          mode = "n",
          desc = "hide the terminal window",
        },
        hide_ctrl_dot = {
          "<c-.>",
          "hide",
          mode = "nt",
          desc = "hide the terminal window",
        },
        hide_ctrl_z = {
          "<c-z>",
          "blur",
          mode = "nt",
          desc = "go back to the previous window without hiding the terminal",
        },
        prompt = {
          "<c-p>",
          "prompt",
          mode = "t",
          desc = "insert prompt or context",
        },
        stopinsert = {
          "<c-q>",
          "stopinsert",
          mode = "t",
          desc = "enter normal mode",
        },
        -- Navigate windows in terminal mode.
        -- Only active when:
        -- * layout is not "float"
        -- * there is another window in the direction
        -- With the default layout of "right", only `<c-h>` will be mapped
        nav_left = {
          "<c-h>",
          "nav_left",
          expr = true,
          desc = "navigate to the left window",
        },
        nav_down = {
          "<c-j>",
          "nav_down",
          expr = true,
          desc = "navigate to the below window",
        },
        nav_up = {
          "<c-k>",
          "nav_up",
          expr = true,
          desc = "navigate to the above window",
        },
        nav_right = {
          "<c-l>",
          "nav_right",
          expr = true,
          desc = "navigate to the right window",
        },
      },
      -- Function that handles navigation between windows.
      -- Defaults to `vim.cmd.wincmd`.
      -- Used by the `nav_*` keymaps.
      ---@type fun(dir:"h"|"j"|"k"|"l")?
      nav = function(dir)
        return nil
      end,
    },
    ---@type sidekick.cli.Mux
    mux = {
      -- default to tmux unless zellij is detected
      -- Multiplexer backend to persist CLI sessions
      ---@type string | "tmux" | "zellij"
      backend = vim.env.ZELLIJ and "zellij" or "tmux",
      enabled = false,
      -- terminal: new sessions will be created for each CLI tool and shown in a Neovim terminal
      -- window: when run inside a terminal multiplexer, new sessions will be created in a new tab
      -- split: when run inside a terminal multiplexer, new sessions will be created in a new split
      -- NOTE: zellij only supports `terminal`

      ---@type string | "terminal" | "window" | "split"
      create = "terminal",
      split = {
        -- vertical or horizontal split
        vertical = true,
        -- size of the split (0-1 for percentage)
        size = 0.5,
      },
    },
    --- Actual cli tool config is loaded from the runtime path `sk/cli/{tool}.lua` and merged with the config below.
    --- For default configs, see https://github.com/folke/sidekick.nvim/tree/main/sk/cli
    ---@type table<string, sidekick.cli.Config|{}>
    tools = {
      aider = {},
      amazon_q = {},
      claude = {},
      codex = {},
      copilot = {},
      crush = {},
      cursor = {},
      gemini = {},
      grok = {},
      opencode = {},
      pi = {},
      qwen = {},
    },
    --- Add custom context. See `lua/sidekick/context/init.lua`
    ---@type table<string, sidekick.context.Fn>
    context = {},
    ---@type table<string, sidekick.Prompt|string|fun(ctx:sidekick.context.ctx):(string?)>
    prompts = {
      changes = "Can you review my changes?",
      diagnostics = "Can you help me fix the diagnostics in {file}?\n{diagnostics}",
      diagnostics_all = "Can you help me fix these diagnostics?\n{diagnostics_all}",
      document = "Add documentation to {function|line}",
      explain = "Explain {this}",
      fix = "Can you fix {this}?",
      optimize = "How can {this} be optimized?",
      review = "Can you review {file} for any issues or improvements?",
      tests = "Can you write tests for {this}?",
      -- simple context prompts
      buffers = "{buffers}",
      file = "{file}",
      line = "{line}",
      position = "{position}",
      quickfix = "{quickfix}",
      selection = "{selection}",
      ["function"] = "{function}",
      class = "{class}",
    },
    -- preferred picker for selecting files
    ---@alias sidekick.picker "snacks" | "telescope" | "fzf-lua"
    ---@type sidekick.picker | "snacks" | "telescope" | "fzf-lua"
    picker = "snacks",
  },
  copilot = {
    -- track copilot's status with `didChangeStatus`
    status = {
      enabled = true,
      level = vim.log.levels.WARN,
      -- set to vim.log.levels.OFF to disable notifications
      --level = vim.log.levels.OFF,
    },
  },
  ui = {
    icons = {
      nes = " ",
      attached = " ",
      started = " ",
      installed = " ",
      missing = " ",
      external_attached = "󰖩 ",
      external_started = "󰖪 ",
      terminal_attached = " ",
      terminal_started = " ",
    },
  },
  -- enable debug logging
  debug = false,
}

return opts
