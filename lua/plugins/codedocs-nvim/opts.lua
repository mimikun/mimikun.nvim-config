---@type CodedocsConfig
local opts = {
  -- Log entries whose level is >= `level` are appended to `path`.
  -- The file is never rotated and codedocs logs on every `setup()` call and on every annotation it generates, so the upstream INFO default grows the file forever.
  -- WARN keeps real problems and drops the per-annotation chatter.
  logging = {
    ---@type integer
    level = vim.log.levels.WARN,

    ---@type string
    path = vim.fs.joinpath(vim.fn.stdpath("log"), "codedocs.log"),
  },

  -- `languages` is built at load time from codedocs' own `lua/codedocs/config/languages/<lang>/`;
  -- the full table (styles, blocks, layouts, tree-sitter targets) is far too large to vendor here.
  -- Only the deltas are written below;
  -- everything else stays at upstream defaults.

  -- The filetype -> language map comes from each language's `filetypes` list, so adding a filetype here is how you widen detection,
  -- e.g. bash = { filetypes = { "sh", "bash" } }
  -- Note: `aliases` is documented in codedocs' type annotations but is not read by any code path (checked against the vendored source), so it does nothing.
  languages = {
    -- Every other supported language ships exactly one style, so its `default_style` has nothing to switch to.
    -- These two are the exceptions.
    lua = {
      filetypes = {
        "lua",
      },

      -- "EmmyLua" (LuaLS `---@param` / `---@return`) or "LDoc".
      -- EmmyLua is what lazydev / LuaLS reads in this config.
      default_style = "EmmyLua",
    },

    python = {
      -- Neovim filetypes associated with this language
      filetypes = {
        "python",
      },

      -- "reST" (upstream default), "Google" or "NumPy"
      default_style = "reST",
    },
  },
}

return opts
