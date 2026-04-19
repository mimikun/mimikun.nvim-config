---@type Persistence.Config
local opts = {
  -- directory where session files are saved
  dir = vim.fn.stdpath("state") .. "/sessions/",
  -- minimum number of file buffers that need to be open to save
  -- Set to 0 to always save
  need = 1,
  -- use git branch to save session
  branch = true,
}

return opts
