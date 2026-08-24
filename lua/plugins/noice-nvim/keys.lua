---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>nl",
    function()
      require("noice").cmd("last")
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>nh",
    function()
      require("noice").cmd("history")
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  -- Command Redirection
  {
    "<S-Enter>",
    function()
      require("noice").redirect(vim.fn.getcmdline())
    end,
    mode = {
      "c",
    },
    desc = "Redirect Cmdline",
    silent = true,
  },
  -- Lsp Hover Doc Scrolling
  {
    "<c-f>",
    function()
      if not require("noice.lsp").scroll(4) then
        return "<c-f>"
      end
    end,
    mode = {
      "n",
      "i",
      "s",
    },
    desc = "Lsp Hover Doc Scrolling - Down",
    expr = true,
    silent = true,
  },
  {
    "<c-b>",
    function()
      if not require("noice.lsp").scroll(-4) then
        return "<c-b>"
      end
    end,
    mode = {
      "n",
      "i",
      "s",
    },
    desc = "Lsp Hover Doc Scrolling - Up",
    expr = true,
    silent = true,
  },
}

return keys
