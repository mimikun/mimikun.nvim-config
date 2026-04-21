---@type table
local opts = {
  -- show files that match gitignore with !!
  show_ignored = true,

  -- customize the symbols that appear in the git status columns
  symbols = {
    index = {
      ["!"] = "!",
      ["?"] = "?",
      ["A"] = "A",
      ["C"] = "C",
      ["D"] = "D",
      ["M"] = "M",
      ["R"] = "R",
      ["T"] = "T",
      ["U"] = "U",
      [" "] = " ",
    },

    working_tree = {
      ["!"] = "!",
      ["?"] = "?",
      ["A"] = "A",
      ["C"] = "C",
      ["D"] = "D",
      ["M"] = "M",
      ["R"] = "R",
      ["T"] = "T",
      ["U"] = "U",
      [" "] = " ",
    },
  },
}

return opts
