-- Aliases a filetype to an existing filetype tag config
---@type { [string]: string }
local aliases = {
  ["astro"] = "html",
  ["dot"] = "html",
  ["eruby"] = "html",
  ["liquid"] = "html",
  ["vue"] = "html",
  ["vento"] = "html",
  ["htmlangular"] = "html",
  ["htmldjango"] = "html",
  ["markdown"] = "html",
  ["php"] = "html",
  ["twig"] = "html",
  ["blade"] = "html",
  ["elixir"] = "heex",
  ["javascriptreact"] = "typescriptreact",
  ["javascript.jsx"] = "typescriptreact",
  ["typescript.tsx"] = "typescriptreact",
  ["javascript"] = "typescriptreact",
  ["typescript"] = "typescriptreact",
  ["rescript"] = "typescriptreact",
  ["handlebars"] = "glimmer",
  ["javascript.glimmer"] = "typescript.glimmer",
  ["hbs"] = "glimmer",
  ["rust"] = "rust",
}

return aliases
