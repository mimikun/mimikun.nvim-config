---@type onoma.Config
local opts = {
  ---@type onoma.Picker | (onoma.Picker)[]
  picker = {
    "snacks",
    --"telescope",
  },

  ---@type boolean
  debug = false,

  ---@type onoma.SnacksConfig
  snacks = {
    ---@type string
    title = "Symbols (Onoma)",
  },

  ---@type onoma.TelescopeConfig
  telescope = {
    ---@type string
    results_title = "Symbols (Onoma)",

    ---@type string
    prompt_title = "",

    ---@type string
    preview_title = "",
  },

  ---@type {string: onoma.SymbolKind[]} | onoma.SymbolKind[]
  symbol_kinds = {
    go = {
      "Unknown",
      "Constant",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Struct",
      "Type",
    },
    rust = {
      "Unknown",
      "Constant",
      "Enum",
      "EnumMember",
      "Function",
      "Getter",
      "Macro",
      "Method",
      "Module",
      "StaticVariable",
      "Struct",
      "Trait",
      "TraitMethod",
      "TypeAlias",
    },
    lua = {
      "Unknown",
      "Enum",
      "EnumMember",
      "Function",
      "Method",
      "Property",
      "Struct",
    },
    typescript = {
      "Unknown",
      "Class",
      "Constant",
      "Enum",
      "EnumMember",
      "Function",
      "Getter",
      "Interface",
      "Method",
      "Module",
      "Setter",
      "TypeAlias",
    },
    typescriptjsx = {
      "Unknown",
      "Class",
      "Constant",
      "Enum",
      "EnumMember",
      "Function",
      "Getter",
      "Interface",
      "Method",
      "Module",
      "Setter",
      "TypeAlias",
    },
    javascript = {
      "Unknown",
      "Class",
      "Constant",
      "Function",
      "Getter",
      "Method",
      "Module",
      "Setter",
    },
    javascriptjsx = {
      "Unknown",
      "Class",
      "Constant",
      "Function",
      "Getter",
      "Method",
      "Module",
      "Setter",
    },
    clojure = {
      "Unknown",
      "Enum",
      "EnumMember",
      "Function",
      "Macro",
      "Namespace",
    },
    python = {
      "Unknown",
      "Class",
      "Constant",
      "Enum",
      "EnumMember",
      "Error",
      "Function",
      "Getter",
      "Method",
      "Module",
      "Property",
      "Setter",
      "StaticMethod",
    },
  },
}

return opts
