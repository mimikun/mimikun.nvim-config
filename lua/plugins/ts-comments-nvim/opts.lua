---@alias TSCommentsSpec string | string[] | table<string, string | string[]>

---@type TSCommentsOptions
local opts = {
  ---@type table<string, TSCommentsSpec>
  lang = {
    astro = "<!-- %s -->",
    axaml = "<!-- %s -->",
    blueprint = "// %s",
    c = "// %s",
    c_sharp = "// %s",
    clojure = {
      ";; %s",
      "; %s",
    },
    cpp = "// %s",
    cs_project = "<!-- %s -->",
    cue = "// %s",
    fsharp = "// %s",
    fsharp_project = "<!-- %s -->",
    gleam = "// %s",
    glimmer = "{{! %s }}",
    graphql = "# %s",
    handlebars = "{{! %s }}",
    hcl = "# %s",
    html = "<!-- %s -->",
    hyprlang = "# %s",
    ini = "; %s",
    ipynb = "# %s",
    javascript = {
      -- default commentstring when no treesitter node matches
      "// %s",
      "/* %s */",

      -- specific commentstring for call_expression
      call_expression = "// %s",
      jsx_attribute = "// %s",
      jsx_element = "{/* %s */}",
      jsx_fragment = "{/* %s */}",
      spread_element = "// %s",
      statement_block = "// %s",
    },
    kdl = "// %s",
    php = "// %s",
    rego = "# %s",
    rescript = "// %s",
    rust = {
      "// %s",
      "/* %s */",
    },
    sql = "-- %s",
    styled = "/* %s */",
    svelte = "<!-- %s -->",
    templ = {
      "// %s",
      component_block = "<!-- %s -->",
    },
    terraform = "# %s",
    tsx = {
      -- default commentstring when no treesitter node matches
      "// %s",
      "/* %s */",

      -- specific commentstring for call_expression
      call_expression = "// %s",
      jsx_attribute = "// %s",
      jsx_element = "{/* %s */}",
      jsx_fragment = "{/* %s */}",
      spread_element = "// %s",
      statement_block = "// %s",
    },
    twig = "{# %s #}",

    -- langs can have multiple commentstrings
    typescript = {
      "// %s",
      "/* %s */",
    },
    vue = "<!-- %s -->",
    xaml = "<!-- %s -->",
  },
}

return opts
