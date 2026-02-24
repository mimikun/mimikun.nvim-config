-- `key` is a string pattern you want to match, `value` is a table of hint message and pattern length.
-- Learn more about Lua string pattern (https://www.lua.org/pil/20.2.html).
---@type table
local hints = {
  ["%D1[hjkl]"] = {
    message = function(keys)
      return "Use " .. keys:sub(3, 3) .. " instead of " .. keys:sub(2, 3)
    end,
    length = 3,
  },
  ["[kj][%^_]"] = {
    message = function(key)
      return "Use " .. (key:sub(1, 1) == "k" and "-" or "<CR> or +") .. " instead of " .. key
    end,
    length = 2,
  },
  ["%$a"] = {
    message = function()
      return "Use A instead of $a"
    end,
    length = 2,
  },
  ["d%$"] = {
    message = function()
      return "Use D instead of d$"
    end,
    length = 2,
  },
  ["y%$"] = {
    message = function()
      return "Use Y instead of y$"
    end,
    length = 2,
  },
  ["c%$"] = {
    message = function()
      return "Use C instead of c$"
    end,
    length = 2,
  },
  ["%^i"] = {
    message = function()
      return "Use I instead of ^i"
    end,
    length = 2,
  },
  ["%D[j+]O"] = {
    message = function(keys)
      return "Use o instead of " .. keys:sub(2)
    end,
    length = 3,
  },
  ["[^fFtT]li"] = {
    message = function()
      return "Use a instead of li"
    end,
    length = 3,
  },
  ["2([dcy=<>])%1"] = {
    message = function(key)
      return "Use " .. key:sub(3) .. "j instead of " .. key
    end,
    length = 3,
  },

  -- hints for f/F/t/T
  ["[^dcy=]f.h"] = {
    message = function(keys)
      return "Use t" .. keys:sub(3, 3) .. " instead of " .. keys:sub(2)
    end,
    length = 4,
  },
  ["[^dcy=]F.l"] = {
    message = function(keys)
      return "Use T" .. keys:sub(3, 3) .. " instead of " .. keys:sub(2)
    end,
    length = 4,
  },
  ["[^dcy=]T.h"] = {
    message = function(keys)
      return "Use F" .. keys:sub(3, 3) .. " instead of " .. keys:sub(2)
    end,
    length = 4,
  },
  ["[^dcy=]t.l"] = {
    message = function(keys)
      return "Use f" .. keys:sub(3, 3) .. " instead of " .. keys:sub(2)
    end,
    length = 4,
  },

  -- iquote and aquote
  ["[^dcy]F[{%[(][dcy]f[}%])]"] = {
    message = function(keys)
      return "Use " .. keys:sub(4, 4) .. "a" .. keys:sub(3, 3) .. " instead of " .. keys:sub(2)
    end,
    length = 6,
  },
  ["[^dcy]T[{%[('\"`][dcy]t[}%])'\"]"] = {
    message = function(keys)
      return "Use " .. keys:sub(4, 4) .. "i" .. keys:sub(3, 3) .. " instead of " .. keys:sub(2)
    end,
    length = 6,
  },
  ["[^dcy]f[}%])'\"`][dcy]T[{%[('\"]"] = {
    message = function(keys)
      return "Use " .. keys:sub(4, 4) .. "i" .. keys:sub(6, 6) .. " instead of " .. keys:sub(2)
    end,
    length = 6,
  },

  -- hints for delete + insert
  ["d[bBwWeE%^%$]i"] = {
    message = function(keys)
      return "Use " .. "c" .. keys:sub(2, 2) .. " instead of " .. keys
    end,
    length = 3,
  },
  ["dg[eE]i"] = {
    message = function(keys)
      return "Use " .. "c" .. keys:sub(2, 3) .. " instead of " .. keys
    end,
    length = 4,
  },
  ["d[tTfF].i"] = {
    message = function(keys)
      return "Use " .. "c" .. keys:sub(2, 3) .. " instead of " .. keys
    end,
    length = 4,
  },
  ["d[ia][\"'`{}%[%]()<>bBwWspt]i"] = {
    message = function(keys)
      return "Use " .. "c" .. keys:sub(2, 3) .. " instead of " .. keys
    end,
    length = 4,
  },
  ["D[aA]"] = {
    message = function(keys)
      return "Use C instead of D" .. keys:sub(2)
    end,
    length = 2,
  },

  -- hints for unnecessary visual mode
  ["Vgg[dcy=<>]"] = {
    message = function(keys)
      return "Use " .. keys:sub(4, 4) .. "gg instead of " .. keys
    end,
    length = 4,
  },
  ['Vgg".[dy]'] = {
    message = function(keys)
      return "Use " .. keys:sub(4, 6) .. "gg instead of " .. keys
    end,
    length = 6,
  },
  ["VG[dcy=<>]"] = {
    message = function(keys)
      return "Use " .. keys:sub(3, 3) .. "G instead of " .. keys
    end,
    length = 3,
  },
  ['VG".[dy]'] = {
    message = function(keys)
      return "Use " .. keys:sub(3, 5) .. "G instead of " .. keys
    end,
    length = 5,
  },
  ["V%d[kj][dcy=<>]"] = {
    message = function(keys)
      return "Use " .. keys:sub(4, 4) .. keys:sub(2, 3) .. " instead of " .. keys
    end,
    length = 4,
  },
  ['V%d[kj]".[dy]'] = {
    message = function(keys)
      return "Use " .. keys:sub(4, 6) .. keys:sub(2, 3) .. " instead of " .. keys
    end,
    length = 6,
  },
  ["V%d%d[kj][dcy=<>]"] = {
    message = function(keys)
      return "Use " .. keys:sub(5, 5) .. keys:sub(2, 4) .. " instead of " .. keys
    end,
    length = 5,
  },
  ['V%d%d[kj]".[dy]'] = {
    message = function(keys)
      return "Use " .. keys:sub(5, 7) .. keys:sub(2, 4) .. " instead of " .. keys
    end,
    length = 7,
  },
  ["[vV][eE][dcy]"] = {
    message = function(keys)
      return "Use " .. keys:sub(3, 3) .. keys:sub(2, 2) .. " instead of " .. keys
    end,
    length = 3,
  },
  ['[vV][eE]".[dy]'] = {
    message = function(keys)
      return "Use " .. keys:sub(3, 5) .. keys:sub(2, 2) .. " instead of " .. keys
    end,
    length = 5,
  },
  ["[vV]g[eE][dcy]"] = {
    message = function(keys)
      return "Use " .. keys:sub(4, 4) .. keys:sub(2, 3) .. " instead of " .. keys
    end,
    length = 4,
  },
  ['[vV]g[eE]".[dy]'] = {
    message = function(keys)
      return "Use " .. keys:sub(4, 6) .. keys:sub(2, 3) .. " instead of " .. keys
    end,
    length = 6,
  },
  ["[vV][tTfF].[dcy]"] = {
    message = function(keys)
      return "Use " .. keys:sub(4, 4) .. keys:sub(2, 3) .. " instead of " .. keys
    end,
    length = 4,
  },
  ['[vV][tTfF].".[dy]'] = {
    message = function(keys)
      return "Use " .. keys:sub(4, 6) .. keys:sub(2, 3) .. " instead of " .. keys
    end,
    length = 6,
  },
  ["[vV][ia][\"'`{}%[%]()<>bBwWspt][dcy=<>]"] = {
    message = function(keys)
      return "Use " .. keys:sub(4, 4) .. keys:sub(2, 3) .. " instead of " .. keys
    end,
    length = 4,
  },
  ['[vV][ia]["\'`{}%[%]()<>bBwWspt]".[dy]'] = {
    message = function(keys)
      return "Use " .. keys:sub(4, 6) .. keys:sub(2, 3) .. " instead of " .. keys
    end,
    length = 6,
  },
  -- NOTE: Exampples

  --["k%^"] = {
  --  message = function()
  --    return "Use - instead of k^" -- return the hint message you want to display
  --  end,
  --  length = 2, -- the length of actual key strokes that matches this pattern
  --},
  --["d[tTfF].i"] = { -- this matches d + {t/T/f/F} + {any character} + i
  --  message = function(keys) -- keys is a string of key strokes that matches the pattern
  --    return "Use " .. "c" .. keys:sub(2, 3) .. " instead of " .. keys
  --    -- example: Use ct( instead of dt(i
  --  end,
  --  length = 4,
  --},
}

return hints
