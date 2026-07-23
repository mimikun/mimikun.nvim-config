local user_tip_prefix
-- Custom emoji prefix
--user_tip_prefix = "🔧 "
-- Default: [User] prefix
user_tip_prefix = "[User] "

local bookmark_symbol

-- Alternative star options
--bookmark_symbol = "⭐ "
--bookmark_symbol = "✨ "
--bookmark_symbol = "💫 "

-- Other colorful options
--bookmark_symbol = "🔥 "
--bookmark_symbol = "💎 "
--bookmark_symbol = "🏆 "
--bookmark_symbol = "⚡ "
--bookmark_symbol = "🎯 "
--bookmark_symbol = "📌 "

-- Simple text options
--bookmark_symbol = "★ "
--bookmark_symbol = "[★] "
--bookmark_symbol = "• "

-- Default star emoji
bookmark_symbol = "🌟 "

---@type NeovimTipsOptions
local opts = {
  -- Path to user's custom tips file
  ---@type string
  user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",

  -- Configurable prefix for user tips
  -- Prefix for user tips to avoid conflicts
  ---@type string
  user_tip_prefix = user_tip_prefix,

  -- Show warnings when user tips conflict with builtin tips
  ---@type boolean
  warn_on_conflicts = true,

  -- Daily tip mode:
  -- 0: off,
  -- 1: once per day
  -- 2: every startup
  ---@type integer
  daily_tip = 1,

  -- Show footer in daily tip popup (set to false to hide)
  -- Show footer with contribution links in daily tip popup
  ---@type boolean
  show_daily_tip_footer = true,

  -- Bookmark symbol (colorful Unicode symbols work great!)
  -- Symbol to display for bookmarked tips
  ---@type string
  bookmark_symbol = bookmark_symbol,

  -- Enable caching of parsed tips for faster loading
  ---@type boolean
  use_cache = true,
}

return opts
