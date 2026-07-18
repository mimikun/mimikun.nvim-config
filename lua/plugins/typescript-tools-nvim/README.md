```lua
require("typescript-tools").setup {
  settings = {
    ...
    tsserver_file_preferences = function(ft)
      -- Some "ifology" using `ft` of opened file
      return {
        includeInlayParameterNameHints = "all",
        includeCompletionsForModuleExports = true,
        quotePreference = "auto",
        ...
      }
    end,
    tsserver_format_options = function(ft)
      -- Some "ifology" using `ft` of opened file
      return {
        allowIncompleteCompletions = false,
        allowRenameOfImportPath = false,
        ...
      }
    end
  },
}
```
