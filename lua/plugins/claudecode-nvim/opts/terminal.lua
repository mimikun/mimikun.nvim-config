-- Keep a minimal terminal config here instead of requiring claudecode.terminal during config.apply().
-- Loading the terminal module pulls in the server/main module graph and makes coverage-enabled config validation unexpectedly slow.
-- NOTE: Terminal Configuration

---@type ClaudeCodeTerminalConfig
local terminal = {
  -- Terminal split side positioning
  ---@type ClaudeCodeSplitSide | string | "left" | "right"
  split_side = "right",

  -- Optional: shrink (or widen) the terminal while a diff is open.
  -- Defaults to split_width_percentage when unset, preserving today's behavior.
  ---@type number
  split_width_percentage = 0.30,

  -- e.g. 0.20 to give diffs more room
  -- optional terminal width while a diff is active; defaults to split_width_percentage
  ---@type number
  diff_split_width_percentage = nil,

  ---@type ClaudeCodeTerminalProviderName | string | "auto" | "snacks" | "native" | "external" | "none" | ClaudeCodeTerminalProvider | table
  provider = "auto",
  ---@class ClaudeCodeTerminalProvider
  ---@field setup fun(config: ClaudeCodeTerminalConfig)
  ---@field open fun(cmd_string: string, env_table: table, config: ClaudeCodeTerminalConfig, focus: boolean?)
  ---@field close fun()
  ---@field toggle fun(cmd_string: string, env_table: table, effective_config: ClaudeCodeTerminalConfig)
  ---@field simple_toggle fun(cmd_string: string, env_table: table, effective_config: ClaudeCodeTerminalConfig)
  ---@field focus_toggle fun(cmd_string: string, env_table: table, effective_config: ClaudeCodeTerminalConfig)
  ---@field get_active_bufnr fun(): number?
  ---@field is_available fun(): boolean
  ---@field ensure_visible? function
  ---@field _get_terminal_for_test fun(): table?

  ---@type boolean
  auto_close = true,

  -- Auto-enter insert/terminal mode whenever the Claude terminal window gains focus.
  -- Set to false to stay in Normal mode and preserve your scroll position when switching back to the terminal (e.g. via <C-w>l);
  -- press `i` to type.
  -- Note: false also opens the terminal in Normal mode (it gates start-insert too).
  -- auto-enter insert/terminal mode when the Claude terminal gains focus (#232);
  -- false keeps Normal mode + scroll position
  ---@type boolean
  auto_insert = true,

  -- Opts to pass to `Snacks.terminal.open()`
  -- see Floating Window section below
  -- Centered Floating Window with Custom Styling
  ---@type snacks.win.Config
  snacks_win_opts = {
    position = "float",
    width = 0.6,
    height = 0.6,
    border = "double",
    backdrop = 80,
    keys = {
      claude_hide = {
        "<Esc>",
        function(self)
          self:hide()
        end,
        mode = "t",
        desc = "Hide",
      },
      claude_close = {
        "q",
        "close",
        mode = "n",
        desc = "Close",
      },
    },
  },

  -- Work around a Neovim core bug (< 0.12.2) that fragments large pastes into the terminal, making Cmd+V appear to truncate ([#161]).
  -- true | false | "auto" ("auto", the default, enables it only on affected Neovim versions).
  -- work around Neovim <0.12.2 terminal paste fragmentation (#161);
  -- "auto" (default) enables only on affected versions
  ---@type boolean | "auto" | nil
  fix_streamed_paste = "auto",

  -- Provider-specific options
  ---@type ClaudeCodeTerminalProviderOptions
  provider_opts = {
    -- Command for external terminal provider.
    -- Can be:
    -- 1. String with %s placeholder: "alacritty -e %s" (backward compatible)
    -- 2. String with two %s placeholders: "alacritty --working-directory %s -e %s" (cwd, command)
    -- 3. Function returning command: function(cmd, env) return "alacritty -e " .. cmd end
    ---@type fun(cmd: string, env: table): string | string | table | nil
    external_terminal_cmd = function(_cmd, _env)
      return nil
    end,
  },

  ---@type boolean
  --show_native_term_exit_tip
  ---@type string
  --terminal_cmd
  ---@type table<string, string>
  --env
  -- static working directory for Claude terminal
  ---@type string | nil
  --cwd
  -- use git root of current file/cwd as working directory
  ---@type boolean | nil
  --git_repo_cwd
  -- custom function to compute working directory
  ---@type ClaudeCodeCwdProvider
  --cwd_provider
  ---@alias ClaudeCodeCwdProvider fun(ctx: ClaudeCodeCwdContext): string | nil
  -- Working directory resolution context and provider
  ---@class ClaudeCodeCwdContext
  -- absolute path of current buffer file (if any)
  ---@type string | nil
  --file
  -- directory of current buffer file (if any)
  ---@type string | nil
  --file_dir
  -- current Neovim working directory
  ---@type string
  --cwd
}

return terminal
