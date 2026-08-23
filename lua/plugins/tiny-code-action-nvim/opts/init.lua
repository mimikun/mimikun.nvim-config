---@type table
local opts = {
  ---@type string | "vim" | "delta" | "difftastic" | "diffsofancy"
  backend = "vim",

  ---@type string | "telescope" | "snacks" | "select" | "buffer" | "fzf-lua" | table | nil
  picker = require("plugins.tiny-code-action-nvim.opts.picker"),

  -- Customize how action titles are displayed in the picker
  -- Function receives (action, client) and returns a formatted string
  -- action.title: The action's title text
  -- action.kind: The LSP CodeActionKind (e.g., "quickfix", "refactor.extract")
  -- action.isPreferred: Boolean indicating if the action is preferred
  -- client.name: The name of the LSP client providing the action
  format_title = function(action, client)
    if action.kind then
      return string.format("%s (%s)", action.title, action.kind)
    end
    return action.title
  end,

  backend_opts = require("plugins.tiny-code-action-nvim.opts.backend_opts"),

  -- Timeout in milliseconds to resolve code actions
  resolve_timeout = 100,

  sort = function(a, b)
    -- Global Configuration
    --[[
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
    ]]

    -- Per-Call Sorting
    --[[
    -- Prioritize "Disable" actions
    local a_is_disable = string.match(a.action.title, "Disable") ~= nil
    local b_is_disable = string.match(b.action.title, "Disable") ~= nil

    if a_is_disable and not b_is_disable then
      return true
    elseif not a_is_disable and b_is_disable then
      return false
    end

    return false
    ]]
    -- Prioritize quickfix actions, then refactoring, then everything else
    --[[
    local function get_priority(kind)
      if string.match(kind or "", "^quickfix") then return 1 end
      if string.match(kind or "", "^refactor") then return 2 end
      return 3
    end

    local a_priority = get_priority(a.action.kind)
    local b_priority = get_priority(b.action.kind)

    return a_priority < b_priority
    ]]
  end,

  -- Notification settings
  notify = require("plugins.tiny-code-action-nvim.opts.notify"),

  -- The icons to use for the code actions
  -- You can add your own icons, you just need to set the exact action's kind of the code action
  -- You can set the highlight like so: { link = "DiagnosticError" } or  like nvim_set_hl ({ fg ..., bg..., bold..., ...})
  signs = require("plugins.tiny-code-action-nvim.opts.signs"),
}

return opts
