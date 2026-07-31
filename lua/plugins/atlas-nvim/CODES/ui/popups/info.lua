local M = {}

local ns = vim.api.nvim_create_namespace("atlas.popup.info")

local win = nil
local buf = nil

local function valid_buf(b)
  return type(b) == "number" and vim.api.nvim_buf_is_valid(b)
end

local function valid_win(w)
  return type(w) == "number" and vim.api.nvim_win_is_valid(w)
end

local function close_win()
  if win and valid_win(win) then
    vim.api.nvim_win_close(win, true)
  end
  win = nil
end

local function delete_buf()
  if buf and valid_buf(buf) then
    vim.api.nvim_buf_delete(buf, { force = true })
  end
  buf = nil
end

local function max_line_width(lines)
  local width = 1
  for _, line in ipairs(lines or {}) do
    width = math.max(width, vim.fn.strdisplaywidth(tostring(line or "")))
  end
  return width
end

local function popup_config(lines)
  local content_width = max_line_width(lines)
  local width = math.max(10, math.min(content_width + 2, math.max(vim.o.columns - 4, 10)))
  local height = math.max(1, math.min(#lines, math.max(vim.o.lines - 4, 1)))

  return {
    relative = "cursor",
    row = 1,
    col = 0,
    style = "minimal",
    border = "rounded",
    focusable = false,
    zindex = 260,
    width = width,
    height = height,
  }
end

local function ensure_buf()
  if valid_buf(buf) then
    return buf
  end

  buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
  vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

  return buf
end

local function apply_highlights(target_buf, lines, highlights)
  vim.api.nvim_buf_clear_namespace(target_buf, ns, 0, -1)

  for _, h in ipairs(highlights or {}) do
    local row = tonumber(h.row)
    local start_col = tonumber(h.col or h.start_col)
    local end_col = tonumber(h.end_col)
    local hl_group = h.hl_group or h.hl

    if row ~= nil and start_col ~= nil and end_col ~= nil and type(hl_group) == "string" then
      if row >= 0 and row < #lines then
        local line_len = #lines[row + 1]
        if end_col == -1 then
          end_col = line_len
        end

        start_col = math.max(0, math.min(start_col, line_len))
        end_col = math.max(start_col, math.min(end_col, line_len))

        if end_col > start_col then
          vim.api.nvim_buf_set_extmark(target_buf, ns, row, start_col, {
            end_row = row,
            end_col = end_col,
            hl_group = hl_group,
          })
        end
      end
    end
  end
end

function M.close()
  close_win()
  delete_buf()
end

---@param opts { lines: string[], highlights?: table[], source_buf?: integer }
function M.show(opts)
  opts = opts or {}
  local lines = opts.lines or {}
  if #lines == 0 then
    return
  end

  local source_buf = opts.source_buf
  if not valid_buf(source_buf) then
    source_buf = vim.api.nvim_get_current_buf()
  end

  M.close()

  local target_buf = ensure_buf()
  vim.api.nvim_set_option_value("modifiable", true, { buf = target_buf })
  vim.api.nvim_buf_set_lines(target_buf, 0, -1, false, lines)
  vim.api.nvim_set_option_value("modifiable", false, { buf = target_buf })
  apply_highlights(target_buf, lines, opts.highlights)

  win = vim.api.nvim_open_win(target_buf, false, popup_config(lines))
  vim.api.nvim_set_option_value(
    "winhighlight",
    "Normal:NormalFloat,NormalNC:NormalFloat,EndOfBuffer:NormalFloat,FloatBorder:FloatBorder",
    { win = win }
  )

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
    buffer = source_buf,
    once = true,
    callback = function()
      M.close()
    end,
  })
end

return M
