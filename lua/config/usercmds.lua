-- :PluginKeys [plugin] -- reverse lookup for keymaps: plugin name in, keys and descriptions out.
-- which-key answers "I pressed this prefix, what now?".
-- This answers "what did that plugin bind?".
-- :Lazy already lists a plugin's keys, but renders lhs only (lazy/view/render.lua, Keys.to_string).

local MODES = {
  "n",
  "i",
  "v",
  "x",
  "s",
  "o",
  "t",
  "c",
}
local NO_DESC = "(no desc)"

local function plugin_of(source)
  if not source then
    return nil
  end
  local name = source:match("/lazy/([^/]+)/")
  if name then
    return name
  end
  local config = vim.fn.stdpath("config")
  if source:find(config, 1, true) == 1 then
    -- Maps written by hand still live next to the plugin they belong to, so the directory under lua/plugins is a better label than one shared "(config)" bucket.
    return source:match("/lua/plugins/([^/]+)/") or "(config)"
  end
  return nil
end

-- nvim_get_keymap resolves <leader> down to its actual character, which for a space renders as an invisible column.
-- Put the readable form back.
local function normalize(lhs)
  for name, leader in pairs({
    ["<leader>"] = vim.g.mapleader,
    ["<localleader>"] = vim.g.maplocalleader,
  }) do
    if type(leader) == "string" and leader ~= "" and lhs:sub(1, #leader) == leader then
      return name .. lhs:sub(#leader + 1)
    end
  end
  return lhs
end

local function add(index, seen, plugin, mode, lhs, desc)
  if lhs == nil or lhs == "" then
    return
  end
  lhs = normalize(lhs)
  -- <Plug> mappings are wiring for other mappings, not keys anyone presses.
  if lhs:lower():sub(1, 6) == "<plug>" then
    return
  end
  local id = mode .. " " .. lhs
  if seen[id] then
    return
  end
  seen[id] = true
  index[plugin] = index[plugin] or {}
  table.insert(index[plugin], {
    lhs = lhs,
    mode = mode,
    desc = desc ~= "" and desc or nil,
  })
end

-- Keys declared in a lazy.nvim spec never reach nvim_get_keymap until the plugin loads, so this side is what makes unloaded plugins visible at all.
local function collect_from_lazy(index, seen)
  local ok, config = pcall(require, "lazy.core.config")
  if not ok then
    return
  end
  for name, plugin in pairs(config.plugins) do
    local handlers = plugin._ and plugin._.handlers
    for _, key in pairs(handlers and handlers.keys or {}) do
      add(index, seen, name, key.mode or "n", key.lhs, key.desc)
    end
  end
end

-- Everything set through vim.keymap.set directly.
-- The callback's defining file is the only attribution available, so mappings with a string rhs cannot be traced to a plugin.
local function collect_from_keymaps(index, seen, buf)
  for _, mode in ipairs(MODES) do
    local maps = buf and vim.api.nvim_buf_get_keymap(buf, mode) or vim.api.nvim_get_keymap(mode)
    for _, map in ipairs(maps) do
      local source
      if map.callback then
        local ok, info = pcall(debug.getinfo, map.callback, "S")
        if ok and info and info.source then
          source = info.source:gsub("^@", "")
        end
      end
      local plugin = plugin_of(source)
      if plugin then
        add(index, seen, plugin, mode, map.lhs, map.desc)
      end
    end
  end
end

-- A plugin can bind keys at load time on top of whatever its lazy spec declares (yankbank does exactly this), so any unloaded plugin may still be hiding maps.
-- Nothing can list those, so name the plugins instead of quietly omitting them.
local function pending_plugins()
  local ok, config = pcall(require, "lazy.core.config")
  if not ok then
    return {}
  end
  local names = {}
  for name, plugin in pairs(config.plugins) do
    if plugin._ and plugin._.loaded == nil then
      table.insert(names, name)
    end
  end
  table.sort(names)
  return names
end

local function collect(buf)
  local index, seen = {}, {}
  collect_from_lazy(index, seen)
  collect_from_keymaps(index, seen)
  -- Buffer-local maps (file explorers, Trouble, :Lazy itself) never appear in the global table, so pick up whichever buffer the command was run from.
  if buf and vim.api.nvim_buf_is_valid(buf) then
    collect_from_keymaps(index, seen, buf)
  end
  return index
end

local function plugin_names(index, filter)
  local names = {}
  for name in pairs(index) do
    if not filter or filter == "" or name:lower():find(filter:lower(), 1, true) then
      table.insert(names, name)
    end
  end
  table.sort(names)
  return names
end

local function build_lines(index, names, pending)
  local width, total = 0, 0
  for _, name in ipairs(names) do
    for _, entry in ipairs(index[name]) do
      width = math.max(width, #entry.lhs)
      total = total + 1
    end
  end
  width = math.min(width, 30)

  local lines = { ("%d plugins, %d keymaps"):format(#names, total), "" }
  for _, name in ipairs(names) do
    local entries = index[name]
    table.sort(entries, function(a, b)
      if a.lhs == b.lhs then
        return a.mode < b.mode
      end
      return a.lhs < b.lhs
    end)
    table.insert(lines, ("%s (%d)"):format(name, #entries))
    for _, entry in ipairs(entries) do
      local pad = string.rep(" ", math.max(width - #entry.lhs, 0))
      table.insert(lines, ("  %s%s  %-2s  %s"):format(entry.lhs, pad, entry.mode, entry.desc or NO_DESC))
    end
    table.insert(lines, "")
  end
  if pending and #pending > 0 then
    table.insert(lines, ("not loaded yet, may bind more (%d): %s"):format(#pending, table.concat(pending, ", ")))
  end
  return lines
end

local function open(lines)
  vim.cmd("botright new")
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "pluginkeys"
  vim.api.nvim_buf_set_name(buf, "PluginKeys")
  vim.keymap.set("n", "q", "<cmd>close<cr>", {
    buffer = buf,
    nowait = true,
  })
end

vim.api.nvim_create_user_command("PluginKeys", function(opts)
  local index = collect(vim.api.nvim_get_current_buf())
  local names = plugin_names(index, opts.args)
  if #names == 0 then
    vim.notify(("PluginKeys: no plugin matches %q"):format(opts.args), vim.log.levels.WARN)
    return
  end
  open(build_lines(index, names, pending_plugins()))
end, {
  nargs = "?",
  desc = "List keymaps with descriptions, grouped by the plugin that defined them",
  complete = function(lead)
    return plugin_names(collect(vim.api.nvim_get_current_buf()), lead)
  end,
})
