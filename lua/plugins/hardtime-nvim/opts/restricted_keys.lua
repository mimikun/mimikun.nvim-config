---@type table Keys in what modes triggering the count mechanism.
local restricted_keys = {
  ["h"] = { "n", "x" },
  ["j"] = { "n", "x" },
  ["k"] = { "n", "x" },
  ["l"] = { "n", "x" },
  ["+"] = { "n", "x" },
  ["gj"] = { "n", "x" },
  ["gk"] = { "n", "x" },
  ["<C-M>"] = { "n", "x" },
  ["<C-N>"] = { "n", "x" },
  ["<C-P>"] = { "n", "x" },
}

return restricted_keys
