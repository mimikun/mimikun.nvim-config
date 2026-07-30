---@type LazySpec
local spec = {
  "alker0/chezmoi.vim",
  lazy = false,
  init = function()
    -- Regex pattern of path for ignoring file type detection
    vim.g["chezmoi#detect_ignore_pattern"] = ""

    -- Setting `false` makes this plugin create and use temporary buffer for making builtin filetype detection override wrong filetype
    vim.g["chezmoi#use_tmp_buffer"] = true
  end,
  cond = false,
  enabled = false,
}

return spec
