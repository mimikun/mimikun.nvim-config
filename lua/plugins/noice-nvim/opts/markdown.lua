local markdown = {
  hover = {
    -- vim help links
    ["|(%S-)|"] = vim.cmd.help,

    -- markdown links
    ["%[.-%]%((%S-)%)"] = require("noice.util").open,
  },
  highlights = {
    ["|%S-|"] = "@text.reference",
    ["@%S+"] = "@parameter",
    ["^%s*(Parameters:)"] = "@text.title",
    ["^%s*(Return:)"] = "@text.title",
    ["^%s*(See also:)"] = "@text.title",
    ["{%S-}"] = "@parameter",
  },
}

return markdown
