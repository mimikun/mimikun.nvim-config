---@type string
local datapath = vim.fn.stdpath("data")

---@type tree-sitter-manager.Config
local opts = {
  -- Directory to install compiled parsers into.
  ---@type string
  parser_dir = vim.fs.joinpath(datapath, "site/parser"),

  -- Directory to install query files into.
  ---@type string
  query_dir = vim.fs.joinpath(datapath, "site/queries"),

  -- User-defined language repos to use instead of the built-in ones.
  -- Can either be a string (a git URL), or a more detailed LanguageSpec.
  ---@type table<string, string | tree-sitter-manager.LanguageSpec>
  --languages = require("plugins.tree-sitter-manager-nvim.opts.languages"),

  -- blacklist languages
  assume_installed = require("plugins.tree-sitter-manager-nvim.opts.assume_installed"),

  -- Languages to install on `setup()` if not already present.
  -- Use `"all"` to install all languages.
  ---@type string | string[]
  ensure_installed = require("plugins.tree-sitter-manager-nvim.opts.ensure_installed"),

  -- Install missing parsers automatically on `FileType`.
  ---@type boolean
  auto_install = true,

  -- blacklist from auto_install
  -- Languages to opt-out from `auto_install`.
  ---@type string[]
  noauto_install = require("plugins.tree-sitter-manager-nvim.opts.noauto_install"),

  -- Enable `vim.treesitter.start()` for installe parsers.
  -- `true` enables all, or pass a list of languages.
  ---@type boolean | string[]
  highlight = true,

  -- blacklist from highlight
  -- Languages to isable highlighting for.
  ---@type string[]
  nohighlight = require("plugins.tree-sitter-manager-nvim.opts.nohighlight"),

  -- TUI options
  -- use Nerd Font icons in the manager UI
  -- Enable nerdfont glyphs.
  ---@type boolean
  nerdfont = true,

  -- border style for the TUI window
  -- Border style passed to `nvim_open_win` for the manager UI.
  ---@type string | string[]
  border = "rounded",

  -- Minimum width of the TUI window.
  ---@type number
  min_width = 78,

  -- Minimum height of the TUI window.
  ---@type number
  min_height = 40,
}

return opts
