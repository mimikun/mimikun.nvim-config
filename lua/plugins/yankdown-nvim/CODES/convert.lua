local M = {}

local pandoc_args = {
  "pandoc",
  "-f",
  "html",
  "-t",
  "gfm-raw_html",
  "--wrap=none",
}

function M.html_to_markdown(html, callback)
  if vim.fn.executable("pandoc") ~= 1 then
    callback(nil, "missing-pandoc")
    return
  end

  vim.system(pandoc_args, { text = true, stdin = html }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        callback(nil, "pandoc-failed")
        return
      end

      callback((result.stdout or ""):gsub("\r", ""), nil)
    end)
  end)
end

return M
