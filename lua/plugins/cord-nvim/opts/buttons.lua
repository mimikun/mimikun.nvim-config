-- Buttons configuration
---@type CordButtonConfig[]
local buttons = {
  {
    -- Button label
    ---@type string | fun(opts: CordOpts):string
    label = function(opts)
      local label = opts.repo_url and "View Repository" or "Website"
      if not opts.is_idle then
        return label
      end
    end,

    -- Button URL
    ---@type string | fun(opts: CordOpts):string
    --url = function(opts)
    --  local url = opts.repo_url

    --  if not opts.is_idle then
    --    return url
    --  end
    --end,

    -- Dynamic Button URL with Async
    url = require("cord.core.async").wrap(function(opts)
      -- check visibility only once every 5 minutes
      local is_private = opts.cache:get_or_compute(opts.workspace_dir .. ":is_repo_private", 300, function()
        local result = require("cord.core.uv.process")
          .spawn({
            cmd = "gh",
            args = {
              "repo",
              "view",
              "--json",
              "isPrivate",
              "--template",
              "{{.isPrivate}}",
            },
            cwd = opts.workspace_dir,
          })
          :await()

        -- assume private if command fails
        if not result or result.code ~= 0 then
          -- we must return a non-nil value
          return false
        end
        return vim.trim(result.stdout)
      end)

      -- hide button for private repos
      if is_private == "true" then
        return
      end

      return opts.repo_url
    end),
  },
}

return buttons
