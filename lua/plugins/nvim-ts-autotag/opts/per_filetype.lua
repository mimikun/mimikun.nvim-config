-- Per filetype config overrides
---@type { [string]: nvim-ts-autotag.Opts }
local per_filetype = {
  ["html"] = {
    enable_close = false,
  },
}

return per_filetype
