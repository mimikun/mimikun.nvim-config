---@type baleia.UserOptions
local opts = {
  -- prefix used to name highlight groups
  name = "BaleiaColors",

  -- remove ANSI color codes from text
  strip_ansi_codes = true,

  -- at which column start colorizing
  -- (one-indexed)
  line_starts_at = 1,

  -- table mapping 256 color codes to vim colors
  --colors = [NR_8](lua/baleia/ansi.lua#L262)

  -- highlight asynchronously
  async = true,

  -- number of lines to process per loop iteration (async)
  chunk_size = 500,
}

return opts
