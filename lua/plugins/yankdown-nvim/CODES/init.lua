local M = {}

local defaults = {
  auto_intercept = false,
  notify = true,
  check = "lazy",
}

M._config = vim.deepcopy(defaults)

local function map_plug(lhs, direction)
  vim.keymap.set({ "n", "x", "i" }, lhs, function()
    require("yankdown").paste({ direction = direction })
  end, { silent = true })
end

local function maybe_create_commands()
  pcall(vim.api.nvim_create_user_command, "YankdownPaste", function(args)
    local direction = args.bang and "before" or "after"
    require("yankdown").paste({ direction = direction })
  end, { bang = true })

  pcall(vim.api.nvim_create_user_command, "YankdownCheck", function()
    local ok, result = pcall(function()
      return require("yankdown.check").format()
    end)
    if ok then
      vim.notify(result, vim.log.levels.INFO)
    else
      vim.notify("yankdown.nvim: check failed — " .. tostring(result), vim.log.levels.ERROR)
    end
  end, {})
end

local function intercept_buffer(buf)
  local opts = { buffer = buf, silent = true }
  vim.keymap.set({ "n", "x" }, "p", function()
    require("yankdown").paste({ direction = "after" })
  end, opts)
  vim.keymap.set({ "n", "x" }, "P", function()
    require("yankdown").paste({ direction = "before" })
  end, opts)
end

local function maybe_intercept()
  if not M._config.auto_intercept then
    return
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    group = vim.api.nvim_create_augroup("yankdown_intercept", { clear = true }),
    callback = function(args)
      intercept_buffer(args.buf)
    end,
  })
end

function M.setup(opts)
  M._config = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
  maybe_create_commands()
  map_plug("<Plug>(yankdown-paste-after)", "after")
  map_plug("<Plug>(yankdown-paste-before)", "before")
  maybe_intercept()

  --- Optional silent startup cache. Default is "lazy": cache on first paste,
  --- not during setup, and never spam startup with dependency warnings.
  if M._config.check == "startup" or M._config.check == true then
    require("yankdown.check").check({ force = true })
  end

  return M._config
end

function M.paste(opts)
  require("yankdown.paste").start(opts or {}, M._config)
end

--- Run a dependency check manually (available as require("yankdown").check()).
---@param opts? { force?: boolean }
---@return table[]  list of dependency status tables
function M.check(opts)
  return require("yankdown.check").check(opts)
end

return M
