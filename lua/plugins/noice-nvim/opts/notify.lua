local notify = {
  -- Noice can be used as `vim.notify` so you can route any notification like other messages
  -- Notification messages have their level and other properties set.
  -- event is always "notify" and kind can be any log level as a string
  -- The default routes will forward notifications to nvim-notify
  -- Benefit of using Noice for this is the routing and consistent history view
  enabled = true,
  view = "notify",
}

return notify
