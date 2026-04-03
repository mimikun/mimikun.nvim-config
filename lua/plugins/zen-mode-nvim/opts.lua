---@type ZenOptions
local opts = {
  border = "none",
  -- zindex of the zen window. Should be less than 50, which is the float default
  zindex = 40,
  window = {
    -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    backdrop = 0.95,
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    -- width of the Zen window
    width = 120,
    -- height of the Zen window
    height = 1,
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      -- disable signcolumn
      --signcolumn = "no",
      -- disable number column
      --number = false,
      -- disable relative numbers
      --relativenumber = false,
      -- disable cursorline
      --cursorline = false,
      -- disable cursor column
      --cursorcolumn = false,
      -- disable fold column
      --foldcolumn = "0",
      -- disable whitespace characters
      --list = false,
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      -- disables the ruler text in the cmd line area
      ruler = false,
      -- disables the command in the last line of the screen
      showcmd = false,
      -- you may turn on/off statusline in zen mode by setting 'laststatus'
      -- statusline will be shown only if 'laststatus' == 3
      -- turn off the statusline in zen mode
      laststatus = 0,
    },
    -- enable to start Twilight when zen mode opens
    twilight = { enabled = true },
    -- disables git signs
    gitsigns = { enabled = false },
    -- disables the tmux statusline
    tmux = { enabled = false },
    -- if set to "true", todo-comments.nvim highlights will be disabled
    todo = { enabled = false },
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    kitty = {
      enabled = false,
      -- font size increment
      font = "+4",
    },
    -- this will change the font size on alacritty when in zen mode
    -- requires  Alacritty Version 0.10.0 or higher
    -- uses `alacritty msg` subcommand to change font size
    alacritty = {
      enabled = false,
      -- font size
      font = "14",
    },
    -- this will change the font size on wezterm when in zen mode
    -- See alse also the Plugins/Wezterm section in this projects README
    wezterm = {
      enabled = false,
      -- can be either an absolute font size or the number of incremental steps
      -- (10% increase per step)
      font = "+4",
    },
    -- this will change the scale factor in Neovide when in zen mode
    -- See alse also the Plugins/Wezterm section in this projects README
    neovide = {
      enabled = false,
      -- Will multiply the current scale factor by this number
      scale = 1.2,
      -- disable the Neovide animations while in Zen mode
      disable_animations = {
        neovide_animation_length = 0,
        neovide_cursor_animate_command_line = false,
        neovide_scroll_animation_length = 0,
        neovide_position_animation_length = 0,
        neovide_cursor_animation_length = 0,
        neovide_cursor_vfx_mode = "",
      },
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win) end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function() end,
}

return opts
