-- Configuration for YAML
---@type markview.config.yaml
local yaml = {
  -- Enable rendering of YAML.
  ---@type boolean
  enable = nil,

  ---@type markview.config.yaml.properties
  properties = {
    -- Enable rendering of YAML properties.
    ---@type boolean
    enable = true,

    -- Configuration for various data types.
    ---@type table<string, markview.config.yaml.properties.opts>
    data_types = {
      ["text"] = {
        text = "󰗊 ",
        hl = "MarkviewIcon4",
      },
      ["list"] = {
        text = "󰝖 ",
        hl = "MarkviewIcon5",
      },
      ["number"] = {
        text = " ",
        hl = "MarkviewIcon6",
      },
      ["checkbox"] = {
        ---@diagnostic disable
        text = function(_, item)
          return item.value == "true" and "󰄲 " or "󰄱 "
        end,
        ---@diagnostic enable
        hl = "MarkviewIcon6",
      },
      ["date"] = {
        text = "󰃭 ",
        hl = "MarkviewIcon2",
      },
      ["date_&_time"] = {
        text = "󰥔 ",
        hl = "MarkviewIcon3",
      },
    },

    -- Default configuration for properties.
    ---@type markview.config.yaml.properties.opts
    default = {
      -- When `true`, the configuration table merges with the value's data type configuration.
      ---@type boolean
      use_types = true,

      -- Scope guide border top.
      ---@type string
      border_top = nil,

      ---@type string
      --border_top_hl=nil,

      -- Scope guide border middle.
      ---@type string
      border_middle = nil,

      ---@type string
      ---border_middle_hl=nil,

      -- Scope guide border bottom.
      ---@type string
      border_bottom = nil,

      ---@type string
      --border_bottom_hl=nil,

      ---@type string
      border_hl = nil,

      ---@type string
      --hl=nil,

      ---@type string
      --text=nil,
    },

    -- Configuration for properties whose name matches `string`.
    ---@field [string] markview.config.yaml.properties.opts
    ["^tags$"] = {
      use_types = false,

      text = "󰓹 ",
      hl = "MarkviewIcon0",
    },
    ["^aliases$"] = {
      match_string = "^aliases$",
      use_types = false,

      text = "󱞫 ",
      hl = "MarkviewIcon2",
    },
    ["^cssclasses$"] = {
      match_string = "^cssclasses$",
      use_types = false,

      text = " ",
      hl = "MarkviewIcon3",
    },

    ["^publish$"] = {
      match_string = "^publish$",
      use_types = false,

      text = "󰅧 ",
      hl = "MarkviewIcon5",
    },
    ["^permalink$"] = {
      match_string = "^permalink$",
      use_types = false,

      text = " ",
      hl = "MarkviewIcon2",
    },
    ["^description$"] = {
      match_string = "^description$",
      use_types = false,

      text = "󰋼 ",
      hl = "MarkviewIcon0",
    },
    ["^image$"] = {
      match_string = "^image$",
      use_types = false,

      text = "󰋫 ",
      hl = "MarkviewIcon4",
    },
    ["^cover$"] = {
      match_string = "^cover$",
      use_types = false,

      text = "󰹉 ",
      hl = "MarkviewIcon2",
    },
  },
}

return yaml
