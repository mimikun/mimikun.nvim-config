# Custimized Handlers
This page guides you on how to add customized handlers to the Neominimap plugin. Handlers allow you to define how specific types of annotations (like TODO comments or diagnostic signs) are displayed on the minimap.

## Handler Structure

A handler is defined by the Neominimap.Map.Handler class, which includes several fields:

- **name**: A string that identifies the handler.
- **mode**: Defines how the annotations are displayed (icon, sign, background highlight...).
- **namespace**: Either an integer or string representing the namespace in which the handler operates.
- **autocmds**: A list of autocommands that trigger the handler’s behavior. Each autocmd includes:
    - **event**: The Vim event(s) that trigger the autocmd.
    - **opts**: Optional settings for the autocmd, including a callback function that applies the handler.
            Note that the callback function takes an additional argument called `apply`. This function is for applying the handler to a specific buffer. See the following example.
- **init**: A function that initializes the handler.
- **get_annotations**: A function that retrieves a list of annotations for a given buffer.

the `get_annotations` function returns a list of annotations, each defined by the `Neominimap.Map.Handler.Annotation` type. This type includes the following fields:
- **lnum**: The starting line number (1-based index).
- **end_lnum**: The ending line number (1-based index).
- **id**: A unique identifier for the annotation within a single handler.
- **priority**: The priority level for displaying the annotation.
- **icon**: (Optional) An icon associated with the annotation. Useful when `mode` is `icon`.
- **highlight**: The highlight group for rendering the annotation.

## Example Handler

### Todo Comments
Here’s an example of a handler that integrates with [todo-comments.nvim](https://github.com/folke/todo-comments.nvim):

```lua
---@type Neominimap.Map.Handler
local extmark_handler = {
    name = "Todo Comment",
    mode = "icon",
    namespace = vim.api.nvim_create_namespace("neominimap_todo_comment"),
    init = function() end,
    autocmds = {
        {
            event = { "TextChanged", "TextChangedI" },
            opts = {
                callback = function(apply, args)
                    local bufnr = tonumber(args.buf) ---@cast bufnr integer
                    vim.schedule(function()
                        apply(bufnr)
                    end)
                end,
            },
        },
        {
            event = "WinScrolled",
            opts = {
                callback = function(apply)
                    local winid = vim.api.nvim_get_current_win()
                    if not winid or not vim.api.nvim_win_is_valid(winid) then
                        return
                    end
                    local bufnr = vim.api.nvim_win_get_buf(winid)
                    vim.schedule(function()
                        if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
                            apply(bufnr)
                        end
                    end)
                end,
            },
        },
    },
    get_annotations = function(bufnr)
        local ok, _ = pcall(require, "todo-comments")
        if not ok then
            return {}
        end
        local ns_id = vim.api.nvim_get_namespaces()["todo-comments"]
        local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, {
            details = true,
        })
        local icons = {
            FIX = " ",
            TODO = " ",
            HACK = " ",
            WARN = " ",
            PERF = " ",
            NOTE = " ",
            TEST = "⏲ ",
        }
        local id = { FIX = 1, TODO = 2, HACK = 3, WARN = 4, PERF = 5, NOTE = 6, TEST = 7 }
        return vim.tbl_map(function(extmark) ---@param extmark vim.api.keyset.get_extmark_item
            local detail = extmark[4] ---@type vim.api.keyset.extmark_details
            local group = detail.hl_group ---@type string
            local kind = string.sub(group, 7)
            local icon = icons[kind]
            ---@type Neominimap.Map.Handler.Annotation
            return {
                lnum = extmark[2],
                end_lnum = extmark[2],
                id = id[kind],
                highlight = "TodoFg" .. kind, --- You can customize the highlight here.
                icon = icon,
                priority = detail.priority,
            }
        end, extmarks)
    end,
}

vim.g.neominimap = {
    handlers = {
        extmark_handler,
    }
}

```
Here is an overview

![overview](https://github.com/user-attachments/assets/caaf8528-b50e-4af7-aa50-2f544af2754e)

For more exapmles, checkout the built-in handlers in source code.

### Occurrences of the Word Under the Cursor

Thanks to [@TonyMiri](https://github.com/TonyMiri)

```lua
local word_highlights = {}

---@type Neominimap.Map.Handler
local word_handler = {
  name = "Word Highlights",
  mode = "line",
  namespace = vim.api.nvim_create_namespace("neominimap_word"),

  init = function()
    -- Set up highlight groups
    local base_color = "#404040" -- Default fallback color
    local current_color = "#906060" -- Brighter color for current word

    local hl = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })
    if hl.bg then
      base_color = string.format("#%06x", hl.bg)
      -- Make current highlight 30% brighter
      local r = bit.rshift(bit.band(hl.bg, 0xFF0000), 16)
      local g = bit.rshift(bit.band(hl.bg, 0xFF00), 8)
      local b = bit.band(hl.bg, 0xFF)
      r = math.min(255, r + math.floor(r * 0.3))
      g = math.min(255, g + math.floor(g * 0.3))
      b = math.min(255, b + math.floor(b * 0.3))
      current_color = string.format("#%02x%02x%02x", r, g, b)
    end

    -- Regular word highlights
    vim.api.nvim_set_hl(0, "NeominimapWordLine", { bg = base_color, default = true })
    vim.api.nvim_set_hl(0, "NeominimapWordSign", { fg = base_color, default = true })
    vim.api.nvim_set_hl(0, "NeominimapWordIcon", { fg = base_color, default = true })

    -- Current word highlights
    vim.api.nvim_set_hl(0, "NeominimapCurrentWordLine", { bg = current_color, default = true })
    vim.api.nvim_set_hl(0, "NeominimapCurrentWordSign", { fg = current_color, default = true })
    vim.api.nvim_set_hl(0, "NeominimapCurrentWordIcon", { fg = current_color, default = true })
  end,

  autocmds = {
    {
      event = { "CursorHold", "CursorHoldI" },
      opts = {
        desc = "Update word highlights when cursor moves",
        callback = function(apply)
          local winid = vim.api.nvim_get_current_win()
          if not winid or not vim.api.nvim_win_is_valid(winid) then
            return
          end

          local bufnr = vim.api.nvim_win_get_buf(winid)
          vim.schedule(function()
            if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
              -- Cache current word and its positions
              local word = vim.fn.expand("<cword>")
              if word and word ~= "" then
                local key = bufnr .. word
                if
                  not word_highlights[key]
                  or word_highlights[key].tick ~= vim.b[bufnr].changedtick
                then
                  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
                  local positions = {}
                  for lnum, line in ipairs(lines) do
                    if line:find(word, 1, true) then
                      table.insert(positions, lnum)
                    end
                  end
                  word_highlights[key] = {
                    positions = positions,
                    tick = vim.b[bufnr].changedtick,
                  }
                end
              end
              apply(bufnr)
            end
          end)
        end,
      },
    },
  },

  get_annotations = function(bufnr)
    local word = vim.fn.expand("<cword>")
    if not word or word == "" then
      return {}
    end

    local key = bufnr .. word
    local cached = word_highlights[key]
    if not cached then
      return {}
    end

    -- Get current cursor position
    local current_line = vim.api.nvim_win_get_cursor(0)[1]

    local annotations = {}
    for _, lnum in ipairs(cached.positions) do
      table.insert(annotations, {
        lnum = lnum,
        end_lnum = lnum,
        priority = 25, -- Between search (20) and diagnostics (70-100)
        id = 1,
        highlight = (lnum == current_line) and "NeominimapCurrentWordLine" or "NeominimapWordLine",
      })
    end

    return annotations
  end,
}

```