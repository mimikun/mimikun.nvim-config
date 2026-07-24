---@class deck.x.spinner.Spinner
---@field get fun(): string

local spinner = {}

---Create spinner object.
---@class deck.x.spinner.create.Config
---@field interval_ms integer
---@field frames string[]
---@param config? deck.x.spinner.create.Config
---@return deck.x.spinner.Spinner
function spinner.create(config)
  config = config or {
    interval_ms = 64,
    frames = {
      '.',
      '..',
      '...',
      '....',
      '...',
      '..',
      '.',
      '',
    },
  }

  local now = vim.uv.hrtime() / 1e6
  local idx = 1
  return {
    get = function()
      local diff = (vim.uv.hrtime() / 1e6) - now
      if diff >= config.interval_ms then
        now = vim.uv.hrtime() / 1e6
        idx = idx + 1
        if idx > #config.frames then
          idx = 1
        end
      end
      return config.frames[idx]
    end
  }
end

return spinner
