---@type table
local keymaps = {
  ["<CR>"] = "actions.select",
  ["l"] = "actions.select",
  ["h"] = "actions.close_dir",
  ["<Esc>"] = "actions.close_win",
  ["<C-h>"] = "actions.goto_parent",
  ["<C-l>"] = "actions.goto_dir",
  ["<M-h>"] = "actions.goto_home_dir",
  ["cd"] = "actions.change_home_dir",
  ["L"] = "actions.open_dirs",
  ["H"] = "actions.close_dirs",
  ["o"] = "actions.oil_dir",
  ["O"] = "actions.oil_into_dir",
  ["t"] = "actions.open_tab",
  ["v"] = "actions.open_vsplit",
  ["s"] = "actions.open_split",
  ["."] = "actions.toggle_hidden",
  ["i"] = "actions.toggle_ignore",
  ["r"] = "actions.refresh",
  ["f"] = "actions.focus_file",
  ["?"] = "actions.open_help",
}

return keymaps
