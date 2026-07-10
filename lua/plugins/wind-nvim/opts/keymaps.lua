---@type WindKeymaps | false
local keymaps = {
  -- Root prefix; digits on it focus windows
  ---@type string
  prefix = "<leader>",

  ---@type WindWindowKeys
  window = {
    -- Move digits and window verbs live here
    ---@type string
    namespace = "w",

    -- Focus/create with a stacked split
    ---@type string | false
    stacked = "v",

    ---@type string | false
    swap = "x",

    ---@type string | false
    close = "q",

    ---@type string | false
    save_close = "z",

    ---@type string | false
    only = "o",

    ---@type string | false
    zoom = "m",

    ---@type string | false
    undo = "u",

    ---@type string | false
    redo = "r",

    ---@type string | false
    equalize = "=",

    ---@type string | false
    grow = "+",

    ---@type string | false
    shrink = "-",
  },

  ---@type WindBreathKeys
  breath = {
    -- Return digits and breath verbs live here
    ---@type string
    namespace = "b",

    ---@type string | false
    update = "b",

    ---@type string | false
    hold = "n",

    ---@type string | false
    release = "d",

    ---@type string | false
    clear = "c",

    ---@type string | false
    alternate = "`",
  },
}

return keymaps
