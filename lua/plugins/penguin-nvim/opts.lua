---@type table
local opts = {
  -- makes exact command queries bypass the selected suggestion on plain `Enter`;
  -- defaults are `:bd`, `:noh`, `:q`, `:q!`, `:qa`, `:qa!`, `:w`, `:w!`, `:wq`, and `:x`
  direct_submit_on_enter_commands = {
    bd = true,
    noh = true,
    q = true,
    ["q!"] = true,
    qa = true,
    ["qa!"] = true,
    w = true,
    ["w!"] = true,
    wq = true,
    x = true,
  },
  -- makes fully numeric queries bypass the selected suggestion on plain `Enter` so `30` jumps straight to line 30
  direct_numeric_line_jumps_on_enter = true,

  -- makes plain `Enter` execute the current query if there are no suggestions showing, instead of doing nothing
  submit_on_enter_if_no_matches = true,

  completion = {
    -- Command-name completion stays synchronous.
    -- Argument completion strategy is selected per command so cheap path-oriented commands can stay fully live while known slow commands such as `:checkhealth` can be deferred.
    debounce_ms = 75,
    command_strategies = {
      checkhealth = "prefix_cached_deferred",
    },
  },

  open_on_bare_enter = true,
  native = {
    enabled = true,
    auto_build = true,

    -- Benchmark-only Lua baseline:
    benchmark_only_lua = false,
  },

  ui = {
    border = "rounded",
    max_results = 18,
    match_highlights = true,
    width = 72,
  },
}

return opts
