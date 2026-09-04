---@type render.md.link.Config
local link = {
  -- Turn on / off inline link icon rendering.
  enabled = true,

  -- Additional modes to render links.
  render_modes = false,

  -- How to handle footnote links, start with a '^'.
  ---@type render.md.link.footnote.Config
  footnote = {
    -- Turn on / off footnote rendering.
    ---@type boolean
    enabled = true,

    -- Inlined with content.
    ---@type string
    icon = "󰯔 ",

    -- Custom processing for footnote body to show.
    -- Runs before prefix / suffix are added and superscript processing.
    ---@type fun(ctx: render.md.link.footnote.Context): string?
    body = function(ctx)
      return ctx.text
    end,

    -- Replace value with superscript equivalent.
    ---@type boolean
    superscript = true,

    -- Added before link content.
    ---@type string
    prefix = "",

    -- Added after link content.
    ---@type string
    suffix = "",
  },

  -- Inlined with 'image' elements.
  ---@type string
  image = "󰥶 ",
  --image = "󰋵 ",

  -- Check custom for 'image' elements.
  ---@type boolean
  image_custom = true,

  -- Inlined with 'email_autolink' elements.
  ---@type string
  email = "󰀓 ",
  --email = " ",

  -- Fallback icon for 'inline_link' and 'uri_autolink' elements.
  ---@type string
  hyperlink = "󰌹 ",
  --hyperlink = "󰌷 ",

  -- Applies to the inlined icon as a fallback.
  ---@type string
  highlight = "RenderMarkdownLink",

  -- Applies to the link title.
  ---@type string
  highlight_title = "RenderMarkdownLinkTitle",

  -- Applies to WikiLink elements.
  ---@type render.md.link.wiki.Config
  wiki = {
    -- Turn on / off WikiLink rendering.
    ---@type boolean
    enabled = true,

    -- Inlined with content.
    ---@type string
    icon = "󱗖 ",

    -- Hide destination if there is an alias.
    ---@type boolean
    conceal_destination = true,

    -- Custom processing for WikiLink body to show.
    ---@type fun(ctx: render.md.link.wiki.Context): render.md.mark.Text | string?
    body = function(_ctx)
      ---@field buf integer
      ---@field row integer
      ---@field start_col integer
      ---@field end_col integer
      ---@field destination string
      ---@field alias? string
      return nil
    end,

    -- Applies to the inlined icon.
    ---@type string
    highlight = "RenderMarkdownWikiLink",

    -- Highlight for item associated with the WikiLink.
    ---@type string
    scope_highlight = nil,
  },

  -- Define custom destination patterns so icons can quickly inform you of what a link contains. Applies to 'image', 'inline_link', 'uri_autolink', and WikiLink nodes.
  -- When multiple patterns match a link the one with the longer pattern is used.
  -- The key is for healthcheck and to allow users to change its values, value type below.
  --   icon: gets inlined before the link text
  --   pattern: matched against the destination text
  --   kind: optional determines how pattern is checked
  --       pattern: @see :h lua-patterns, is the default if not set
  --       suffix: @see :h vim.endswith()
  --       url: similar to pattern with additional prefix checks
  --   priority: optional used when multiple match, uses pattern length if empty
  --   highlight: optional highlight for 'icon', uses fallback highlight if empty
  ---@type table<string, render.md.link.custom.Config>
  custom = {
    web = {
      icon = "󰖟 ",
      pattern = "^http",
    },
    apple = {
      ---@type string
      icon = " ",
      ---@type string
      pattern = "apple%.com",
      ---@type render.md.link.custom.Kind | string | "pattern" | "suffix" | "url"
      kind = "url",
    },
    discord = {
      icon = "󰙯 ",
      pattern = "discord%.com",
      kind = "url",
    },
    github = {
      icon = "󰊤 ",
      pattern = "github%.com",
      kind = "url",
    },
    gitlab = {
      icon = "󰮠 ",
      pattern = "gitlab%.com",
      kind = "url",
    },
    google = {
      icon = "󰊭 ",
      pattern = "google%.com",
      kind = "url",
    },
    hackernews = {
      icon = " ",
      pattern = "ycombinator%.com",
      kind = "url",
    },
    linkedin = {
      icon = "󰌻 ",
      pattern = "linkedin%.com",
      kind = "url",
    },
    microsoft = {
      icon = " ",
      pattern = "microsoft%.com",
      kind = "url",
    },
    neovim = {
      icon = " ",
      pattern = "neovim%.io",
      kind = "url",
    },
    reddit = {
      icon = "󰑍 ",
      pattern = "reddit%.com",
      kind = "url",
    },
    slack = {
      icon = "󰒱 ",
      pattern = "slack%.com",
      kind = "url",
    },
    stackoverflow = {
      icon = "󰓌 ",
      pattern = "stackoverflow%.com",
      kind = "url",
    },
    steam = {
      icon = " ",
      pattern = "steampowered%.com",
      kind = "url",
    },
    twitter = {
      icon = " ",
      pattern = "twitter%.com",
      kind = "url",
    },
    wikipedia = {
      icon = "󰖬 ",
      pattern = "wikipedia%.org",
      kind = "url",
    },
    x = {
      icon = " ",
      pattern = "x%.com",
      kind = "url",
    },
    youtube = {
      icon = "󰗃 ",
      pattern = "youtube[^.]*%.com",
      kind = "url",
    },
    youtube_short = {
      icon = "󰗃 ",
      pattern = "youtu%.be",
      kind = "url",
    },
    python = {
      pattern = "%.py$",
      icon = "󰌠 ",
    },
  },
}

return link
