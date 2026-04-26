---@type LazyKeysSpec[]
local keys = {
  -- Top Pickers & Explorer
  {
    "<leader><space>",
    function()
      Snacks.picker.smart()
    end,
    desc = "Smart Find Files",
    { silent = true },
  },
  {
    "<leader>,",
    function()
      Snacks.picker.buffers()
    end,
    desc = "Buffers",
    { silent = true },
  },
  {
    "<leader>/",
    function()
      Snacks.picker.grep()
    end,
    desc = "Grep",
    { silent = true },
  },
  {
    "<leader>:",
    function()
      Snacks.picker.command_history()
    end,
    desc = "Command History",
    { silent = true },
  },
  {
    "<leader>n",
    function()
      Snacks.picker.notifications()
    end,
    desc = "Notification History",
    { silent = true },
  },
  {
    "<leader>e",
    function()
      Snacks.explorer()
    end,
    desc = "File Explorer",
    { silent = true },
  },
  -- find
  {
    "<leader>fb",
    function()
      Snacks.picker.buffers()
    end,
    desc = "Buffers",
    { silent = true },
  },
  {
    "<leader>fc",
    function()
      Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
    end,
    desc = "Find Config File",
    { silent = true },
  },
  {
    "<leader>ff",
    function()
      Snacks.picker.files()
    end,
    desc = "Find Files",
    { silent = true },
  },
  {
    "<leader>fg",
    function()
      Snacks.picker.git_files()
    end,
    desc = "Find Git Files",
    { silent = true },
  },
  {
    "<leader>fp",
    function()
      Snacks.picker.projects()
    end,
    desc = "Projects",
    { silent = true },
  },
  {
    "<leader>fr",
    function()
      Snacks.picker.recent()
    end,
    desc = "Recent",
    { silent = true },
  },
  -- git
  {
    "<leader>gb",
    function()
      Snacks.picker.git_branches()
    end,
    desc = "Git Branches",
    { silent = true },
  },
  {
    "<leader>gl",
    function()
      Snacks.picker.git_log()
    end,
    desc = "Git Log",
    { silent = true },
  },
  {
    "<leader>gL",
    function()
      Snacks.picker.git_log_line()
    end,
    desc = "Git Log Line",
    { silent = true },
  },
  {
    "<leader>gs",
    function()
      Snacks.picker.git_status()
    end,
    desc = "Git Status",
    { silent = true },
  },
  {
    "<leader>gS",
    function()
      Snacks.picker.git_stash()
    end,
    desc = "Git Stash",
    { silent = true },
  },
  {
    "<leader>gd",
    function()
      Snacks.picker.git_diff()
    end,
    desc = "Git Diff (Hunks)",
    { silent = true },
  },
  {
    "<leader>gf",
    function()
      Snacks.picker.git_log_file()
    end,
    desc = "Git Log File",
    { silent = true },
  },
  -- gh
  {
    "<leader>gi",
    function()
      Snacks.picker.gh_issue()
    end,
    desc = "GitHub Issues (open)",
    { silent = true },
  },
  {
    "<leader>gI",
    function()
      Snacks.picker.gh_issue({ state = "all" })
    end,
    desc = "GitHub Issues (all)",
    { silent = true },
  },
  {
    "<leader>gp",
    function()
      Snacks.picker.gh_pr()
    end,
    desc = "GitHub Pull Requests (open)",
    { silent = true },
  },
  {
    "<leader>gP",
    function()
      Snacks.picker.gh_pr({ state = "all" })
    end,
    desc = "GitHub Pull Requests (all)",
    { silent = true },
  },
  -- Grep
  {
    "<leader>sb",
    function()
      Snacks.picker.lines()
    end,
    desc = "Buffer Lines",
    { silent = true },
  },
  {
    "<leader>sB",
    function()
      Snacks.picker.grep_buffers()
    end,
    desc = "Grep Open Buffers",
    { silent = true },
  },
  {
    "<leader>sg",
    function()
      Snacks.picker.grep()
    end,
    desc = "Grep",
    { silent = true },
  },
  {
    "<leader>sw",
    function()
      Snacks.picker.grep_word()
    end,
    mode = { "n", "x" },
    desc = "Visual selection or word",
    { silent = true },
  },
  -- search
  {
    '<leader>s"',
    function()
      Snacks.picker.registers()
    end,
    desc = "Registers",
    { silent = true },
  },
  {
    "<leader>s/",
    function()
      Snacks.picker.search_history()
    end,
    desc = "Search History",
    { silent = true },
  },
  {
    "<leader>sa",
    function()
      Snacks.picker.autocmds()
    end,
    desc = "Autocmds",
    { silent = true },
  },
  {
    "<leader>sb",
    function()
      Snacks.picker.lines()
    end,
    desc = "Buffer Lines",
    { silent = true },
  },
  {
    "<leader>sc",
    function()
      Snacks.picker.command_history()
    end,
    desc = "Command History",
    { silent = true },
  },
  {
    "<leader>sC",
    function()
      Snacks.picker.commands()
    end,
    desc = "Commands",
    { silent = true },
  },
  {
    "<leader>sd",
    function()
      Snacks.picker.diagnostics()
    end,
    desc = "Diagnostics",
    { silent = true },
  },
  {
    "<leader>sD",
    function()
      Snacks.picker.diagnostics_buffer()
    end,
    desc = "Buffer Diagnostics",
    { silent = true },
  },
  {
    "<leader>sh",
    function()
      Snacks.picker.help()
    end,
    desc = "Help Pages",
    { silent = true },
  },
  {
    "<leader>sH",
    function()
      Snacks.picker.highlights()
    end,
    desc = "Highlights",
    { silent = true },
  },
  {
    "<leader>si",
    function()
      Snacks.picker.icons()
    end,
    desc = "Icons",
    { silent = true },
  },
  {
    "<leader>sj",
    function()
      Snacks.picker.jumps()
    end,
    desc = "Jumps",
    { silent = true },
  },
  {
    "<leader>sk",
    function()
      Snacks.picker.keymaps()
    end,
    desc = "Keymaps",
    { silent = true },
  },
  {
    "<leader>sl",
    function()
      Snacks.picker.loclist()
    end,
    desc = "Location List",
    { silent = true },
  },
  {
    "<leader>sm",
    function()
      Snacks.picker.marks()
    end,
    desc = "Marks",
    { silent = true },
  },
  {
    "<leader>sM",
    function()
      Snacks.picker.man()
    end,
    desc = "Man Pages",
    { silent = true },
  },
  {
    "<leader>sp",
    function()
      Snacks.picker.lazy()
    end,
    desc = "Search for Plugin Spec",
    { silent = true },
  },
  {
    "<leader>sq",
    function()
      Snacks.picker.qflist()
    end,
    desc = "Quickfix List",
    { silent = true },
  },
  {
    "<leader>sR",
    function()
      Snacks.picker.resume()
    end,
    desc = "Resume",
    { silent = true },
  },
  {
    "<leader>su",
    function()
      Snacks.picker.undo()
    end,
    desc = "Undo History",
    { silent = true },
  },
  {
    "<leader>uC",
    function()
      Snacks.picker.colorschemes()
    end,
    desc = "Colorschemes",
    { silent = true },
  },
  -- LSP
  {
    "gd",
    function()
      Snacks.picker.lsp_definitions()
    end,
    desc = "Goto Definition",
    { silent = true },
  },
  {
    "gD",
    function()
      Snacks.picker.lsp_declarations()
    end,
    desc = "Goto Declaration",
    { silent = true },
  },
  {
    "gr",
    function()
      Snacks.picker.lsp_references()
    end,
    nowait = true,
    desc = "References",
    { silent = true },
  },
  {
    "gI",
    function()
      Snacks.picker.lsp_implementations()
    end,
    desc = "Goto Implementation",
    { silent = true },
  },
  {
    "gy",
    function()
      Snacks.picker.lsp_type_definitions()
    end,
    desc = "Goto T[y]pe Definition",
    { silent = true },
  },
  {
    "gai",
    function()
      Snacks.picker.lsp_incoming_calls()
    end,
    desc = "C[a]lls Incoming",
    { silent = true },
  },
  {
    "gao",
    function()
      Snacks.picker.lsp_outgoing_calls()
    end,
    desc = "C[a]lls Outgoing",
    { silent = true },
  },
  {
    "<leader>ss",
    function()
      Snacks.picker.lsp_symbols()
    end,
    desc = "LSP Symbols",
    { silent = true },
  },
  {
    "<leader>sS",
    function()
      Snacks.picker.lsp_workspace_symbols()
    end,
    desc = "LSP Workspace Symbols",
    { silent = true },
  },
  -- Other
  {
    "<leader>z",
    function()
      Snacks.zen()
    end,
    desc = "Toggle Zen Mode",
    { silent = true },
  },
  {
    "<leader>Z",
    function()
      Snacks.zen.zoom()
    end,
    desc = "Toggle Zoom",
    { silent = true },
  },
  {
    "<leader>.",
    function()
      Snacks.scratch()
    end,
    desc = "Toggle Scratch Buffer",
    { silent = true },
  },
  {
    "<leader>S",
    function()
      Snacks.scratch.select()
    end,
    desc = "Select Scratch Buffer",
    { silent = true },
  },
  {
    "<leader>n",
    function()
      Snacks.notifier.show_history()
    end,
    desc = "Notification History",
    { silent = true },
  },
  {
    "<leader>bd",
    function()
      Snacks.bufdelete()
    end,
    desc = "Delete Buffer",
    { silent = true },
  },
  {
    "<leader>cR",
    function()
      Snacks.rename.rename_file()
    end,
    desc = "Rename File",
    { silent = true },
  },
  {
    "<leader>gB",
    function()
      Snacks.gitbrowse()
    end,
    mode = { "n", "v" },
    desc = "Git Browse",
    { silent = true },
  },
  {
    "<leader>gg",
    function()
      Snacks.lazygit()
    end,
    desc = "Lazygit",
    { silent = true },
  },
  {
    "<leader>un",
    function()
      Snacks.notifier.hide()
    end,
    desc = "Dismiss All Notifications",
    { silent = true },
  },
  {
    "<c-/>",
    function()
      Snacks.terminal()
    end,
    desc = "Toggle Terminal",
    { silent = true },
  },
  {
    "<c-_>",
    function()
      Snacks.terminal()
    end,
    desc = "which_key_ignore",
    { silent = true },
  },
  {
    "] ]",
    function()
      Snacks.words.jump(vim.v.count1)
    end,
    mode = { "n", "t" },
    desc = "Next Reference",
    { silent = true },
  },
  {
    "[ [",
    function()
      Snacks.words.jump(-vim.v.count1)
    end,
    mode = { "n", "t" },
    desc = "Prev Reference",
    { silent = true },
  },
  {
    "<leader>N",
    function()
      Snacks.win({
        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
        width = 0.6,
        height = 0.6,
        wo = {
          spell = false,
          wrap = false,
          signcolumn = "yes",
          statuscolumn = " ",
          conceallevel = 3,
        },
      })
    end,
    desc = "Neovim News",
    { silent = true },
  },
  {
    "<leader>ps",
    function()
      Snacks.profiler.scratch()
    end,
    desc = "Profiler Scratch Bufer",
    { silent = true },
  },
}

return keys
