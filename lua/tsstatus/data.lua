-- Status of every tree-sitter parser nvim-treesitter knows about.
--
-- Pure computation: reads the parser registry and the install directory, never
-- installs, never touches the UI. Everything here comes from three public
-- entry points (config.get_available, config.get_installed, the parsers table)
-- plus the `<install_dir>/parser-info/<lang>.revision` files nvim-treesitter
-- writes after a successful install. That is the whole dependency surface, so
-- this module can be lifted out of this config unchanged.

local M = {}

---@alias TSStatusState
---| "installing"   an install is running for it right now
---| "failed"       the last install attempt logged an error
---| "installed"    parser present and at the revision the registry asks for
---| "outdated"     parser present, revision differs (or was never recorded)
---| "missing"      registry has a grammar for it, nothing is installed
---| "queries_only" no grammar of its own; it only ships queries other langs use
---| "orphan"       a parser is installed that the registry no longer lists

---@class TSStatusEntry
---@field lang string
---@field state TSStatusState
---@field tier integer?
---@field wanted string? revision the registry asks for
---@field have string? revision recorded at install time
---@field queries boolean queries directory is present
---@field queries_missing boolean? parser is installed but its queries are not
---@field phase string? live phase, when an install is in flight
---@field message string? last message from the installer

---@class TSStatusReport
---@field entries TSStatusEntry[]
---@field counts table<TSStatusState, integer>
---@field install_dir string

-- Unsupported parsers (tier 4) are never installed by `install("all")`, so
-- counting them as missing would keep the screen permanently red.
local TIER_UNSUPPORTED = 4

---@param dir string
---@param lang string
---@return string?
local function read_revision(dir, lang)
  local file = vim.fs.joinpath(dir, lang .. ".revision")
  local fd = io.open(file, "r")
  if not fd then
    return nil
  end
  local content = fd:read("*a")
  fd:close()
  return vim.trim(content or "")
end

---@param list string[]
---@return table<string, boolean>
local function to_set(list)
  local set = {}
  for _, item in ipairs(list) do
    set[item] = true
  end
  return set
end

---@param progress table<string, TSTrackEntry>? live state from tsstatus.track
---@return TSStatusReport
function M.collect(progress)
  progress = progress or {}
  local config = require("nvim-treesitter.config")
  local parsers = require("nvim-treesitter.parsers")

  local info_dir = config.get_install_dir("parser-info")
  local installed = to_set(config.get_installed("parsers"))
  local queries = to_set(config.get_installed("queries"))

  local entries = {}
  local counts = {
    installing = 0,
    failed = 0,
    installed = 0,
    outdated = 0,
    missing = 0,
    queries_only = 0,
    orphan = 0,
  }

  ---@param entry TSStatusEntry
  local function push(entry)
    -- What the installer is doing right now outranks what the disk shows: a
    -- parser being compiled is neither missing nor installed yet.
    local live = progress[entry.lang]
    if live then
      entry.state = live.phase == "failed" and "failed" or "installing"
      entry.phase = live.phase
      entry.message = live.message
    end
    entries[#entries + 1] = entry
    counts[entry.state] = counts[entry.state] + 1
  end

  for _, lang in ipairs(config.get_available()) do
    local parser = parsers[lang] or {}
    local install_info = parser.install_info

    -- tier 4 is never part of an "all" install, so listing it would leave a
    -- permanent "missing" on screen.
    if parser.tier ~= TIER_UNSUPPORTED then
      if not install_info then
        -- ecma, jsx, html_tags, ... exist only to ship queries for other
        -- languages. They have no parser to install, so looking for a .so here
        -- would report a permanent, meaningless "missing".
        push({
          lang = lang,
          state = "queries_only",
          tier = parser.tier,
          queries = queries[lang] == true,
        })
      elseif not installed[lang] then
        push({
          lang = lang,
          state = "missing",
          tier = parser.tier,
          wanted = install_info.revision,
          queries = queries[lang] == true,
        })
      else
        local wanted = install_info.revision
        local have = read_revision(info_dir, lang)
        -- No pinned revision means the parser tracks a branch; there is nothing
        -- to compare against, so treat it as current rather than guessing.
        local stale = wanted ~= nil and wanted ~= have
        -- Highlighting comes from the queries, not the parser, so a parser
        -- whose queries never landed is broken no matter what its revision
        -- says. It needs a forced reinstall, which is what "outdated" routes to.
        local no_queries = queries[lang] ~= true
        push({
          lang = lang,
          state = (stale or no_queries) and "outdated" or "installed",
          tier = parser.tier,
          wanted = wanted,
          have = have,
          queries = not no_queries,
          queries_missing = no_queries or nil,
        })
      end
    end
  end

  for lang in pairs(installed) do
    if parsers[lang] == nil then
      push({
        lang = lang,
        state = "orphan",
        queries = queries[lang] == true,
      })
    end
  end

  table.sort(entries, function(a, b)
    return a.lang < b.lang
  end)

  return {
    entries = entries,
    counts = counts,
    install_dir = vim.fs.dirname(info_dir),
  }
end

return M
