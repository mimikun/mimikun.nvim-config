local finder = {
  max_height = 0.5,
  left_width = 0.4,
  methods = {},
  default = "ref+imp",
  layout = "float",
  silent = false,
  filter = {},
  fname_sub = nil,
  sp_inexist = false,
  sp_global = false,
  ly_botright = false,
  number = vim.o.number,
  relativenumber = vim.o.relativenumber,
  ref_opt = true,
  keys = {
    shuttle = "[w",
    toggle_or_open = "o",
    vsplit = "s",
    split = "i",
    tabe = "t",
    tabnew = "r",
    quit = "q",
    close = "<C-c>k",
  },
}

return finder
