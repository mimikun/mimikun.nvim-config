local M = {}
local warned = {}

local messages = {
  ["missing-pandoc"] = "yankdown.nvim: pandoc not found; falling back to native paste",
  ["pandoc-failed"] = "yankdown.nvim: pandoc conversion failed; falling back to native paste",
  ["missing:osascript"] = "yankdown.nvim: osascript not found; falling back to native paste",
  ["missing:wl-paste"] = "yankdown.nvim: wl-paste not found; falling back to native paste",
  ["missing:xclip"] = "yankdown.nvim: xclip not found; falling back to native paste",
  ["missing:powershell"] = "yankdown.nvim: powershell.exe not found; falling back to native paste",
  ["clipboard-failed"] = "yankdown.nvim: HTML clipboard read failed; falling back to native paste",
  unsupported = "yankdown.nvim: HTML clipboard is unsupported on this platform; falling back to native paste",
}

local function direction(opts)
  return opts.direction == "before" and "before" or "after"
end

local function warn_once(reason, config)
  if not config.notify or warned[reason] then
    return
  end
  warned[reason] = true

  local msg = messages[reason]
  if msg then
    vim.notify(msg, vim.log.levels.WARN)
  end
end

local function lines(markdown)
  markdown = markdown:gsub("\r", "")
  return vim.split(markdown, "\n", { plain = true, trimempty = true })
end

function M.insert(markdown, dir)
  local mode = vim.api.nvim_get_mode().mode
  local out = lines(markdown)

  if mode:match("^[vV\22]") then
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    vim.api.nvim_buf_set_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3], out)
    return
  end

  if mode:sub(1, 1) == "i" then
    vim.api.nvim_put(out, "c", true, true)
    return
  end

  vim.api.nvim_put(out, "l", dir ~= "before", true)
end

function M.start(opts, config)
  local dir = direction(opts or {})
  config = config or { notify = true }

  if vim.bo.filetype ~= "markdown" then
    require("yankdown.native").paste(dir)
    return
  end

  if config.check ~= false then
    require("yankdown.check").check()
  end

  require("yankdown.clipboard").read_html(function(html, clipboard_err)
    if not html then
      if clipboard_err ~= "no-html" then
        warn_once(clipboard_err, config)
      end
      require("yankdown.native").paste(dir)
      return
    end

    require("yankdown.convert").html_to_markdown(html, function(markdown, convert_err)
      if not markdown then
        warn_once(convert_err, config)
        require("yankdown.native").paste(dir)
        return
      end

      M.insert(markdown, dir)
    end)
  end)
end

return M
