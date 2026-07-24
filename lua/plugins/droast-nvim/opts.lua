---@type table
local opts = {
  command = "droast",
  args = {
    "--preset",
    "production",
  },
  on_save = true,
  virtual_text = true,
  signs = true,
  underline = true,
}

return opts
