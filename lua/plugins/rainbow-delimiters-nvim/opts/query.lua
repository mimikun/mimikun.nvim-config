---@field ['']         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field astro        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field bash         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field c            (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field c_sharp      (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field clojure      (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field commonlisp   (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field cpp          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field css          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field cuda         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field cue          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field dart         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field elixir       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field elm          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field fennel       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field fish         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field glsl         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field go           (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field groovy       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field haskell      (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field hcl          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field html         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field janet_simple (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field java         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field javascript   (('rainbow-delimiters' | 'rainbow-parens' | 'rainbow-delimiters-react' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-parens' | 'rainbow-delimiters-react' | string))?
---@field json         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field json5        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field jsonc        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field jsonnet      (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field julia        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field kdl          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field kotlin       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field latex        (('rainbow-delimiters' | 'rainbow-blocks' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-blocks' | string))?
---@field lua          (('rainbow-delimiters' | 'rainbow-blocks' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-blocks' | string))?
---@field luadoc       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field make         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field markdown     (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field nickel       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field nim          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field nix          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field nu           (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field ocaml        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field odin         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field perl         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field php          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field python       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field qmljs        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field query        (('rainbow-delimiters' | 'rainbow-blocks' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-blocks' | string))?
---@field r            (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field racket       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field rasi         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field regex        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field rst          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field ruby         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field rust         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field scheme       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field scss         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field sql          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field starlark     (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field templ        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field terraform    (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field toml         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field tsx          (('rainbow-delimiters' | 'rainbow-parens' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-parens' | string))?
---@field typescript   (('rainbow-delimiters' | 'rainbow-parens' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-parens' | string))?
---@field typst        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field verilog      (('rainbow-delimiters' | 'rainbow-blocks' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-blocks' | string))?
---@field vim          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field vimdoc       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field vue          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field wgsl         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field yaml         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field yuck         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field zig          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?

-- Query names by file type
-- Query to use for highlighting
---@type rainbow_delimiters.config.queries
local query = {
  -- Use parentheses by default
  [""] = "rainbow-delimiters",
  javascript = "rainbow-delimiters-react",
  -- Use blocks for Lua
  lua = "rainbow-blocks",
  latex = "rainbow-blocks",
  -- Determine the query dynamically
  query = function(bufnr)
    -- Use blocks for read-only buffers like in `:InspectTree`
    local is_nofile = vim.bo[bufnr].buftype == "nofile"
    return is_nofile and "rainbow-blocks" or "rainbow-delimiters"
  end,
}

return query
