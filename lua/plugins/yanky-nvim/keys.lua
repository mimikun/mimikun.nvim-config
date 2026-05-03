---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>p",
    -- Normal
    --"<cmd>YankyRingHistory<cr>",
    -- Use Snacks
    function()
      require("snacks").picker.yanky()
    end,
    mode = { "n", "x" },
    desc = "Open Yank History",
    silent = true,
  },
  {
    "y",
    "<Plug>(YankyYank)",
    mode = { "n", "x" },
    desc = "Yank text",
    silent = true,
  },
  {
    "p",
    "<Plug>(YankyPutAfter)",
    mode = { "n", "x" },
    desc = "Put yanked text after cursor",
    silent = true,
  },
  {
    "P",
    "<Plug>(YankyPutBefore)",
    mode = { "n", "x" },
    desc = "Put yanked text before cursor",
    silent = true,
  },
  {
    "gp",
    "<Plug>(YankyGPutAfter)",
    mode = { "n", "x" },
    desc = "Put yanked text after cursor and leave cursor after",
    silent = true,
  },
  {
    "gP",
    "<Plug>(YankyGPutBefore)",
    mode = { "n", "x" },
    desc = "Put yanked text before cursor and leave cursor after",
    silent = true,
  },
  {
    "<c-p>",
    "<Plug>(YankyPreviousEntry)",
    desc = "Select previous entry through yank history",
    silent = true,
  },
  {
    "<c-n>",
    "<Plug>(YankyNextEntry)",
    desc = "Select next entry through yank history",
    silent = true,
  },
  {
    "]p",
    "<Plug>(YankyPutIndentAfterLinewise)",
    desc = "Put indented after cursor (linewise)",
    silent = true,
  },
  {
    "[p",
    "<Plug>(YankyPutIndentBeforeLinewise)",
    desc = "Put indented before cursor (linewise)",
    silent = true,
  },
  {
    "]P",
    "<Plug>(YankyPutIndentAfterLinewise)",
    desc = "Put indented after cursor (linewise)",
    silent = true,
  },
  {
    "[P",
    "<Plug>(YankyPutIndentBeforeLinewise)",
    desc = "Put indented before cursor (linewise)",
    silent = true,
  },
  {
    ">p",
    "<Plug>(YankyPutIndentAfterShiftRight)",
    desc = "Put and indent right",
    silent = true,
  },
  {
    "<p",
    "<Plug>(YankyPutIndentAfterShiftLeft)",
    desc = "Put and indent left",
    silent = true,
  },
  {
    ">P",
    "<Plug>(YankyPutIndentBeforeShiftRight)",
    desc = "Put before and indent right",
    silent = true,
  },
  {
    "<P",
    "<Plug>(YankyPutIndentBeforeShiftLeft)",
    desc = "Put before and indent left",
    silent = true,
  },
  {
    "=p",
    "<Plug>(YankyPutAfterFilter)",
    desc = "Put after applying a filter",
    silent = true,
  },
  {
    "=P",
    "<Plug>(YankyPutBeforeFilter)",
    desc = "Put before applying a filter",
    silent = true,
  },
  {
    "iy",
    function()
      require("yanky.textobj").last_put()
    end,
    mode = { "o", "x" },
    desc = "",
    silent = true,
  },
}

return keys
