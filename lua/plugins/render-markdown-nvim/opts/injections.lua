---@type render.md.injection.Configs
local injections = {
  -- Out of the box language injections for known filetypes that allow markdown to be interpreted in specified locations, see :h treesitter-language-injections.
  -- Set enabled to false in order to disable.
  gitcommit = {
    enabled = true,
    query = [[
                ((message) @injection.content
                    (#set! injection.combined)
                    (#set! injection.include-children)
                    (#set! injection.language "markdown"))
            ]],
  },
}

return injections
