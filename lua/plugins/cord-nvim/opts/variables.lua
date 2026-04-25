---@alias CordVariablesConfig { [string]: string|fun(opts: CordOpts):string }
-- Variables configuration.
-- If true, uses default options table.
-- If table, extends default table.
-- If false, disables custom variables.
---@type boolean | CordVariablesConfig
local variables = {
  -- Async Git Branch
  git_branch = require("cord.core.async").wrap(function(opts)
    -- run git command only once every 30 seconds
    return opts.cache:get_or_compute(opts.workspace_dir .. ":branch", 30, function()
      local result, err = require("cord.core.uv.process")
        .spawn({
          cmd = "git",
          args = {
            "branch",
            "--show-current",
          },
          cwd = opts.workspace_dir,
        })
        :await()

      if err or result.code ~= 0 then
        -- we must return a non-nil value
        return false
      end
      return vim.trim(result.stdout)
    end)
  end),
}

return variables
