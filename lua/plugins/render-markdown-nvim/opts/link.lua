---@type render.md.link.Config
local link = {
  -- Turn on / off inline link icon rendering.
  enabled = true,

  -- Additional modes to render links.
  render_modes = false,

  -- How to handle footnote links, start with a '^'.
  ---@type render.md.link.footnote.UserConfig
  footnote = {
    -- Turn on / off footnote rendering.
    ---@field enabled? boolean
    enabled = true,

    -- Inlined with content.
    ---@field icon? string
    icon = "󰯔 ",

    -- Custom processing for footnote body to show.
    -- Runs before prefix / suffix are added and superscript processing.
    ---@field body? fun(ctx: render.md.link.footnote.Context): string?
    body = function(ctx)
      return ctx.text
    end,

    -- Replace value with superscript equivalent.
    ---@field superscript? boolean
    superscript = true,

    -- Added before link content.
    ---@field prefix? string
    prefix = "",

    -- Added after link content.
    ---@field suffix? string
    suffix = "",
  },

  -- Inlined with 'image' elements.
  ---@type string
  image = "󰥶 ",

  -- Check custom for 'image' elements.
  ---@type boolean
  image_custom = true,

  -- Inlined with 'email_autolink' elements.
  ---@type string
  email = "󰀓 ",

  -- Fallback icon for 'inline_link' and 'uri_autolink' elements.
  ---@type string
  hyperlink = "󰌹 ",

  -- Applies to the inlined icon as a fallback.
  ---@type string
  highlight = "RenderMarkdownLink",

  -- Applies to the link title.
  ---@type string
  highlight_title = "RenderMarkdownLinkTitle",

  -- Applies to WikiLink elements.
  ---@field wiki? render.md.link.wiki.UserConfig
  wiki = {
    -- Turn on / off WikiLink rendering.
    ---@field enabled? boolean
    enabled = true,

    -- Inlined with content.
    ---@field icon? string
    icon = "󱗖 ",

    -- Hide destination if there is an alias.
    ---@field conceal_destination? boolean
    conceal_destination = true,

    -- Custom processing for WikiLink body to show.
    ---@field body? fun(ctx: render.md.link.wiki.Context): render.md.mark.Text|string?
    body = function()
      return nil
    end,

    -- Applies to the inlined icon.
    ---@field highlight? string
    highlight = "RenderMarkdownWikiLink",

    -- Highlight for item associated with the WikiLink.
    ---@field scope_highlight? string
    scope_highlight = nil,
  },
  -- Define custom destination patterns so icons can quickly inform you of what a link contains.
  -- Applies to 'image', 'inline_link', 'uri_autolink', and WikiLink nodes.
  -- When multiple patterns match a link the one with the longer pattern is used.
  -- The key is for healthcheck and to allow users to change its values, value type below.
  -- icon      | gets inlined before the link text                               |
  -- pattern   | matched against the destination text                            |
  -- kind      | optional determines how pattern is checked                      |
  --           | pattern | @see :h lua-patterns, is the default if not set       |
  --           | suffix  | @see :h vim.endswith()                                |
  --           | url     | similar to pattern with additional prefix checks      |
  -- priority  | optional used when multiple match, uses pattern length if empty |
  -- highlight | optional highlight for 'icon', uses fallback highlight if empty |
  ---@type table<string, render.md.link.custom.UserConfig>
  custom = {
    web = { icon = "󰖟 ", pattern = "^http" },
    apple = { icon = " ", pattern = "apple%.com", kind = "url" },
    discord = { icon = "󰙯 ", pattern = "discord%.com", kind = "url" },
    github = { icon = "󰊤 ", pattern = "github%.com", kind = "url" },
    gitlab = { icon = "󰮠 ", pattern = "gitlab%.com", kind = "url" },
    google = { icon = "󰊭 ", pattern = "google%.com", kind = "url" },
    hackernews = { icon = " ", pattern = "ycombinator%.com", kind = "url" },
    linkedin = { icon = "󰌻 ", pattern = "linkedin%.com", kind = "url" },
    microsoft = { icon = " ", pattern = "microsoft%.com", kind = "url" },
    neovim = { icon = " ", pattern = "neovim%.io", kind = "url" },
    reddit = { icon = "󰑍 ", pattern = "reddit%.com", kind = "url" },
    slack = { icon = "󰒱 ", pattern = "slack%.com", kind = "url" },
    stackoverflow = { icon = "󰓌 ", pattern = "stackoverflow%.com", kind = "url" },
    steam = { icon = " ", pattern = "steampowered%.com", kind = "url" },
    twitter = { icon = " ", pattern = "twitter%.com", kind = "url" },
    wikipedia = { icon = "󰖬 ", pattern = "wikipedia%.org", kind = "url" },
    x = { icon = " ", pattern = "x%.com", kind = "url" },
    youtube = { icon = "󰗃 ", pattern = "youtube[^.]*%.com", kind = "url" },
    youtube_short = { icon = "󰗃 ", pattern = "youtu%.be", kind = "url" },
  },
}

return link
