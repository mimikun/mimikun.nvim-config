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
    extension = function()
      local extension = "png"
      return extension
    end,

    ---@type string | fun(): string
    file_name = function()
      local file_name = "%Y-%m-%d-%H-%M-%S"
      return file_name
    end,

    ---@type boolean | fun(): boolean
    use_absolute_path = function()
      local use_absolute_path = false
      return use_absolute_path
    end,

    ---@type boolean | fun(): boolean
    relative_to_current_file = function()
      local relative_to_current_file = false
      return relative_to_current_file
    end,

    -- logging options
    ---@type boolean | fun(): boolean
    verbose = function()
      local verbose = true
      return verbose
    end,

    -- template options
    ---@type string | fun(context: table): string
    template = function()
      local template = "$FILE_PATH"
      return template
    end,

    ---@type boolean | fun(): boolean
    url_encode_path = function()
      local url_encode_path = false
      return url_encode_path
    end,

    ---@type boolean | fun(): boolean
    relative_template_path = function()
      local relative_template_path = true
      return relative_template_path
    end,

    ---@type boolean | fun(): boolean
    use_cursor_in_template = function()
      local use_cursor_in_template = true
      return use_cursor_in_template
    end,

    ---@type boolean | fun(): boolean
    insert_mode_after_paste = function()
      local insert_mode_after_paste = true
      return insert_mode_after_paste
    end,

    ---@type boolean | fun(): boolean
    insert_template_after_cursor = function()
      local insert_template_after_cursor = true
      return insert_template_after_cursor
    end,

    -- prompt options
    ---@type boolean | fun(): boolean
    prompt_for_file_name = function()
      local prompt_for_file_name = true
      return prompt_for_file_name
    end,

    ---@type boolean | fun(): boolean
    show_dir_path_in_prompt = function()
      local show_dir_path_in_prompt = false
      return show_dir_path_in_prompt
    end,

    -- base64 options
    ---@type number | fun(): number
    max_base64_size = function()
      local max_base64_size = 10
      return max_base64_size
    end,

    ---@type boolean | fun(): boolean
    embed_image_as_base64 = function()
      local embed_image_as_base64 = false
      return embed_image_as_base64
    end,

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
    copy_images = function()
      local copy_images = false
      return copy_images
    end,

    ---@type boolean | fun(): boolean
    download_images = function()
      local download_images = true
      return download_images
    end,

    ---@type string[]
    formats = {
      "jpeg",
      "jpg",
      "png",
    },

    -- drag and drop options
    drag_and_drop = {
      ---@type boolean | fun(): boolean
      enabled = function()
        local enabled = true
        return enabled
      end,

      ---@type boolean | fun(): boolean
      insert_mode = function()
        local insert_mode = false
        return insert_mode
      end,
    },
  },

  -- filetype specific options
  filetypes = {
    markdown = {
      ---@type boolean | fun(): boolean
      url_encode_path = function()
        local url_encode_path = true
        return url_encode_path
      end,

      ---@type string | fun(context: table): string
      template = function()
        local template = "![$CURSOR]($FILE_PATH)"
        return template
      end,

      ---@type boolean | fun(): boolean
      download_images = function()
        local download_images = false
        return download_images
      end,
    },

    vimwiki = {
      ---@type boolean | fun(): boolean
      url_encode_path = function()
        local url_encode_path = true
        return url_encode_path
      end,

      ---@type string | fun(context: table): string
      template = function()
        local template = "![$CURSOR]($FILE_PATH)"
        return template
      end,

      ---@type boolean | fun(): boolean
      download_images = function()
        local download_images = false
        return download_images
      end,
    },

    html = {
      ---@type string | fun(context: table): string
      template = function()
        local template = '<img src="$FILE_PATH" alt="$CURSOR">'
        return template
      end,
    },

    tex = {
      ---@type boolean | fun(): boolean
      relative_template_path = function()
        local relative_template_path = false
        return relative_template_path
      end,

      ---@type string | fun(context: table): string
      template = function()
        local template = [[
\begin{figure}[h]
  \centering
  \includegraphics[width=0.8\textwidth]{$FILE_PATH}
  \caption{$CURSOR}
  \label{fig:$LABEL}
\end{figure}
    ]]

        return template
      end,

      ---@type table
      formats = {
        "jpeg",
        "jpg",
        "png",
        "pdf",
      },

      ---@type boolean | fun(): boolean
      use_absolute_path = function()
        local use_absolute_path = true
        return use_absolute_path
      end,
    },

    typst = {
      ---@type string | fun(context: table): string
      template = function()
        local template = [[
#figure(
  image("$FILE_PATH", width: 80%),
  caption: [$CURSOR],
) <fig-$LABEL>
    ]]

        return template
      end,
    },

    rst = {
      ---@type string | fun(context: table): string
      template = function()
        local template = [[
.. image:: $FILE_PATH
   :alt: $CURSOR
   :width: 80%
    ]]
        return template
      end,
    },

    asciidoc = {
      ---@type string | fun(context: table): string
      template = function()
        local template = 'image::$FILE_PATH[width=80%, alt="$CURSOR"]'
        return template
      end,
    },

    org = {
      ---@type string | fun(context: table): string
      template = function()
        local template = [=[
#+BEGIN_FIGURE
[[file:$FILE_PATH]]
#+CAPTION: $CURSOR
#+NAME: fig:$LABEL
#+END_FIGURE
    ]=]
        return template
      end,
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
