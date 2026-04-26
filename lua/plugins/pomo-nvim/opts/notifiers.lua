-- Configure the default notifiers to use for each timer.
-- You can also configure different notifiers for timers given specific names, see the 'timers' field below.
---@type pomo.NotifierConfig[]
local notifiers = {
  -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
  {
    name = "Default",
    opts = {
      -- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up continuously displayed.
      -- If you only want a pop-up notification when the timer starts and finishes, set this to false.
      sticky = true,

      -- Configure the display icons:
      title_icon = "󱎫",
      text_icon = "󰄉",
      -- Replace the above with these if you don't have a patched font:
      --title_icon = "⏳",
      --text_icon = "⏱️",
    },
  },

  -- The "System" notifier sends a system notification when the timer is finished.
  -- Available on MacOS and Windows natively and on Linux via the `libnotify-bin` package.
  {
    name = "System",
  },

  -- You can also define custom notifiers by providing an "init" function instead of a name.
  -- See "Defining custom notifiers" below for an example 👇
  -- { init = function(timer) ... end }
}

return notifiers
