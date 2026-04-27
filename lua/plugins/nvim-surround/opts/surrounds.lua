local config = require("nvim-surround.config")

---@type table
local surrounds = {
  ["("] = {
    add = {
      "( ",
      " )",
    },
    find = function()
      return config.get_selection({
        motion = "a(",
      })
    end,
    delete = "^(. ?)().-( ?.)()$",
  },
  [")"] = {
    add = {
      "(",
      ")",
    },
    find = function()
      return config.get_selection({
        motion = "a)",
      })
    end,
    delete = "^(.)().-(.)()$",
  },
  ["{"] = {
    add = {
      "{ ",
      " }",
    },
    find = function()
      return config.get_selection({
        motion = "a{",
      })
    end,
    delete = "^(. ?)().-( ?.)()$",
  },
  ["}"] = {
    add = {
      "{",
      "}",
    },
    find = function()
      return config.get_selection({
        motion = "a}",
      })
    end,
    delete = "^(.)().-(.)()$",
  },
  ["<"] = {
    add = {
      "< ",
      " >",
    },
    find = function()
      return config.get_selection({
        motion = "a<",
      })
    end,
    delete = "^(. ?)().-( ?.)()$",
  },
  [">"] = {
    add = {
      "<",
      ">",
    },
    find = function()
      return config.get_selection({
        motion = "a>",
      })
    end,
    delete = "^(.)().-(.)()$",
  },
  ["["] = {
    add = {
      "[ ",
      " ]",
    },
    find = function()
      return config.get_selection({
        motion = "a[",
      })
    end,
    delete = "^(. ?)().-( ?.)()$",
  },
  ["]"] = {
    add = {
      "[",
      "]",
    },
    find = function()
      return config.get_selection({
        motion = "a]",
      })
    end,
    delete = "^(.)().-(.)()$",
  },
  ["'"] = {
    add = {
      "'",
      "'",
    },
    find = function()
      return config.get_selection({
        motion = "a'",
      })
    end,
    delete = "^(.)().-(.)()$",
  },
  ['"'] = {
    add = {
      '"',
      '"',
    },
    find = function()
      return config.get_selection({
        motion = 'a"',
      })
    end,
    delete = "^(.)().-(.)()$",
  },
  ["`"] = {
    add = {
      "`",
      "`",
    },
    find = function()
      return config.get_selection({
        motion = "a`",
      })
    end,
    delete = "^(.)().-(.)()$",
  },
  -- TODO: Add find/delete/change functions
  ["i"] = {
    add = function()
      local left_delimiter = config.get_input("Enter the left delimiter: ")
      local right_delimiter = left_delimiter and config.get_input("Enter the right delimiter: ")
      if right_delimiter then
        return {
          { left_delimiter },
          { right_delimiter },
        }
      end
    end,
    find = function()
      -- NOTE: it
    end,
    delete = function()
      -- NOTE: it
    end,
  },
  ["t"] = {
    add = function()
      local user_input = config.get_input("Enter the HTconfigL tag: ")
      if user_input then
        local element = user_input:match("^<?([^%s>]*)")
        local attributes = user_input:match("^<?[^%s>]*%s+(.-)>?$")

        local open = attributes and element .. " " .. attributes or element
        local close = element

        return {
          { "<" .. open .. ">" },
          { "</" .. close .. ">" },
        }
      end
    end,
    find = function()
      return config.get_selection({
        motion = "at",
      })
    end,
    delete = "^(%b<>)().-(%b<>)()$",
    change = {
      target = "^<([^%s<>]*)().-([^/]*)()>$",
      replacement = function()
        local user_input = config.get_input("Enter the HTconfigL tag: ")
        if user_input then
          local element = user_input:match("^<?([^%s>]*)")
          local attributes = user_input:match("^<?[^%s>]*%s+(.-)>?$")

          local open = attributes and element .. " " .. attributes or element
          local close = element

          return {
            { open },
            { close },
          }
        end
      end,
    },
  },
  ["T"] = {
    add = function()
      local user_input = config.get_input("Enter the HTconfigL tag: ")
      if user_input then
        local element = user_input:match("^<?([^%s>]*)")
        local attributes = user_input:match("^<?[^%s>]*%s+(.-)>?$")

        local open = attributes and element .. " " .. attributes or element
        local close = element

        return {
          { "<" .. open .. ">" },
          { "</" .. close .. ">" },
        }
      end
    end,
    find = function()
      return config.get_selection({
        motion = "at",
      })
    end,
    delete = "^(%b<>)().-(%b<>)()$",
    change = {
      target = "^<([^>]*)().-([^/]*)()>$",
      replacement = function()
        local user_input = config.get_input("Enter the HTconfigL tag: ")
        if user_input then
          local element = user_input:match("^<?([^%s>]*)")
          local attributes = user_input:match("^<?[^%s>]*%s+(.-)>?$")

          local open = attributes and element .. " " .. attributes or element
          local close = element

          return {
            { open },
            { close },
          }
        end
      end,
    },
  },
  ["f"] = {
    add = function()
      local result = config.get_input("Enter the function name: ")
      if result then
        return {
          { result .. "(" },
          { ")" },
        }
      end
    end,
    find = function()
      local selection = config.get_selection({
        query = {
          capture = "@call.outer",
          type = "textobjects",
        },
      })

      -- We prioritize TreeSitter-based selections if they exist, otherwise fallback on pattern-based search
      if selection then
        return selection
      end
      return config.get_selection({
        pattern = "[^=%s%(%){}]+%b()",
      })
    end,
    delete = "^(.-%()().-(%))()$",
    change = {
      target = "^.-([%w_]+)()%(.-%)()()$",
      replacement = function()
        local result = config.get_input("Enter the function name: ")
        if result then
          return {
            { result },
            { "" },
          }
        end
      end,
    },
  },
  invalid_key_behavior = {
    -- By default, we ignore control characters for adding/finding because they are more likely typos than intentional.
    -- We choose NOT to for deletion, as users could have redefined the find key to something like ‘.-’.
    -- In this case we should still trim a character from each side, instead of early returning nil.
    add = function(char)
      if not char or char:find("%c") then
        return nil
      end
      return {
        { char },
        { char },
      }
    end,
    find = function(char)
      if not char or char:find("%c") then
        return nil
      end
      return config.get_selection({
        pattern = vim.pesc(char) .. ".-" .. vim.pesc(char),
      })
    end,
    delete = function(char)
      if not char then
        return nil
      end
      return config.get_selections({
        char = char,
        pattern = "^(.)().-(.)()$",
      })
    end,
  },
}

return surrounds
