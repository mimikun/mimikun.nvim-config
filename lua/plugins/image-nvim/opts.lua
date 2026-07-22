---@type Options
local opts = {
  ---@type string | "kitty" | "ueberzug" | "sixel"
  backend = "kitty",

  ---@type string | "magick_cli" | "magick_rock"
  --processor = "magick_cli",

  ---@type table<string, IntegrationOptions>
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = true,

      ---@type string | "inline" | "popup"
      only_render_image_at_cursor_mode = "popup",

      -- if true, images will be rendered in floating markdown windows
      floating_windows = false,

      -- markdown extensions (ie. quarto) can go here
      filetypes = {
        "markdown",
        "vimwiki",
      },

      resolve_image_path = function(document_path, image_path, fallback)
        -- document_path is the path to the file that contains the image image_path is the potentially relative path to the image.
        -- for markdown it's `![](this text)`
        -- you can call the fallback function to get the default behavior
        return fallback(document_path, image_path)
      end,
    },
    asciidoc = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,

      ---@type string | "inline" | "popup"
      only_render_image_at_cursor_mode = "popup",

      floating_windows = false,
      filetypes = {
        "asciidoc",
        "adoc",
      },
    },
    neorg = {
      enabled = true,
      filetypes = {
        "norg",
      },
    },
    rst = {
      enabled = true,
    },
    typst = {
      enabled = true,
      filetypes = {
        "typst",
      },
    },
    html = {
      enabled = false,
    },
    css = {
      enabled = false,
    },
  },
  ---@type number
  max_width = nil,

  ---@type number
  max_height = nil,

  ---@type number
  max_width_window_percentage = nil,

  ---@type number
  max_height_window_percentage = 50,

  ---@type number
  scale_factor = 1.0,

  -- toggles images when windows are overlapped
  ---@type boolean
  window_overlap_clear_enabled = false,

  ---@type string[]
  window_overlap_clear_ft_ignore = {
    "cmp_menu",
    "cmp_docs",
    "snacks_notif",
    "scrollview",
    "scrollview_sign",
  },

  -- auto show/hide images when the editor gains/looses focus
  ---@type boolean
  editor_only_render_when_focused = false,

  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  ---@type boolean
  tmux_show_only_in_active_window = false,

  -- render image files as images when opened
  ---@type string[]
  hijack_file_patterns = {
    "*.png",
    "*.jpg",
    "*.jpeg",
    "*.gif",
    "*.webp",
    "*.avif",
  },

  ---@type boolean
  ignore_download_error = false,

  ---@type string | "normal" | "unicode-placeholders"
  kitty_method = "normal",
}

return opts
