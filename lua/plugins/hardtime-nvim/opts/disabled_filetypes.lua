-- Hardtime is disabled under these filetypes.
---@type table
local disabled_filetypes = {
  ["aerial"] = true,
  ["alpha"] = true,
  ["Avante"] = true,
  ["checkhealth"] = true,
  ["copilot-chat"] = true,
  ["dapui.*"] = true,
  ["db.*"] = true,
  ["Diffview.*"] = true,
  ["Dressing.*"] = true,
  ["fugitive"] = true,
  ["help"] = true,
  ["httpResult"] = true,
  ["lazy"] = true,
  ["lspinfo"] = true,
  ["man"] = true,
  ["mason"] = true,
  ["minifiles"] = true,
  ["Neogit.*"] = true,
  ["neo%-tree.*"] = true,
  ["neotest%-summary"] = true,
  ["netrw"] = true,
  ["noice"] = true,
  ["notify"] = true,
  ["NvimTree"] = true,
  ["oil"] = true,
  ["prompt"] = true,
  ["qf"] = true,
  ["query"] = true,
  ["snacks_dashboard"] = true,
  ["TelescopePrompt"] = true,
  ["Trouble"] = true,
  ["trouble"] = true,
  ["VoltWindow"] = true,
  ["undotree"] = true,
  -- NOTE: Examples

  --lazy = false, -- Enable Hardtime in lazy filetype
}

return disabled_filetypes
