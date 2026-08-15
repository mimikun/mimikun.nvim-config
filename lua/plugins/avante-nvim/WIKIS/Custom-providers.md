To add support for custom providers, one add `AvanteProvider` spec into `opts.providers`:

```lua
{
  provider = "my-custom-provider", -- You can then change this provider here
  providers = {
    ["my-custom-provider"] = {...}
  },
}

```

A custom provider should following the following spec:

```lua
---@type AvanteProvider
["my-custom-provider"] = {
  endpoint = "https://api.openai.com/v1/chat/completions", -- The full endpoint of the provider
  model = "gpt-4o", -- The model name to use with this provider
  api_key_name = "OPENAI_API_KEY", -- The name of the environment variable that contains the API key
  --- This function below will be used to parse in cURL arguments.
  --- It takes in the provider options as the first argument, followed by code_opts retrieved from given buffer.
  --- This code_opts include:
  --- - question: Input from the users
  --- - code_lang: the language of given code buffer
  --- - code_content: content of code buffer
  --- - selected_code_content: (optional) If given code content is selected in visual mode as context.
  ---@type fun(opts: AvanteProvider, code_opts: AvantePromptOptions): AvanteCurlOutput
  parse_curl_args = function(opts, code_opts) end
  --- This function will be used to parse incoming SSE stream
  --- It takes in the data stream as the first argument, followed by SSE event state, and opts
  --- retrieved from given buffer.
  --- This opts include:
  --- - on_chunk: (fun(chunk: string): any) this is invoked on parsing correct delta chunk
  --- - on_complete: (fun(err: string|nil): any) this is invoked on either complete call or error chunk
  ---@type fun(data_stream: string, event_state: string, opts: ResponseParser): nil
  parse_response = function(data_stream, event_state, opts) end
  --- The following function SHOULD only be used when providers doesn't follow SSE spec [ADVANCED]
  --- this is mutually exclusive with parse_response_data
  ---@type fun(data: string, handler_opts: AvanteHandlerOptions): nil
  parse_stream_data = function(data, handler_opts) end
}
```


## OpenAI Compatible Providers

You can use the `__inherited_from` field to inherit any of our built-in [providers](https://github.com/yetone/avante.nvim/tree/main/lua/avante/providers), so you can easily add an OpenAI Compatible vendor, for example:

### openrouter

```lua
provider = "openrouter",
providers = {
  openrouter = {
    __inherited_from = 'openai',
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'deepseek/deepseek-r1',
  },
},
```

### groq

```lua
provider = "groq",
providers = {
  groq = {
    __inherited_from = "openai",
    api_key_name = "GROQ_API_KEY",
    endpoint = "https://api.groq.com/openai/v1/",
    model = "llama-3.1-70b-versatile",
  },
},
```

### perplexity

```lua
provider = "perplexity",
providers = {
  perplexity = {
    __inherited_from = "openai",
    api_key_name = "cmd:bw get notes perplexity-api-key",
    endpoint = "https://api.perplexity.ai",
    model = "llama-3.1-sonar-large-128k-online",
  },
},
```

### deepseek

```lua
provider = "deepseek",
providers = {
  deepseek = {
    __inherited_from = "openai",
    api_key_name = "DEEPSEEK_API_KEY",
    endpoint = "https://api.deepseek.com",
    model = "deepseek-coder",
  },
},
```

### qwen-coder

```lua
provider = "qianwen",
providers = {
  qianwen = {
    __inherited_from = "openai",
    api_key_name = "DASHSCOPE_API_KEY",
    endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
    model = "qwen-coder-plus-latest",
  },
},
```

### mistral

```lua
provider = "mistral",
providers = {
  mistral= {
    __inherited_from = "openai",
    api_key_name = "MISTRAL_API_KEY",
    endpoint = "https://api.mistral.ai/v1/",
    model = "mistral-large-latest",
    extra_request_body = {
      max_tokens = 4096, -- to avoid using max_completion_tokens
    },
  },
},
```

### ollama

> [!WARNING]
> Because ollama has become the first-class provider for avante.nvim, the above configuration is no longer valid. If you have defined ollama in vendors, please delete it and enable ollama using this method:

```lua
provider = "ollama",
providers = {
  ollama = {
    endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
    model = "qwq:32b",
  },
},
```

## Cody

See https://github.com/yetone/avante.nvim/pull/810/files

```lua
local role_map = {
  user = "human",
  assistant = "assistant",
  system = "system",
}

local parse_messages = function(opts)
  local messages = {
    { role = "system", content = opts.system_prompt },
  }
  vim
    .iter(opts.messages)
    :each(function(msg) table.insert(messages, { speaker = role_map[msg.role], text = msg.content }) end)
  return messages
end

local parse_response = function(data_stream, event_state, opts)
  if event_state == "done" then
    opts.on_complete()
    return
  end

  if data_stream == nil or data_stream == "" then return end

  local json = vim.json.decode(data_stream)
  local delta = json.deltaText
  local stopReason = json.stopReason

  if stopReason == "end_turn" then return end

  opts.on_chunk(delta)
end

---@type AvanteProvider
cody = {
  endpoint = "https://sourcegraph.com",
  model = "anthropic::2024-10-22::claude-3-5-sonnet-latest",
  api_key_name = "SRC_ACCESS_TOKEN",
  --- This function below will be used to parse in cURL arguments.
  --- It takes in the provider options as the first argument, followed by code_opts retrieved from given buffer.
  --- This code_opts include:
  --- - question: Input from the users
  --- - code_lang: the language of given code buffer
  --- - code_content: content of code buffer
  --- - selected_code_content: (optional) If given code content is selected in visual mode as context.
  ---@type fun(opts: AvanteProvider, code_opts: AvantePromptOptions): AvanteCurlOutput
  parse_curl_args = function(opts, code_opts)
    local headers = {
      ["Content-Type"] = "application/json",
      ["Authorization"] = "token " .. os.getenv(opts.api_key_name),
    }

    return {
      url = opts.endpoint .. "/.api/completions/stream?api-version=2&client-name=web&client-version=0.0.1",
      timeout = base.timeout,
      insecure = false,
      headers = headers,
      body = vim.tbl_deep_extend("force", {
        model = opts.model,
        temperature = 0,
        topK = -1,
        topP = -1,
        maxTokensToSample = 4000,
        stream = true,
        messages = M.parse_messages(code_opts),
      }, {}),
    }
  end,
  parse_response = parse_response,
  parse_messages = parse_messages,
}
```

## custom parser for line call [ADVANCED ONLY]

If certain providers don't follow SSE streaming spec, you might want to implement `parse_stream_data` for your custom providers.

See [parse_and_call](https://github.com/yetone/avante.nvim/blob/main/lua/avante/llm.lua) implementation for more information.
