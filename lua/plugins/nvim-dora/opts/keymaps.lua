-- Key mappings
---@type table<string, DoraKeymapSpec>
local keymaps = {
  --- General
  -- Show help
  ["g?"] = "help",

  -- Quit dora
  q = "quit",

  --- Navigation
  -- Up directory
  ["-"] = "up_dir",

  h = "up_dir", -- Up directory

  -- Next sibling
  J = "next_sibling",

  -- Previous sibling
  K = "prev_sibling",

  -- Parent directory
  ["<C-p>"] = "parent_dir",

  -- Fold out directory one level
  o = "fold_out",

  -- Fold out directory all the way
  O = "fold_out_recursive",

  -- Fold in directory one level
  i = "fold_in",

  -- Fold in directory all the way
  I = "fold_in_recursive",

  -- Close directory
  ["<BS>"] = "close_dir",

  -- Go to home directory
  gh = "home_dir",

  -- Go to next paste mark
  ["]m"] = "next_paste_mark",

  -- Go to previous paste mark
  ["[m"] = "prev_paste_mark",

  -- Go backward in directory history
  ["<"] = "history_back",

  -- Go forward in directory history
  [">"] = "history_forward",

  --- Open

  -- Open
  ["<CR>"] = "open",

  -- Open
  l = "open",

  -- Open in split
  s = "open_split",

  -- Open in vertical split
  v = "open_vsplit",

  -- Open in tab
  t = "open_tab",

  -- Open in split without closing Dora
  ["<C-s>"] = "open_split_stay",

  -- Open in vertical split without closing Dora
  ["<C-v>"] = "open_vsplit_stay",

  -- Open in tab without closing Dora
  ["<C-t>"] = "open_tab_stay",

  -- Open in external program
  gx = "open_external",

  --- File operations
  -- Add file or folder
  a = "add",
  A = "add_under", -- Add file or folder under directory
  S = "create_symlink", -- Create symlink to file
  r = "rename", -- Rename file
  R = "rename_empty", -- Rename file with empty prompt
  d = "trash", -- Move file to trash (macOS/Linux)
  D = "delete", -- Delete file permanently
  u = "undo_trash", -- Restore the most recently trashed files
  x = "toggle_cut", -- Toggle cut mark
  X = "clear_cut", -- Clear all cut marks
  c = "toggle_copy", -- Toggle copy mark
  C = "clear_copy", -- Clear all copy marks
  p = "paste_under", -- Paste under directory
  P = "paste", -- Paste
  ["."] = "shell_cmd", -- Run shell command on file

  --- View
  -- Filter visible files
  f = "filter",
  F = "clear_filter", -- Clear filter
  gi = "file_info", -- Show file info
  ["g."] = "toggle_hidden_files", -- Toggle hidden files visible
  gp = "toggle_preview", -- Toggle file preview
  ["<C-r>"] = "reload", -- Reload tree view

  --- Yank
  -- Yank full path
  yy = "yank_full_path",

  -- Yank full path to clipboard
  yY = "yank_full_path_clipboard",

  -- Yank parent directory
  yd = "yank_dir_path",

  -- Yank parent directory to clipboard
  yD = "yank_dir_path_clipboard",

  -- Yank filename
  yf = "yank_filename",

  -- Yank filename to clipboard
  yF = "yank_filename_clipboard",

  -- Yank name without extension
  yn = "yank_name_stem",

  -- Yank name without extension to clipboard
  yN = "yank_name_stem_clipboard",

  --- Sort
  -- Sort by name
  [",n"] = "sort_by_name",

  -- Sort by name (descending)
  [",N"] = "sort_by_name_desc",

  -- Sort by modified time
  [",m"] = "sort_by_modified",

  -- Sort by modified time (descending)
  [",M"] = "sort_by_modified_desc",

  -- Sort by creation time
  [",c"] = "sort_by_created",

  -- Sort by creation time (descending)
  [",C"] = "sort_by_created_desc",

  -- Sort by size
  [",s"] = "sort_by_size",

  -- Sort by size (descending)
  [",S"] = "sort_by_size_desc",

  -- Sort by extension
  [",e"] = "sort_by_extension",

  -- Sort by extension (descending)
  [",E"] = "sort_by_extension_desc",

  --- Visual Mode?
  --["<2-LeftMouse>"] = "open",
  --Y = "yank_full_path",

  --- Other
  ["gc"] = {
    function(ctx)
      vim.api.nvim_set_current_dir(ctx.cwd)
    end,
    desc = "Change working directory",
  },
}

return keymaps
