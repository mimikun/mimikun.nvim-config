-- Mode configuration (see Modes section)
-- Mode configurations and custom mode definitions
---@type table<string, ShelterModeConfig>
local modes = {
  full = {
    mask_char = "*",
    preserve_length = true,
    -- Use fixed length instead
    --fixed_length = 8,
  },

  partial = {
    mask_char = "*",
    show_start = 3,
    show_end = 3,
    min_mask = 3,
    -- Use full mode for short values
    fallback_mode = "full",
  },

  none = {
    --it
  },

  redact = {
    description = "Replace with [REDACTED]",
    apply = function(_self, _ctx)
      return "[REDACTED]"
    end,
  },

  truncate = {
    description = "Truncate with suffix",
    schema = {
      max_length = {
        type = "number",
        default = 5,
      },
      suffix = {
        type = "string",
        default = "...",
      },
    },
    apply = function(self, ctx)
      local max = self.options.max_length
      if #ctx.value <= max then
        return ctx.value
      end
      return ctx.value:sub(1, max) .. self.options.suffix
    end,
  },
}

return modes
