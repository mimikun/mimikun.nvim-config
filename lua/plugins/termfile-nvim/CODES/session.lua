-- Reading and writing the raw output recording stored in a `.term` file.
--
-- A `.term` file is simply the raw byte stream a terminal session produced --
-- escape sequences, colors and all. It is not a script the user edits by hand;
-- opening it replays that stream into a fresh terminal, which re-renders it
-- (colors included) natively. Because it is still an ordinary file it continues
-- to work with file pickers, `:buffers`, and the like.
--
-- The working directory rides along inside the same raw stream as an OSC 7
-- escape sequence (`ESC ] 7 ; file://host/path ST`) -- the standard, invisible
-- way terminals report a shell's current directory. We append one on save and
-- read the last one back on open, so cwd survives without any side-channel
-- metadata.

local M = {}

--- Read the raw recording stored in a `.term` file.
---@param path string absolute path to the `.term` file
---@return string|nil bytes, or nil when the file is missing/empty
function M.read_raw(path)
  local fd = io.open(path, "rb")
  if not fd then
    return nil
  end
  local data = fd:read("*a")
  fd:close()
  if not data or data == "" then
    return nil
  end
  return data
end

--- Write `data` (raw bytes) to `path`.
---@param path string
---@param data string
---@return boolean ok
function M.write_raw(path, data)
  local fd = io.open(path, "wb")
  if not fd then
    return false
  end
  fd:write(data or "")
  fd:close()
  return true
end

local function url_decode(s)
  return (s:gsub("%%(%x%x)", function(h)
    return string.char(tonumber(h, 16))
  end))
end

local function url_encode_path(p)
  return (p:gsub("[^%w%-%._~/]", function(c)
    return string.format("%%%02X", string.byte(c))
  end))
end

--- Build an OSC 7 "current working directory" escape sequence. It renders as
--- nothing but lets a terminal (and us) recover the directory later.
---@param path string
---@return string
function M.osc7(path)
  return "\27]7;file://" .. url_encode_path(path) .. "\27\\"
end

--- Recover the last working directory reported via OSC 7 in a raw recording.
---@param data string|nil
---@return string|nil
function M.cwd_from_recording(data)
  if not data then
    return nil
  end
  local last
  local prefix = "\27]7;"
  local init = 1
  while true do
    local s = data:find(prefix, init, true)
    if not s then
      break
    end
    local body_start = s + #prefix
    local st = data:find("\27\\", body_start, true) -- ST terminator
    local bel = data:find("\7", body_start, true) -- BEL terminator
    local e
    if st and bel then
      e = math.min(st, bel)
    else
      e = st or bel
    end
    if not e then
      break
    end
    last = data:sub(body_start, e - 1)
    init = e + 1
  end
  if not last then
    return nil
  end
  local path = last:match("^file://[^/]*(/.*)$")
  if not path then
    return nil
  end
  return url_decode(path)
end

return M
