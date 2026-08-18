---@type UfoConfig
local opts = {
  -- Time in millisecond between the range to be highlgihted and to be cleared while opening the folded line,
  -- `0` value will disable the highlight
  ---@type number
  open_fold_hl_timeout = 400,

  -- After the buffer is displayed (opened for the first time), close the folds whose range with `kind` field is included in this option.
  -- For now, 'lsp' provider's standardized kinds are 'comment', 'imports' and 'region', and the 'treesitter' provider exposes the underlying node types.
  -- This option is a table with filetype as key and fold kinds as value.
  -- Use a default value if value of filetype is absent.
  -- Run `UfoInspect` for details if your provider has extended the kinds.
  ---@type table<string, UfoFoldingRangeKind[]>
  close_fold_kinds_for_ft = {
    default = {},
  },

  -- Whether to close folds on the current line when the buffer is first displayed.
  -- This option is a table with filetype as key and boolean as value.
  -- Use a default value if value of filetype is absent.
  ---@type table<string, boolean>
  close_fold_current_line_for_ft = {
    default = false,
  },

  -- A global virtual text handler, reference to `ufo.setFoldVirtTextHandler`
  ---@type UfoFoldVirtTextHandler
  fold_virt_text_handler = nil,

  -- Enable a function with `lnum` as a parameter to capture the virtual text for the folded lines and export the function to `get_fold_virt_text` field of ctx table as 6th parameter in `fold_virt_text_handler`
  ---@type boolean
  enable_get_fold_virt_text = false,

  -- Override foldtext with (custom) virt text handler
  ---@type boolean
  override_foldtext = true,

  -- Configure the options for preview window and remap the keys for current buffer and preview buffer if the preview window is displayed.
  -- Never worry about the users's keymaps are overridden by ufo, ufo will save them and restore them if preview window is closed.
  ---@type table
  preview = {
    win_config = {
      -- The border for preview window, `:h nvim_open_win() | call search('border:')`
      border = "rounded",

      -- The winblend for preview window, `:h winblend`
      winblend = 12,

      -- The winhighlight for preview window, `:h winhighlight`
      winhighlight = "Normal:Normal",

      -- The max height of preview window
      maxheight = 20,
    },

    -- The table for {function = key}
    mappings = {
      scrollB = "",
      scrollF = "",
      scrollU = "",
      scrollD = "",
      scrollE = "<C-E>",
      scrollY = "<C-Y>",
      jumpTop = "",
      jumpBot = "",
      close = "q",
      switch = "<Tab>",
      trace = "<CR>",
    },
  },

  ---@param bufnr number
  ---@param filetype string file type
  ---@param buftype string buffer type
  ---@return string[] | function | nil | UfoProviderEnum | "lsp" | "treesitter" | "indent"
  ---return a string type use ufo providers
  ---return a string in a table like a string type
  ---return empty string '' will disable any providers
  ---return `nil` will use default value {'lsp', 'indent'}

  -- A function as a selector for fold providers.
  -- For now, there are 'lsp' and 'treesitter' as main provider, 'indent' as fallback provider
  provider_selector = function(_bufnr, _filetype, _buftype)
    return {
      "treesitter",
      "indent",
    }
  end,
}

return opts
