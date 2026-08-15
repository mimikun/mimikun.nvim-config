Due to the previous unscientific design of provider configuration in avante.nvim, some issues arose: such as not knowing how to list all providers and being unable to distinguish between request body and regular provider configuration. Therefore, the configuration items for providers have been restructured:

1. The configurations for all **built-in providers** have been moved from the top level of all configurations to under the `providers` field.
2. The configurations for all **custom providers** have been moved from `vendors` to under the `providers` field.
3. All **request body** fields (such as `temperature`, `max_tokens`, `max_completion_tokens`, `reasoning_effort`, `options` for ollama provider) of a provider have been moved from the top level of their respective provider's configuration to the `extra_request_body` field within that provider's configuration.

## Migration Example:

For instance, if your previous configuration was as follows (using lazy.nvim as an example):

```lua
{
  "yetone/avante.nvim",
  --- other configuration items ...
  opts = {
    --- other configuration items ...
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      temperature = 0,
      max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    },
    ollama = {
      endpoint = "http://127.0.0.1:11434",
      timeout = 30000, -- Timeout in milliseconds
      options = {
        temperature = 0.75,
        num_ctx = 20480,
        keep_alive = "5m",
      },
    },
    vendors = {
      groq = {
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        model = 'llama-3.3-70b-versatile',
        temperature = 1,
        max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        disable_tools = true,
      },
    },
  },
  --- other configuration items
}
```

You need to migrate it like this:

```lua
{
  "yetone/avante.nvim",
  --- other configuration items ...
  opts = {
    --- other configuration items ...
    providers = {
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        extra_request_body = {
          temperature = 0,
          max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
          reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        },
      },
      ollama = {
        endpoint = "http://127.0.0.1:11434",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          options = {
            temperature = 0.75,
            num_ctx = 20480,
            keep_alive = "5m",
          },
        },
      },
      groq = {
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        model = 'llama-3.3-70b-versatile',
        disable_tools = true,
        extra_request_body = {
          temperature = 1,
          max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        },
      },
    },
  },
  --- other configuration items
}
```


