---@type table
local opts = {
  default = {
    -- file and directory options
    ---@type string | fun(): string
    dir_path = function()
      local dir_path = "assets"
      dir_path = vim.fn.expand("%:t:r")
      return dir_path
    end,
    ---@type string | fun(): string
    extension = "png",
    ---@type string | fun(): string
    file_name = "%Y-%m-%d-%H-%M-%S",
    ---@type boolean | fun(): boolean
    use_absolute_path = false,
    ---@type boolean | fun(): boolean
    relative_to_current_file = false,

    -- logging options
    ---@type boolean | fun(): boolean
    verbose = true,

    -- template options
    ---@type string | fun(context: table): string
    template = "$FILE_PATH",
    ---@type boolean | fun(): boolean
    url_encode_path = false,
    ---@type boolean | fun(): boolean
    relative_template_path = true,
    ---@type boolean | fun(): boolean
    use_cursor_in_template = true,
    ---@type boolean | fun(): boolean
    insert_mode_after_paste = true,
    ---@type boolean | fun(): boolean
    insert_template_after_cursor = true,

    -- prompt options
    ---@type boolean | fun(): boolean
    prompt_for_file_name = true,
    ---@type boolean | fun(): boolean
    show_dir_path_in_prompt = false,

    -- base64 options
    ---@type number | fun(): number
    max_base64_size = 10,
    ---@type boolean | fun(): boolean
    embed_image_as_base64 = false,

    -- image options
    ---@type string | fun(): string
    process_cmd = function()
      local process_cmd
      -- compress the image with 85% quality
      process_cmd = "convert - -quality 85 -"
      -- resize the image to 50% of its original size
      process_cmd = "convert - -resize 50% -"
      -- convert the image to grayscale
      process_cmd = "convert - -colorspace Gray -"
      process_cmd = ""

      return process_cmd
    end,

    ---@type boolean | fun(): boolean
    copy_images = false,
    ---@type boolean | fun(): boolean
    download_images = true,
    ---@type string[]
    formats = { "jpeg", "jpg", "png" },

    -- drag and drop options
    drag_and_drop = {
      ---@type boolean | fun(): boolean
      enabled = true,
      ---@type boolean | fun(): boolean
      insert_mode = false,
    },
  },

  -- filetype specific options
  filetypes = {
    markdown = {
      ---@type boolean | fun(): boolean
      url_encode_path = true,
      ---@type string | fun(context: table): string
      template = "![$CURSOR]($FILE_PATH)",
      ---@type boolean | fun(): boolean
      download_images = false,
    },

    vimwiki = {
      ---@type boolean | fun(): boolean
      url_encode_path = true,
      ---@type string | fun(context: table): string
      template = "![$CURSOR]($FILE_PATH)",
      ---@type boolean | fun(): boolean
      download_images = false,
    },

    html = {
      ---@type string | fun(context: table): string
      template = '<img src="$FILE_PATH" alt="$CURSOR">',
    },

    tex = {
      ---@type boolean | fun(): boolean
      relative_template_path = false,
      ---@type string | fun(context: table): string
      template = [[
\begin{figure}[h]
  \centering
  \includegraphics[width=0.8\textwidth]{$FILE_PATH}
  \caption{$CURSOR}
  \label{fig:$LABEL}
\end{figure}
    ]],

      ---@type table
      formats = {
        "jpeg",
        "jpg",
        "png",
        "pdf",
      },

      ---@type boolean | fun(): boolean
      use_absolute_path = true,
    },

    typst = {
      ---@type string | fun(context: table): string
      template = [[
#figure(
  image("$FILE_PATH", width: 80%),
  caption: [$CURSOR],
) <fig-$LABEL>
    ]],
    },

    rst = {
      ---@type string | fun(context: table): string
      template = [[
.. image:: $FILE_PATH
   :alt: $CURSOR
   :width: 80%
    ]],
    },

    asciidoc = {
      ---@type string | fun(context: table): string
      template = 'image::$FILE_PATH[width=80%, alt="$CURSOR"]',
    },

    org = {
      ---@type string | fun(context: table): string
      template = [=[
#+BEGIN_FIGURE
[[file:$FILE_PATH]]
#+CAPTION: $CURSOR
#+NAME: fig:$LABEL
#+END_FIGURE
    ]=],
    },
  },

  -- file, directory, and custom triggered options
  ---@type table | fun(): table
  files = {},
  ---@type table | fun(): table
  dirs = {},
  ---@type table | fun(): table
  custom = {},
}

return opts
