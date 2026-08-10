-- Snippets available in every filetype.
--
-- Loaded by plugins/LuaSnip/init.lua through luasnip.loaders.from_lua, which
-- reads one file per filetype from this directory; `all` applies everywhere.

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node

-- Comment syntax of the current buffer, split around the `%s` of
-- 'commentstring'. Falls back to `#` for filetypes that define none.
---@return string prefix
---@return string suffix
local function comment_parts()
  local cs = vim.bo.commentstring ~= "" and vim.bo.commentstring or "# %s"
  return cs:match("^(.*)%%s") or "# ", cs:match("%%s(.*)$") or ""
end

return {
  -- `date` -> today's date, e.g. 2026-08-10
  -- A function node, which the built-in snippet source cannot express at all:
  -- vim.snippet has no date variable.
  s("date", {
    f(function()
      return os.date("%Y-%m-%d")
    end),
  }),

  -- `todo` -> a TODO comment carrying today's date, written with the comment
  -- syntax of the current filetype (`-- ` in lua, `# ` in fish, ...)
  s("todo", {
    f(function()
      local prefix = comment_parts()
      return prefix .. "TODO(" .. os.date("%Y-%m-%d") .. "): "
    end),
    i(1),
    f(function()
      local _, suffix = comment_parts()
      return suffix
    end),
  }),
}
