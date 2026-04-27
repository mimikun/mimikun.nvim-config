local picker
picker = {
  "buffer",
  opts = {
    -- Enable hotkeys for quick selection of actions
    hotkeys = true,
    hotkeys_mode = function(titles, used_hotkeys)
      --local t = {}
      --for i = 1, #titles do t[i] = tostring(i) end
      --return t
      -- Modes for generating hotkeys
      return "text_diff_based"
    end,
    -- Enable or disable automatic preview
    auto_preview = false,
    -- Automatically accept the selected action (with hotkeys)
    auto_accept = false,
    -- Position of the picker window
    position = "cursor",
    -- Border style for picker and preview windows
    winborder = "single",
    keymaps = {
      -- Key to show preview
      preview = "K",
      -- Keys to close the window (can be string or table)
      close = {
        "q",
        "<Esc>",
      },
      -- Keys to select action (can be string or table)
      select = "<CR>",
      -- Keys to return from preview to main window (can be string or table)
      preview_close = {
        "q",
        "<Esc>",
      },
    },
    custom_keys = {
      {
        key = "m",
        pattern = "Fill match arms",
      },
      {
        key = "m",
        pattern = "Consider making this binding mutable: mut",
      },
      -- Lua pattern matching
      {
        key = "r",
        pattern = "Rename.*",
      },
      {
        key = "e",
        pattern = "Extract Method",
      },
    },
    group_icon = " └",
  },
}

picker = "telescope"

---@type table
local opts = {
  --- The backend to use, currently only "vim", "delta", "difftastic", "diffsofancy" are supported
  backend = "vim",

  -- The picker to use, "telescope", "snacks", "select", "buffer", "fzf-lua" are supported
  -- And it's opts that will be passed at the picker's creation, optional
  -- You can also set `picker = "<picker>"` without any opts.
  picker = picker,
  backend_opts = {
    delta = {
      -- Header from delta can be quite large.
      -- You can remove them by setting this to the number of lines to remove
      header_lines_to_remove = 4,

      -- The arguments to pass to delta
      -- If you have a custom configuration file, you can set the path to it like so:
      args = {
        "--line-numbers",
        --"--config" .. os.getenv("HOME") .. "/.config/delta/config.yml",
      },
    },
    difftastic = {
      header_lines_to_remove = 1,

      -- The arguments to pass to difftastic
      args = {
        "--color=always",
        "--display=inline",
        "--syntax-highlight=on",
      },
    },
    diffsofancy = {
      header_lines_to_remove = 4,
    },
  },

  -- Timeout in milliseconds to resolve code actions
  resolve_timeout = 100,

  -- Notification settings
  notify = {
    -- Enable/disable all notifications
    enabled = true,

    -- Show notification when no code actions are found
    on_empty = true,
  },

  -- Customize how action titles are displayed in the picker
  -- Function receives (action, client) and returns a formatted string
  -- Default: action.title
  format_title = function(action, client)
    --if action.kind then
    --  return string.format("%s (%s)", action.title, action.kind)
    --end
    --return action.title
    return nil
  end,

  -- The icons to use for the code actions
  -- You can add your own icons, you just need to set the exact action's kind of the code action
  -- You can set the highlight like so: { link = "DiagnosticError" } or  like nvim_set_hl ({ fg ..., bg..., bold..., ...})
  signs = {
    quickfix = {
      "",
      {
        link = "DiagnosticWarning",
      },
    },
    others = {
      "",
      {
        link = "DiagnosticWarning",
      },
    },
    refactor = {
      "",
      {
        link = "DiagnosticInfo",
      },
    },
    ["refactor.move"] = {
      "󰪹",
      {
        link = "DiagnosticInfo",
      },
    },
    ["refactor.extract"] = {
      "",
      {
        link = "DiagnosticError",
      },
    },
    ["source.organizeImports"] = {
      "",
      {
        link = "DiagnosticWarning",
      },
    },
    ["source.fixAll"] = {
      "󰃢",
      {
        link = "DiagnosticError",
      },
    },
    ["source"] = {
      "",
      {
        link = "DiagnosticError",
      },
    },
    ["rename"] = {
      "󰑕",
      {
        link = "DiagnosticWarning",
      },
    },
    ["codeAction"] = {
      "",
      {
        link = "DiagnosticWarning",
      },
    },
  },
  filter = function(action, client)
    local client_name = client.name
    local kind = action.kind
    local title = action.title
    vim.print(client_name, kind, title)
  end,
  sort = function(a, b)
    -- NOTE: Example: Prioritize Specific Action Types
    -- Prioritize quickfix actions, then refactoring, then everything else
    --local function get_priority(kind)
    --  if string.match(kind or "", "^quickfix") then
    --    return 1
    --  end
    --  if string.match(kind or "", "^refactor") then
    --    return 2
    --  end
    --  return 3
    --end

    --local a_priority = get_priority(a.action.kind)
    --local b_priority = get_priority(b.action.kind)
    --return a_priority < b_priority

    -- NOTE: default sort order
    -- Prioritize actions from rust_analyzer

    if a.client.name == "rust_analyzer" and b.client.name ~= "rust_analyzer" then
      return true
    elseif a.client.name ~= "rust_analyzer" and b.client.name == "rust_analyzer" then
      return false
    end

    -- Sort by action kind alphabetically
    local a_kind = a.action.kind or ""
    local b_kind = b.action.kind or ""

    return a_kind < b_kind

    -- NOTE: Per-Call Sorting
    -- Prioritize "Disable" actions
    --local a_is_disable = string.match(a.action.title, "Disable") ~= nil
    --local b_is_disable = string.match(b.action.title, "Disable") ~= nil

    --if a_is_disable and not b_is_disable then
    --  return true
    --elseif not a_is_disable and b_is_disable then
    --  return false
    --end

    --return false
  end,
}

return opts
