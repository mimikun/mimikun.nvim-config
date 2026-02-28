---@type table
local base = require("plugins.smear-cursor-nvim.opts.base")

---@type table
local smooth_cursor_without_smear = require("plugins.smear-cursor-nvim.opts.smooth-cursor-without-smear")

---@type table
local faster = require("plugins.smear-cursor-nvim.opts.faster")

---@type table
local fire_hazard = require("plugins.smear-cursor-nvim.opts.fire-hazard")

---@type table
local opts = vim.tbl_deep_extend("force", base, fire_hazard)

return opts
