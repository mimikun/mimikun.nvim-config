---@alias rainbow_delimiters.language
---| 'astro'
---| 'bash'
---| 'c'
---| 'c_sharp'
---| 'clojure'
---| 'commonlisp'
---| 'cpp'
---| 'css'
---| 'cuda'
---| 'cue'
---| 'dart'
---| 'elixir'
---| 'elm'
---| 'fennel'
---| 'fish'
---| 'go'
---| 'groovy'
---| 'haskell'
---| 'hcl'
---| 'html'
---| 'janet_simple'
---| 'java'
---| 'javascript'
---| 'json'
---| 'json5'
---| 'jsonc'
---| 'jsonnet'
---| 'julia'
---| 'kdl'
---| 'kotlin'
---| 'latex'
---| 'lua'
---| 'luadoc'
---| 'make'
---| 'markdown'
---| 'nickel'
---| 'nim'
---| 'nix'
---| 'nu'
---| 'ocaml'
---| 'odin'
---| 'perl'
---| 'php'
---| 'python'
---| 'qmljs'
---| 'query'
---| 'r'
---| 'racket'
---| 'rasi'
---| 'regex'
---| 'rst'
---| 'ruby'
---| 'rust'
---| 'scheme'
---| 'scss'
---| 'sql'
---| 'starlark'
---| 'templ'
---| 'terraform'
---| 'toml'
---| 'tsx'
---| 'typescript'
---| 'typst'
---| 'verilog'
---| 'vim'
---| 'vimdoc'
---| 'vue'
---| 'wgsl'
---| 'yaml'
---| 'yuck'
---| 'zig'
---User defined language, not part of rainbow_delimiters support
---| string

---@type rainbow_delimiters.config
local opts = {
  -- Highlight strategies by file type
  -- Strategy to use for highlighting
  ---@type rainbow_delimiters.config.strategies?
  strategy = require("plugins.rainbow-delimiters-nvim.opts.strategy"),

  -- Query names by file type
  -- Query to use for highlighting
  ---@type rainbow_delimiters.config.queries
  query = require("plugins.rainbow-delimiters-nvim.opts.query"),

  -- Highlight priority of rainbow delimiters
  ---@type rainbow_delimiters.config.priorities
  priority = require("plugins.rainbow-delimiters-nvim.opts.priority"),

  -- Highlight groups in order of display
  -- Highlight colors
  ---@type string[]
  highlight = require("plugins.rainbow-delimiters-nvim.opts.highlight"),

  -- Whitelist for languages to highlight
  ---@type rainbow_delimiters.language[]
  whitelist = require("plugins.rainbow-delimiters-nvim.opts.whitelist"),

  -- Blacklist for languages not to highlight
  ---@type rainbow_delimiters.language[]
  blacklist = require("plugins.rainbow-delimiters-nvim.opts.blacklist"),

  -- Dynamic condition whether to enable rainbow highlighting
  ---@type (fun(bufnr: number): boolean)
  condition = require("plugins.rainbow-delimiters-nvim.opts.condition"),

  ---@class (exact) rainbow_delimiters.logging
  ---@field file ('rainbow_delimiters.log' | string)?
  ---@field level integer
  -- Logging with log file and log level
  ---@type rainbow_delimiters.logging
  log = require("plugins.rainbow-delimiters-nvim.opts.log"),
}

return opts
