local opts = {
  -- TODO: it
}

local theta = require("alpha.themes.theta")
local button = require("alpha.themes.dashboard").button

-- Buttons
theta.buttons.val = {
  { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
  { type = "padding", val = 1 },
  button("e", "󰝒  New file", "<cmd>ene<CR>"),
  { type = "padding", val = 1 },
  button("u", "󰚰  Update plugins", "<cmd>Lazy sync<CR>"),
  { type = "padding", val = 1 },
  button("t", "󰝒  Open Daily Note", "<cmd>Telekasten goto_today<CR>"),
  { type = "padding", val = 1 },
  button("z", "󰝒  Open Telekasten Panel", "<cmd>Telekasten<CR>"),
  { type = "padding", val = 1 },
  button("q", "󰅚  Quit", "<cmd>qa<CR>"),
}

-- Layout (header + buttons)
theta.config.layout = {
  { type = "padding", val = 2 },
  theta.header,
  { type = "padding", val = 2 },
  theta.buttons,
}

opts = theta.config

return opts
