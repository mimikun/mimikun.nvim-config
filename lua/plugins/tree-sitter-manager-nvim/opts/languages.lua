-- User-defined language repos to use instead of the built-in ones.
-- Can either be a string (a git URL), or a more detailed LanguageSpec.
---@type table<string, string | tree-sitter-manager.LanguageSpec>
local languages = {
  -- Information about how to fetch and build the grammar.
  ---@field install_info? tree-sitter-manager.InstallInfo

  -- Git URL of the grammar repository.
  ---@field url string

  -- Sub-directory within the repo where the grammar is stored.
  -- Defaults to the name of the language.
  ---@field location? string

  -- Git revision to check out after cloning.
  -- Takes priority over `branch`.
  ---@field revision? string

  -- Git branch to check out after cloning.
  -- Ignored if `revision` is set.
  ---@field branch? string

  -- Run `tree-sitter generate` before building.
  -- Defaults to false.
  ---@field generate? boolean

  -- Specifies the queries directory in the cloned repo that will be used.
  ---@field queries? string

  -- Other languages that are dependencies of this one and must be installed first.
  ---@field requires? string[]
}

return languages
