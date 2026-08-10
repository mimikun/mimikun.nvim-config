---@type table
local opts = {
  -- Keep the snippet tree around after leaving it, so <S-Tab> can jump back
  -- into a snippet that was already exited.
  -- These four replace the old `history` key, which set all of them at once.
  ---@type boolean
  keep_roots = true,

  ---@type boolean
  link_roots = true,

  ---@type boolean
  exit_roots = false,

  ---@type boolean
  link_children = true,

  -- Default is "InsertLeave", which only refreshes dynamic nodes once insert
  -- mode is left. Update while typing instead, which is the point of using
  -- function/dynamic nodes.
  ---@type string
  update_events = "TextChanged,TextChangedI",

  -- Remove a snippet from the jump list once its text is deleted
  ---@type string
  delete_check_events = "TextChanged",

  -- Snippets that expand without being selected from the menu.
  -- Off for now: they fire on plain typing, so they are easy to trip over.
  ---@type boolean
  enable_autosnippets = false,
}

return opts
