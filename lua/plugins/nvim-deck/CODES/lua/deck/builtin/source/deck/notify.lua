local notify = require('deck.notify')

--[=[@doc
  category = "source"
  name = "deck.notify"
  desc = "Show deck.notify history."
  example = """
    deck.start(require('deck.builtin.source.deck.notify')())
  """
]=]
return function()
  ---@type deck.Source
  return {
    name = 'deck.notify',
    execute = function(ctx)
      local entries = notify.get_history()
      local current_lane = entries[1] and entries[1].lane
      for _, item in ipairs(entries) do
        -- add separator.
        if item.lane ~= current_lane then
          ctx.item({
            display_text = '',
          })
          current_lane = item.lane
        end

        if item.type == 'lane' then
          ctx.item({
            display_text = { { '[Lane]', 'Title' }, { ' ' }, { item.lane.name } },
          })
        elseif item.type == 'item' then
          ctx.item({
            display_text = item.line,
          })
        end
      end
      ctx.done()
    end,
  }
end
