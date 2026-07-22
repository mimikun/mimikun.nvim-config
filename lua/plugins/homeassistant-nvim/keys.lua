---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>hd",
    function()
      require("homeassistant.ui.dashboard").toggle()
    end,
    mode = {
      "n",
    },
    desc = "HA Dashboard",
    silent = true,
  },
  {
    "<leader>hp",
    function()
      require("homeassistant.ui.picker").entities()
    end,
    mode = {
      "n",
    },
    desc = "HA Entity Picker",
    silent = true,
  },
  {
    "<leader>hr",
    function()
      local ha = require("homeassistant")
      local ha_lsp = ha._lsp_client

      if ha_lsp and ha_lsp.is_connected() then
        local client = ha_lsp.get_client()
        if client then
          client.request("workspace/executeCommand", {
            command = "homeassistant.reloadCache",
            arguments = {},
          }, function(err, _result)
            if err then
              local err_msg = type(err) == "table" and err.message or tostring(err)
              vim.notify("Failed to reload cache: " .. err_msg, vim.log.levels.ERROR)
            else
              vim.notify("Reloading Home Assistant cache...", vim.log.levels.INFO)
            end
          end)
        end
      else
        vim.notify("LSP not connected", vim.log.levels.ERROR)
      end
    end,
    mode = {
      "n",
    },
    desc = "HA Reload Cache",
    silent = true,
  },
  {
    "<leader>hD",
    function()
      local ha = require("homeassistant")
      local ha_lsp = ha._lsp_client

      local ok, err = pcall(function()
        local info = {
          "=== Home Assistant Plugin Debug ===",
          "Plugin initialized: " .. tostring(ha._initialized),
          "LSP client: " .. tostring(ha_lsp ~= nil),
        }

        -- Check LSP connection
        if ha_lsp then
          local lsp_connected = ha_lsp.is_connected()
          table.insert(info, "LSP connected: " .. tostring(lsp_connected))
        end

        -- Check filetype
        table.insert(info, "Current filetype: " .. vim.bo.filetype)

        vim.notify(table.concat(info, "\n"), vim.log.levels.INFO)
      end)

      if not ok then
        vim.notify("HADebug error: " .. tostring(err), vim.log.levels.ERROR)
      end
    end,
    mode = {
      "n",
    },
    desc = "HA Debug Info",
    silent = true,
  },
  {
    "<leader>he",
    function()
      require("homeassistant.ui.dashboard_editor").pick_dashboard()
    end,
    mode = {
      "n",
    },
    desc = "HA Edit Dashboard",
    silent = true,
  },
}

return keys
