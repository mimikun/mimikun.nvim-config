---@type render.md.injection.Configs | table<string, render.md.injection.UserConfig>
local injections = {
  -- Out of the box language injections for known filetypes that allow markdown to be interpreted in specified locations, see :h treesitter-language-injections.
  -- Set enabled to false in order to disable.
  gitcommit = {
    ---@type boolean
    enabled = true,

    ---@type string
    query = [[
      ((message) @injection.content
          (#set! injection.combined)
          (#set! injection.include-children)
          (#set! injection.language "markdown"))
    ]],
  },
}

return injections
