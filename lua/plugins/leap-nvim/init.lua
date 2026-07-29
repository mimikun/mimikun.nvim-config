---@type LazySpec
local spec = {
  url = "https://codeberg.org/andyg/leap.nvim",
  lazy = false,
  -- mirror
  --url = "https://git.disroot.org/andyg/leap.nvim",
  dependencies = require("plugins.leap-nvim.dependencies"),
  config = function()
    -- Leap has no setup(); options are assigned onto `require("leap").opts`.
    local opts = require("plugins.leap-nvim.opts")
    local leap = require("leap")
    for key, value in pairs(opts) do
      leap.opts[key] = value
    end

    -- Single-key bindings follow the upstream README. `S` is not available:
    -- surround-ui.nvim owns it in normal mode (root_key = "S") and nvim-surround owns it in visual mode.
    vim.keymap.set(
      {
        "n",
        "x",
        "o",
      },
      "s",
      "<Plug>(leap)",
      {
        desc = "Leap (current window)",
      }
    )

    -- Remote operations. `gs` / `gS` / `R` / `ar` / `ir` are the README's own assignments, so its examples (`ygs{leap}$`, `d2gS{leap}`, `yarp{leap}`) work verbatim.
    -- `gS` only collides with nvim-surround in visual mode, and leap claims it in normal/operator-pending only.
    vim.keymap.set(
      {
        "n",
        "o",
      },
      "gs",
      "<Plug>(leap-remote)",
      {
        desc = "Leap remote",
      }
    )
    vim.keymap.set(
      {
        "n",
        "o",
      },
      "gS",
      "<Plug>(leap-remote-linewise)",
      {
        desc = "Leap remote (linewise)",
      }
    )
    vim.keymap.set(
      {
        "o",
      },
      "R",
      "<Plug>(leap-remote-line)",
      {
        desc = "Leap remote (line)",
      }
    )
    vim.keymap.set(
      {
        "x",
        "o",
      },
      "ar",
      "<Plug>(leap-remote-text-object)",
      {
        desc = "Leap remote text object (a)",
      }
    )
    vim.keymap.set(
      {
        "x",
        "o",
      },
      "ir",
      "<Plug>(leap-remote-inner-text-object)",
      {
        desc = "Leap remote text object (i)",
      }
    )

    -- Treesitter node selection ships no <Plug> mapping, only the Lua API.
    vim.keymap.set(
      {
        "x",
        "o",
      },
      "an",
      function()
        require("leap.treesitter").select({
          opts = require("leap.user").with_traversal_keys("n", "N"),
        })
      end,
      {
        desc = "Leap treesitter node",
      }
    )

    -- Lower-frequency targets live under the <leader>l namespace.
    -- `<Plug>(leap-from-window)` used to sit on `gs`;
    -- the README needs that key for remote, so it moved here.
    vim.keymap.set(
      {
        "n",
        "x",
        "o",
      },
      "<leader>lw",
      "<Plug>(leap-from-window)",
      {
        desc = "Leap (other windows)",
      }
    )
    vim.keymap.set(
      {
        "n",
        "x",
        "o",
      },
      "<leader>la",
      "<Plug>(leap-anywhere)",
      {
        desc = "Leap (all windows)",
      }
    )
    vim.keymap.set(
      {
        "n",
        "x",
        "o",
      },
      "<leader>lf",
      "<Plug>(leap-forward)",
      {
        desc = "Leap forward",
      }
    )
    vim.keymap.set(
      {
        "n",
        "x",
        "o",
      },
      "<leader>lb",
      "<Plug>(leap-backward)",
      {
        desc = "Leap backward",
      }
    )
    vim.keymap.set(
      {
        "n",
        "x",
        "o",
      },
      "<leader>lF",
      "<Plug>(leap-forward-next-to)",
      {
        desc = "Leap forward (till)",
      }
    )
    vim.keymap.set(
      {
        "n",
        "x",
        "o",
      },
      "<leader>lB",
      "<Plug>(leap-backward-next-to)",
      {
        desc = "Leap backward (till)",
      }
    )
    vim.keymap.set(
      {
        "n",
        "x",
        "o",
      },
      "<leader>lt",
      "<Plug>(leap-next-to)",
      {
        desc = "Leap current window (till)",
      }
    )
  end,
  --cond = false,
  --enabled = false,
}

return spec
