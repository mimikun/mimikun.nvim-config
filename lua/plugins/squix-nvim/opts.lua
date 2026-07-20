---@type table
local opts = {
  -- :SquixRun hides query name + SQL in the TUI (already shown in the editor)
  hide_query = true,

  -- in-TUI <C-w>hjkl window navigation
  -- false sends keys raw to the TUI
  term_keymaps = true,

  -- set laststatus=0 while the squix TUI is focused (splits have no per-window statusline)
  hide_statusline = true,

  window = {
    ---@type string | "botright" | "topleft" | "vertical" | "float"
    position = "botright",

    -- fraction of the editor for split positions
    split_ratio = 0.4,

    -- focus (and enter) the TUI window when it opens
    -- false opens it in the background
    auto_focus = true,

    -- only when position = "float"
    float = {
      width = "80%",
      height = "80%",
      row = "center",
      col = "center",
      relative = "editor",
      border = "rounded",
    },
  },

  -- none mapped by default
  -- set any to a key to enable
  keymaps = {
    -- :SquixRun            (normal + visual)
    run = "<leader>st",

    -- :SquixRunNamedQuery  (normal)
    run_named_query = "<leader>sq",

    -- :SquixAdd            (normal + visual)
    add = "<leader>sa",

    -- :SquixSwitch         (normal)
    switch = "<leader>ss",

    -- :SquixInit           (normal)
    init = "<leader>si",

    -- :SquixStatus         (normal)
    status = "<leader>sS",

    -- :SquixTables         (normal)
    tables = "<leader>sT",
  },
}

return opts
