# TreeSitter Support

camouflage.nvim uses TreeSitter queries for enhanced parsing of structured file formats. TreeSitter provides more accurate detection than regex, especially for nested structures, multi-line values, and complex syntax.

## Supported Languages

| Language | Query File | Fallback |
|----------|-----------|----------|
| JSON | `queries/json/camouflage.scm` | Inline query + regex |
| YAML | `queries/yaml/camouflage.scm` | Inline query + regex |
| TOML | `queries/toml/camouflage.scm` | Inline query + regex |
| XML | `queries/xml/camouflage.scm` | Inline query + regex |
| HTTP | `queries/http/camouflage.scm` | Inline query + regex |
| HCL / Terraform | (inline only) | Regex |
| Dockerfile | (inline only) | Regex |

## How It Works

Each TreeSitter-capable parser follows this strategy:

1. **Check if TreeSitter parser is installed** for the language (result is cached)
2. **Load query** from `queries/<lang>/camouflage.scm` file
3. **Parse the tree** and iterate over captures tagged `@key` and `@value`
4. **Build ParsedVariable list** from the captures
5. **If TreeSitter is unavailable**, fall back to regex-based parsing

You don't need to install TreeSitter parsers — regex fallback works for all formats. But TreeSitter provides better results for complex files.

## Installing TreeSitter Parsers

```vim
:TSInstall json yaml toml xml http hcl dockerfile
```

Or in your config:

```lua
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'json', 'yaml', 'toml', 'xml', 'http', 'hcl', 'dockerfile' },
})
```

## Query Files

### JSON Query

```scheme
;; queries/json/camouflage.scm
(pair
  key: (string) @key
  value: (_) @value)
```

Captures all key-value pairs in JSON objects.

### YAML Query

```scheme
;; queries/yaml/camouflage.scm
(block_mapping_pair
  key: (_) @key
  value: (_) @value)

(flow_pair
  key: (_) @key
  value: (_) @value)
```

Captures block mapping pairs and flow pairs with their values.

### TOML Query

```scheme
;; queries/toml/camouflage.scm
(pair
  key: (_) @key
  value: (_) @value)
```

### XML Query

```scheme
;; queries/xml/camouflage.scm
(element
  (STag
    (Name) @key)
  (content
    (CharData) @value))

(Attribute
  (Name) @key
  (AttValue) @value)
```

Captures both element content and attribute values.

### HTTP Query

```scheme
;; queries/http/camouflage.scm
(variable_declaration
  name: (identifier) @key
  value: (rest_of_line) @value)
```

## Customizing Queries

### Override a Query

Create a file in your Neovim config directory:

```
~/.config/nvim/after/queries/<lang>/camouflage.scm
```

Example — Only mask keys containing "secret", "password", or "key":

```scheme
(pair
  key: (string) @key
  value: (_) @value
  (#match? @key "(secret|password|api_key)"))
```

### Extend a Query

Use the `;extends` directive to add patterns to existing queries without replacing them:

```scheme
;extends

; Your additional patterns here
(pair
  key: (string) @key
  value: (_) @value
  (#match? @key "custom_field"))
```

### Query Location Priority

Queries are loaded in this order:

1. Runtime-registered queries from `register_parser({ treesitter = { query = ... } })`
2. Runtimepath queries, including user overrides such as `~/.config/nvim/after/queries/<lang>/camouflage.scm`
3. Plugin queries such as `queries/<lang>/camouflage.scm`
4. Inline fallback queries defined in `treesitter.lua`

## Debugging TreeSitter

Check if TreeSitter parser is available:

```vim
:lua print(vim.treesitter.language.inspect('json'))
```

View the parse tree:

```vim
:InspectTree
```

Enable debug logging to see TreeSitter detection info:

```lua
require('camouflage').setup({ debug = true })
-- Then check :messages
```

## See Also

- [[Supported File Formats]] — All supported file types
- [[Custom Patterns]] — Regex-based custom patterns for unsupported types
- [[Custom Parsers]] — Runtime parser and inline TreeSitter query registration
