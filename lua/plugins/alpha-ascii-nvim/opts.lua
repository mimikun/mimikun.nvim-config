---@type string
local header
header = "random"
--header = "abstract_portrait"

---@type string
local user_path
-- Use absolute path
--user_path = vim.fn.expand("~/.config/nvim/ascii")
-- Use Neovim's config path
user_path = vim.fn.stdpath("config") .. "/ascii"

---@type table
local opts = {
  -- Header name, use "random" for a random header
  ---@type string | "random"
  header = header,

  -- List of headers to exclude
  ---@type table
  exclude = {
    "header_1",
    "header_2",
  },

  -- Use some default headers
  ---@type boolean
  use_default = true,

  -- Path to your custom headers
  ---@type string
  user_path = user_path,
}

return opts
