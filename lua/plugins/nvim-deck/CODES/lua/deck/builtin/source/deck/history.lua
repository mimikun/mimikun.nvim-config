--[=[@doc
  category = "source"
  name = "deck.history"
  desc = "Show deck.start history."
  example = """
    deck.start(require('deck.builtin.source.deck.history')())
  """
]=]
return function()
  ---@type deck.Source
  return {
    name = 'deck.history',
    execute = function(ctx)
      for _, context in ipairs(require('deck').get_history()) do
        if context.name ~= 'deck.history' then
          ctx.item({
            display_text = context.name,
            data = context,
          })
        end
      end
      ctx.done()
    end,
    actions = {
      require('deck').alias_action('default', 'deck.history.resume'),
      require('deck').alias_action('delete', 'deck.history.dispose'),
      {
        name = 'deck.history.resume',
        resolve = function(ctx)
          return #ctx.get_action_items() == 1
        end,
        execute = function(ctx)
          for _, item in ipairs(ctx.get_action_items()) do
            item.data.show()
          end
        end,
      },
      {
        name = 'deck.history.dispose',
        execute = function(ctx)
          for _, item in ipairs(ctx.get_action_items()) do
            item.data.dispose()
          end
          ctx.execute()
        end,
      },
    },
  }
end
