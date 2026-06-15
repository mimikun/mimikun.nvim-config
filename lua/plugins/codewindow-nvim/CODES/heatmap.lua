local M = {}

local api = vim.api

local tiktoken = nil
local encoder_ready = false
local init_failed = false

local CL100K_PATTERN = "(?i:'s|'t|'re|'ve|'m|'ll|'d)|[^\\r\\n\\p{L}\\p{N}]?\\p{L}+|\\p{N}{1,3}"
  .. "| ?[^\\s\\p{L}\\p{N}]+[\\r\\n]*|\\s*[\\r\\n]+|\\s+(?!\\S)|\\s+"

local CL100K_URL = "https://openaipublic.blob.core.windows.net/encodings/cl100k_base.tiktoken"
local download_in_progress = false

local CL100K_CACHE_KEY = "9b5ad71b2ce5302211f9c61530b329a4922fc6a4"

local function resolve_cache_dir()
  local dir = os.getenv("TIKTOKEN_CACHE_DIR")
  if dir then
    return dir
  end
  dir = os.getenv("DATA_GYM_CACHE_DIR")
  if dir then
    return dir
  end
  local tmpdir = os.getenv("TMPDIR") or os.getenv("TEMP") or os.getenv("TMP") or "/tmp"
  return tmpdir .. "/data-gym-cache"
end

local function resolve_vocab_path(config_path)
  if config_path then
    return config_path
  end
  local cache_dir = resolve_cache_dir()
  return cache_dir .. "/" .. CL100K_CACHE_KEY
end

local heatmap_palette = {
  "#3b4252",
  "#4c566a",
  "#5e81ac",
  "#5e9eaf",
  "#6abf69",
  "#b5bd68",
  "#e5c07b",
  "#e09050",
  "#d45d5d",
  "#ff4040",
}

function M.setup()
  for i, hex in ipairs(heatmap_palette) do
    api.nvim_set_hl(0, "CodewindowHeatmap" .. i, { fg = hex, default = true })
  end
end

local function file_exists(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  end
  return false
end

local function finish_init(mod, path, special_tokens)
  local init_ok, err = pcall(mod.new, path, special_tokens or {}, CL100K_PATTERN)
  if not init_ok then
    vim.notify("codewindow: tiktoken init failed: " .. tostring(err), vim.log.levels.WARN)
    init_failed = true
    return false
  end
  tiktoken = mod
  encoder_ready = true
  return true
end

local function download_vocab(path, callback)
  if download_in_progress then
    return
  end
  download_in_progress = true

  local dir = vim.fn.fnamemodify(path, ":h")
  vim.fn.mkdir(dir, "p")

  vim.notify("codewindow: downloading tiktoken vocab...", vim.log.levels.INFO)

  vim.system(
    { "curl", "-sfL", "-o", path, CL100K_URL },
    {},
    vim.schedule_wrap(function(result)
      download_in_progress = false
      if result.code ~= 0 then
        vim.notify("codewindow: vocab download failed (curl exit " .. result.code .. ")", vim.log.levels.WARN)
        init_failed = true
        return
      end
      vim.notify("codewindow: tiktoken vocab downloaded", vim.log.levels.INFO)
      callback()
    end)
  )
end

local function init_encoder()
  if init_failed or download_in_progress then
    return false
  end

  local ok, mod = pcall(require, "tiktoken_core")
  if not ok then
    vim.notify("codewindow: tiktoken_core not found, heatmap disabled", vim.log.levels.WARN)
    init_failed = true
    return false
  end

  local config = require("codewindow.config").get()
  local path = resolve_vocab_path(config.heatmap_encoder_path)

  if not file_exists(path) then
    download_vocab(path, function()
      finish_init(mod, path, config.heatmap_special_tokens)
    end)
    return false
  end

  return finish_init(mod, path, config.heatmap_special_tokens)
end

function M.compute(lines)
  if not encoder_ready and not init_encoder() then
    return nil
  end

  local cfg = require("codewindow.config").get()
  local minimap_width = cfg.minimap_width
  local col_span = cfg.width_multiplier * 2
  local minimap_height = math.ceil(#lines / 4)
  if minimap_height == 0 then
    return nil
  end

  local counts = {}
  local nonzero = {}

  for y = 1, minimap_height do
    counts[y] = {}
    local start_line = (y - 1) * 4 + 1
    local end_line = math.min(y * 4, #lines)

    for x = 1, minimap_width do
      local col_start = (x - 1) * col_span + 1
      local col_end = x * col_span
      local parts = {}
      for row = start_line, end_line do
        local line = lines[row] or ""
        local sub = line:sub(col_start, col_end)
        if #sub > 0 then
          parts[#parts + 1] = sub
        end
      end
      if #parts > 0 then
        local tokens = tiktoken.encode(table.concat(parts, "\n"))
        local count = #tokens
        counts[y][x] = count
        if count > 0 then
          nonzero[#nonzero + 1] = count
        end
      else
        counts[y][x] = false
      end
    end
  end

  local density = {}

  if #nonzero == 0 then
    for y = 1, minimap_height do
      density[y] = {}
      for x = 1, minimap_width do
        density[y][x] = 0
      end
    end
    return density
  end

  local lo, hi

  if #nonzero < 3 then
    table.sort(nonzero)
    lo = nonzero[1]
    hi = nonzero[#nonzero]
  else
    table.sort(nonzero)
    lo = nonzero[math.max(1, math.floor(#nonzero * 0.10))]
    hi = nonzero[math.min(#nonzero, math.ceil(#nonzero * 0.90))]
  end

  local range = hi - lo

  for y = 1, minimap_height do
    density[y] = {}
    for x = 1, minimap_width do
      local c = counts[y][x]
      if not c or c == 0 then
        density[y][x] = 0
      elseif range == 0 then
        density[y][x] = 5
      else
        local clamped = math.max(lo, math.min(c, hi))
        local norm = (clamped - lo) / range
        density[y][x] = math.max(1, math.min(10, math.floor(norm * 9) + 1))
      end
    end
  end

  return density
end

return M
