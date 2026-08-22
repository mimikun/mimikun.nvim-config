local urls = {
  ---@type boolean
  enable = true,

  ---@type url.opts
  default = {
    icon = "󰌷 ",
    hl = "@string.special.url.vimdoc",
  },

  ---@type url.opts
  ["github%.com/[%a%d%-%_%.]+%/?$"] = {
    --- github.com/<user>
    icon = " ",
    hl = "HelpviewPalette0Fg",

    text = function(_, item)
      return string.match(item.label, "github%.com/([%a%d%-%_%.]+)%/?$")
    end,
  },
  ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/?$"] = {
    --- github.com/<user>/<repo>
    icon = "󰳐 ",
    hl = "HelpviewPalette0Fg",

    text = function(_, item)
      return string.match(item.label, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/?$")
    end,
  },
  ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+/tree/[%a%d%-%_%.]+%/?$"] = {
    --- github.com/<user>/<repo>/tree/<branch>
    icon = " ",
    hl = "HelpviewPalette0Fg",

    text = function(_, item)
      local repo, branch =
        string.match(item.label, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)/tree/([%a%d%-%_%.]+)%/?$")
      return repo .. " at " .. branch
    end,
  },
  ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+/commits/[%a%d%-%_%.]+%/?$"] = {
    --- github.com/<user>/<repo>/commits/<branch>
    icon = " ",
    hl = "HelpviewPalette0Fg",

    text = function(_, item)
      return string.match(item.label, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+/commits/[%a%d%-%_%.]+)%/?$")
    end,
  },

  ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/releases$"] = {
    --- github.com/<user>/<repo>/releases
    icon = " ",
    hl = "HelpviewPalette0Fg",

    text = function(_, item)
      return "Releases • " .. string.match(item.label, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/releases$")
    end,
  },
  ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/tags$"] = {
    --- github.com/<user>/<repo>/tags
    icon = " ",
    hl = "HelpviewPalette0Fg",

    text = function(_, item)
      return "Tags • " .. string.match(item.label, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/tags$")
    end,
  },
  ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/issues$"] = {
    --- github.com/<user>/<repo>/issues
    icon = " ",
    hl = "HelpviewPalette0Fg",

    text = function(_, item)
      return "Issues • " .. string.match(item.label, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/issues$")
    end,
  },
  ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/pulls$"] = {
    --- github.com/<user>/<repo>/pulls
    icon = " ",
    hl = "HelpviewPalette0Fg",

    text = function(_, item)
      return "Pull requests • " .. string.match(item.label, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/pulls$")
    end,
  },

  ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/wiki$"] = {
    --- github.com/<user>/<repo>/wiki
    icon = " ",
    hl = "HelpviewPalette0Fg",

    text = function(_, item)
      return "Wiki • " .. string.match(item.label, "github%.com/([%a%d%-%_%.]+/[%a%d%-%_%.]+)%/wiki$")
    end,
  },

  ["developer%.mozilla%.org"] = {
    priority = -9999,

    icon = "󰖟 ",
    hl = "HelpviewPalette5Fg",
  },

  ["w3schools%.com"] = {
    priority = -9999,

    icon = " ",
    hl = "HelpviewPalette4Fg",
  },

  ["stackoverflow%.com"] = {
    priority = -9999,

    icon = "󰓌 ",
    hl = "HelpviewPalette2Fg",
  },

  ["reddit%.com"] = {
    priority = -9999,

    icon = " ",
    hl = "HelpviewPalette2Fg",
  },

  ["github%.com"] = {
    priority = -9999,

    icon = " ",
    hl = "HelpviewPalette6Fg",
  },

  ["gitlab%.com"] = {
    priority = -9999,

    icon = " ",
    hl = "HelpviewPalette2Fg",
  },

  ["dev%.to"] = {
    priority = -9999,

    icon = "󱁴 ",
    hl = "HelpviewPalette0Fg",
  },

  ["codepen%.io"] = {
    priority = 9999,

    icon = " ",
    hl = "HelpviewPalette6Fg",
  },

  ["replit%.com"] = {
    priority = -9999,

    icon = " ",
    hl = "HelpviewPalette2Fg",
  },

  ["jsfiddle%.net"] = {
    priority = -9999,

    icon = " ",
    hl = "HelpviewPalette5Fg",
  },

  ["npmjs%.com"] = {
    priority = -9999,

    icon = " ",
    hl = "HelpviewPalette0Fg",
  },

  ["pypi%.org"] = {
    priority = -9999,

    icon = "󰆦 ",
    hl = "HelpviewPalette0Fg",
  },

  ["mvnrepository%.com"] = {
    priority = -9999,

    icon = " ",
    hl = "HelpviewPalette1Fg",
  },

  ["medium%.com"] = {
    priority = -9999,

    icon = " ",
    hl = "HelpviewPalette6Fg",
  },

  ["linkedin%.com"] = {
    priority = -9999,

    icon = "󰌻 ",
    hl = "HelpviewPalette5Fg",
  },

  ["news%.ycombinator%.com"] = {
    priority = -9999,

    icon = " ",
    hl = "HelpviewPalette2Fg",
  },

  ["neovim%.io/doc/user/.*#%_?.*$"] = {
    icon = " ",
    hl = "HelpviewPalette4Fg",

    text = function(_, item)
      local file, tag = string.match(item.label, "neovim%.io/doc/user/(.*)#%_?(.*)$")
      --- The actual website seems to show
      --- _ in the site name so, we won't
      --- be replacing `_`s with ` `s.
      file = string.gsub(file, "%.html$", "")

      return string.format("%s(%s) - Neovim docs", utils.normalize_str(file), tag)
    end,
  },

  ["neovim%.io/doc/user/.*$"] = {
    icon = " ",
    hl = "HelpviewPalette4Fg",

    text = function(_, item)
      local file = string.match(item.label, "neovim%.io/doc/user/(.*)$")
      file = string.gsub(file, "%.html$", "")

      return string.format("%s - Neovim docs", utils.normalize_str(file))
    end,
  },

  ["github%.com/vim/vim"] = {
    priority = -100,

    icon = " ",
    hl = "HelpviewPalette4Fg",
  },

  ["github%.com/neovim/neovim"] = {
    priority = -100,

    icon = " ",
    hl = "HelpviewPalette4Fg",
  },

  ["vim%.org"] = {
    icon = " ",
    hl = "HelpviewPalette4Fg",
  },

  ["luals%.github%.io/wiki/?.*$"] = {
    icon = " ",
    hl = "HelpviewPalette5Fg",

    text = function(_, item)
      if string.match(item.label, "luals%.github%.io/wiki/(.-)/#(.+)$") then
        local page_mappings = {
          annotations = {
            ["as"] = "@as",
            ["alias"] = "@alias",
            ["async"] = "@async",
            ["cast"] = "@cast",
            ["class"] = "@class",
            ["deprecated"] = "@deprecated",
            ["diagnostic"] = "@diagnostic",
            ["enum"] = "@enum",
            ["field"] = "@field",
            ["generic"] = "@generic",
            ["meta"] = "@meta",
            ["module"] = "@module",
            ["nodiscard"] = "@nodiscard",
            ["operator"] = "@operator",
            ["overload"] = "@overload",
            ["package"] = "@package",
            ["param"] = "@param",
            ["see"] = "@see",
            ["source"] = "@source",
            ["type"] = "@type",
            ["vaarg"] = "@vaarg",
            ["version"] = "@version",
          },
        }

        local page, section = string.match(item.label, "luals%.github%.io/wiki/(.-)/#(.+)$")

        if page_mappings[page] and page_mappings[page][section] then
          section = page_mappings[page][section]
        else
          section = utils.normalize_str(string.gsub(section, "%-", " "))
        end

        return string.format("%s(%s) | Lua Language Server", utils.normalize_str(page), section)
      elseif string.match(item.label, "") then
        local page = string.match(item.label, "luals%.github%.io/wiki/(.-)/?$")

        return string.format("%s | Lua Language Server", utils.normalize_str(page))
      else
        return item.label
      end
    end,
  },

  ---@field [string] url.opts

  -- Priority of a pattern.
  ---@field priority? integer

  -- Text that will replace the link.
  ---@field text? fun(buffer: integer, item: vimdoc.__urls): string

  ---@field corner_left? string
  ---@field padding_left? string

  ---@field icon? string

  ---@field padding_right? string
  ---@field corner_right? string

  -- Primary highlight group.
  -- Used by other `*_hl` option(s) when a value isn't given.
  ---@field hl? string

  ---@field corner_left_hl? string
  ---@field padding_left_hl? string

  ---@field icon_hl? string

  ---@field padding_right_hl? string
  ---@field corner_right_hl? string
}

return urls
