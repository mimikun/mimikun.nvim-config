local x = require('deck.x')
local symbols = require('deck.symbols')
local Icon = require('deck.x.Icon')

local decorators = {}

---@type deck.Decorator
do
  local padding_decor = {
    col = 0,
    virt_text = { { '  ' } },
    virt_text_pos = 'inline',
    priority = 100,
  }
  local selected_cursor_decor = {
    {
      col = 0,
      sign_text = '▌»',
      sign_hl_group = 'SignColumn',
    },
    padding_decor,
  }
  local selected_decor = {
    {
      col = 0,
      sign_text = '▌ ',
      sign_hl_group = 'SignColumn',
    },
    padding_decor,
  }
  local cursor_decor = {
    {
      col = 0,
      sign_text = ' »',
      sign_hl_group = 'SignColumn',
    },
    padding_decor,
  }
  local empty_decor = {
    {
      col = 0,
      sign_text = '  ',
      sign_hl_group = 'SignColumn',
    },
    padding_decor,
  }
  decorators.signs = {
    name = 'signs',
    dynamic = true,
    decorate = function(ctx, item)
      if ctx.get_selected(item) and ctx.get_cursor_item() == item then
        return selected_cursor_decor
      elseif ctx.get_selected(item) then
        return selected_decor
      elseif ctx.get_cursor_item() == item then
        return cursor_decor
      else
        return empty_decor
      end
    end,
  }
end

---@type deck.Decorator
decorators.query_matches = {
  name = 'query_matches',
  dynamic = true,
  resolve = function(ctx)
    return ctx.get_config().matcher.decor
  end,
  decorate = function(ctx, item)
    if ctx.get_matcher_query() == '' then
      return symbols.empty
    end

    item[symbols.query_matches] = item[symbols.query_matches] or { matches = {} }
    if item[symbols.query_matches].query ~= ctx.get_matcher_query() then
      item[symbols.query_matches].query = ctx.get_matcher_query()

      if item[symbols.query_matches].query == '' then
        -- clear highlights if query is empty.
        item[symbols.query_matches].matches = symbols.empty
      else
        -- update highlights.
        local matches = ctx.get_config().matcher.decor(ctx.get_matcher_query(), item.display_text)
        if #matches > 0 then
          item[symbols.query_matches].matches = matches
        end
      end
    end

    if #item[symbols.query_matches].matches == 0 then
      return symbols.empty
    end

    local decorations = {}
    for _, match in ipairs(item[symbols.query_matches].matches) do
      table.insert(decorations, {
        col = match[1],
        end_col = match[2],
        hl_group = 'Search',
        ephemeral = true,
      })
    end
    return decorations
  end,
}

---@type deck.Decorator
decorators.highlights = {
  name = 'highlights',
  resolve = function(_, item)
    return type(item.highlights) == 'table'
  end,
  decorate = function(_, item)
    if #(item.highlights or {}) == 0 then
      return symbols.empty
    end

    local decorations = {}
    for _, hi in ipairs(item.highlights) do
      if hi.hl_group then
        table.insert(decorations, {
          col = hi[1],
          end_col = hi[2],
          hl_group = hi.hl_group,
          ephemeral = true,
        })
      end
    end
    return decorations
  end,
}

---@type deck.Decorator
do
  decorators.filename = {
    name = 'filename',
    resolve = function(_, item)
      return item.data.filename
    end,
    decorate = function(_, item)
      local decorations = {}

      -- icons decoration.
      local icon, hl = Icon.filename(item.data.filename)
      if icon then
        table.insert(decorations, {
          col = 0,
          virt_text = { { icon, hl }, { ' ' } },
          virt_text_pos = 'inline',
        })
      end

      -- buffer related decoration.
      local buf = x.get_bufnr_from_filename(item.data.filename)
      if buf and vim.fn.isdirectory(item.data.filename) ~= 1 then
        local modified = vim.api.nvim_get_option_value('modified', { buf = buf })
        table.insert(decorations, {
          col = 0,
          virt_text = { { modified and '[+]' or '', 'SpecialKey' }, { ' ' }, { ('#%s'):format(buf), 'Comment' } },
          virt_text_pos = 'eol',
          hl_mode = 'combine',
          ephemeral = true,
        })
      end

      return decorations
    end,
  }
end

return decorators
