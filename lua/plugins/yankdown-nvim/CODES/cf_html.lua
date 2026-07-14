--- yankdown.nvim / cf_html
--- Parse CF_HTML clipboard data from Windows.
---
--- CF_HTML is the format used by the Windows clipboard to store HTML data.
--- The payload begins with metadata headers containing byte-offsets that
--- indicate where the HTML fragment starts and ends (0-based byte positions).

local M = {}

-- Escape Lua pattern magic characters so the string is treated literally.
local function literal(s)
  return (s:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", function(c)
    return "%" .. c
  end))
end

local start_fragment_marker = literal("<!--StartFragment-->")
local end_fragment_marker = literal("<!--EndFragment-->")

--- Parse a CF_HTML payload and extract the HTML fragment.
--- When the payload is already plain HTML (no CF_HTML headers), it is
--- returned as-is.
---
---@param payload string|nil Raw clipboard output (CF_HTML or plain HTML)
---@return string|nil html The extracted HTML fragment, or nil
---@return string|nil err "no-html" when no HTML content is found
function M.parse(payload)
  if not payload or payload == "" then
    return nil, "no-html"
  end

  -- Try CF_HTML byte-offset headers first (StartFragment / EndFragment).
  -- Offsets are 0-based byte positions from the start of the string.
  local start_fragment = payload:match("StartFragment:(%d+)")
  local end_fragment = payload:match("EndFragment:(%d+)")
  local start_html = payload:match("StartHTML:(%d+)")
  local end_html = payload:match("EndHTML:(%d+)")

  if start_fragment and end_fragment then
    local s = tonumber(start_fragment)
    local e = tonumber(end_fragment)
    if s and e and e > s then
      -- Offsets are 0-based; Lua string.sub is 1-based.
      local b = math.max(s + 1, 1)
      local len = #payload
      if b > len then
        return nil, "no-html"
      end
      local out = payload:sub(b, math.min(e, len))
      -- Strip the CF_HTML fragment markers if present.
      out = out:gsub(start_fragment_marker, "", 1)
      out = out:gsub(end_fragment_marker, "", 1)
      if out == "" then
        return nil, "no-html"
      end
      return out, nil
    end
  end

  -- Fall back to StartHTML / EndHTML if fragment offsets are missing.
  if start_html and end_html then
    local s = tonumber(start_html)
    local e = tonumber(end_html)
    if s and e and e > s then
      local b = math.max(s + 1, 1)
      local len = #payload
      if b > len then
        return nil, "no-html"
      end
      return payload:sub(b, math.min(e, len)), nil
    end
  end

  -- Plain HTML fallback: if the payload starts with '<' (after whitespace),
  -- treat it as raw HTML.
  if payload:match("^%s*<") then
    return payload, nil
  end

  return nil, "no-html"
end

return M
