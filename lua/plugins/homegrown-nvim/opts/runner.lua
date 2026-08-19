-- Enable async code runner command
local runner = {
  enabled = true,
  interpreters = {
    python = "python3",
    ruby = "ruby",
    lua = "lua",
    javascript = "node",
    typescript = "ts-node",
    sh = "bash",
    bash = "bash",
    go = "go run",
    elixir = "elixir",
    java = "java",

    -- Add support for Rust code execution
    rust = "cargo run",
  },
}

return runner
