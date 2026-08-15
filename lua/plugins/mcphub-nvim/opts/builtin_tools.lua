local builtin_tools = {
  ---@type EditSessionConfig
  edit_file = {
    parser = {
      track_issues = true,
      extract_inline_content = true,
    },
    locator = {
      fuzzy_threshold = 0.8,
      enable_fuzzy_matching = true,
    },
    ui = {
      go_to_origin_on_complete = true,
      keybindings = {
        -- Accept current change
        accept = ".",

        -- Reject current change
        reject = ",",

        -- Next diff
        next = "n",

        -- Previous diff
        prev = "p",

        -- Accept all remaining changes
        accept_all = "ga",

        -- Reject all remaining changes
        reject_all = "gr",
      },
    },
    feedback = {
      include_parser_feedback = true,
      include_locator_feedback = true,
      include_ui_summary = true,
      ui = {
        include_session_summary = true,
        include_final_diff = true,
        send_diagnostics = true,
        wait_for_diagnostics = 500,

        -- Only show warnings and above by default
        diagnostic_severity = vim.diagnostic.severity.WARN,
      },
    },
  },
}

return builtin_tools
