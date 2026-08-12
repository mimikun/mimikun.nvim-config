---@type sidekick.cli.Config
return {
  cmd = { "qwen" },
  is_proc = "\\<qwen\\>",
  url = "https://github.com/QwenLM/qwen-code",
  mux_focus = true, -- qwen needs focus in order to process input
  format = function(text)
    require("sidekick.text").transform(text, function(str)
      return str:gsub("([^%w/_%.%-])", "\\%1")
    end, "SidekickLocFile")
  end,
}
