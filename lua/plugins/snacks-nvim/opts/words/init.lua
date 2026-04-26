---@type snacks.words.Config
local words = {
  enabled = true,
  -- time in ms to wait before updating
  debounce = 200,
  -- show a notification when jumping
  notify_jump = false,
  -- show a notification when reaching the end
  notify_end = true,
  -- open folds after jumping
  foldopen = true,
  -- set jump point before jumping
  jumplist = true,
  -- modes to show references
  modes = {
    "n",
    "i",
    "c",
  },
  -- what buffers to enable `snacks.words`
  filter = function(buf)
    return vim.g.snacks_words ~= false and vim.b[buf].snacks_words ~= false
  end,
}

return words
