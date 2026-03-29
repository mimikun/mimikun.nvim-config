-- TODO: it

---@type function
local builds = function()
  local build_cmd = "cd devglobe-core && npm install && npm run build && git restore package-lock.json"
  return build_cmd
end

return builds
