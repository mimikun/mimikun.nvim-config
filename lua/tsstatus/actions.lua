-- The three things the screen can do to a parser, on top of nvim-treesitter's
-- public API. Nothing here waits for completion: the tracker turns the
-- installer's log into live rows, so the window is the progress report.

local M = {}

---@return table? nvim_treesitter
local function api()
  local ok, ts = pcall(require, "nvim-treesitter")
  if not ok then
    vim.notify("TSStatus: nvim-treesitter is not available", vim.log.levels.ERROR)
    return nil
  end
  return ts
end

---@param what string
---@param task any
local function report(what, task)
  if type(task) ~= "table" or type(task.await) ~= "function" then
    return
  end
  task:await(vim.schedule_wrap(function(err)
    if err then
      vim.notify(("TSStatus: %s failed: %s"):format(what, tostring(err)), vim.log.levels.ERROR)
    end
  end))
end

---@param langs string[]
---@param force boolean? reinstall parsers that are already present
function M.install(langs, force)
  local ts = api()
  if not ts or #langs == 0 then
    return
  end
  -- summary = false: the screen already shows per-parser state, and the
  -- summary line only adds a hit-enter prompt on top of it.
  report("install", ts.install(langs, { force = force, summary = false }))
end

---@param langs string[]
function M.update(langs)
  local ts = api()
  if not ts or #langs == 0 then
    return
  end
  report("update", ts.update(langs, { summary = false }))
end

---@param langs string[]
function M.uninstall(langs)
  local ts = api()
  if not ts or #langs == 0 then
    return
  end
  -- Uninstall deletes files, so it is the one action that asks first.
  local subject = #langs == 1 and langs[1] or ("%d parsers"):format(#langs)
  local answer = vim.fn.confirm(("Uninstall %s?"):format(subject), "&Yes\n&No", 2)
  if answer ~= 1 then
    return
  end
  report("uninstall", ts.uninstall(langs, { summary = false }))
end

return M
