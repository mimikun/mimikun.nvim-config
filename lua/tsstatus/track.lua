-- Live per-parser progress, recovered from nvim-treesitter's logger.
--
-- The installer exposes no progress callback: install() returns a single task
-- for the whole batch, and everything that happens per language goes to
-- nvim-treesitter.log instead. But it goes there with the language in the
-- logger's context (`log.new("install/" .. lang)`) and with phase messages
-- ("Downloading ...", "Compiling parser", "Language installed"), which is
-- enough to reconstruct the state of every parser as it moves.
--
-- So this wraps two functions: log.new (a language started) and the Logger
-- methods that carry the phase. Wrapping is confined to this file, and the
-- screen still works without it -- the filesystem view in data.lua stands on
-- its own, this only adds the moving parts.

local M = {}

---@alias TSTrackPhase "queued"|"downloading"|"generating"|"compiling"|"installing"|"failed"

---@class TSTrackEntry
---@field phase TSTrackPhase
---@field message string?
---@field started integer uv.now() at the first event for this language

---@type table<string, TSTrackEntry>
local state = {}

---@type table<integer, function>
local subscribers = {}
local next_subscriber = 1

local hooked = false

-- Message prefixes the installer logs through the per-language logger.
local PHASES = {
  ["Downloading"] = "downloading",
  ["Generating"] = "generating",
  ["Compiling"] = "compiling",
  ["Installing"] = "installing",
}

local DONE = {
  ["Language installed"] = true,
  ["Language uninstalled"] = true,
}

local function changed()
  for _, fn in pairs(subscribers) do
    pcall(fn)
  end
end

---@param ctx string?
---@return string? lang
local function lang_of(ctx)
  if type(ctx) ~= "string" then
    return nil
  end
  return ctx:match("^install/(.+)$") or ctx:match("^uninstall/(.+)$")
end

---@param lang string
---@param phase TSTrackPhase
---@param message string?
local function set(lang, phase, message)
  local previous = state[lang]
  state[lang] = {
    phase = phase,
    message = message,
    started = previous and previous.started or vim.uv.now(),
  }
  changed()
end

---Install the hooks. Idempotent, and safe to call before nvim-treesitter has
---been configured.
---@return boolean ok
function M.setup()
  if hooked then
    return true
  end

  local ok, log = pcall(require, "nvim-treesitter.log")
  if not ok then
    return false
  end

  local new = log.new
  log.new = function(ctx)
    local lang = lang_of(ctx)
    if lang then
      -- The logger is created at the top of try_install_lang, so this is the
      -- moment the language leaves the queue.
      set(lang, "queued")
    end
    return new(ctx)
  end

  -- Every logger instance resolves its methods through this one table, so
  -- replacing them here covers loggers created before and after setup().
  local logger = log.Logger

  local info = logger.info
  logger.info = function(self, message, ...)
    local lang = lang_of(self.ctx)
    if lang then
      local text = select("#", ...) > 0 and message:format(...) or message
      if DONE[text] then
        state[lang] = nil
        changed()
      else
        set(lang, PHASES[text:match("^%a+")] or "installing", text)
      end
    end
    return info(self, message, ...)
  end

  local err = logger.error
  logger.error = function(self, message, ...)
    local text = err(self, message, ...)
    local lang = lang_of(self.ctx)
    if lang then
      set(lang, "failed", text)
    end
    return text
  end

  hooked = true
  return true
end

---@return table<string, TSTrackEntry>
function M.state()
  return state
end

---@return boolean
function M.busy()
  for _, entry in pairs(state) do
    if entry.phase ~= "failed" then
      return true
    end
  end
  return false
end

---Drop tracking for languages that reached a healthy state on disk, so a
---failure from an earlier run stops being reported once it is fixed.
---@param healthy table<string, boolean>
function M.settle(healthy)
  local dropped = false
  for lang, entry in pairs(state) do
    if healthy[lang] and entry.phase == "failed" then
      state[lang] = nil
      dropped = true
    end
  end
  if dropped then
    changed()
  end
end

---@param fn function
---@return integer id
function M.subscribe(fn)
  local id = next_subscriber
  next_subscriber = id + 1
  subscribers[id] = fn
  return id
end

---@param id integer
function M.unsubscribe(id)
  subscribers[id] = nil
end

return M
