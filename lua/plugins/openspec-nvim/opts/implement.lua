---@type table
local implement = {
  default_profile = "implementation",
  goal = "off",
  profiles = {
    implementation = {
      model = "gpt-5.5",
      effort = "high",
      layout = "auto",
    },
  },
  providers = {
    codex = {
      command_template = "codex {model_flag} {effort_flag} {initial_prompt}",
      effort_flag = "-c model_reasoning_effort={effort}",
      model_flag = "--model {model}",
      model = "gpt-5.5",
      effort = "high",
    },
    claude = {
      command_template = "claude {model_flag} {effort_flag} {context_prompt}",
      model_flag = "--model {model}",
      effort_flag = "--effort {effort}",
      model = "sonnet",
      effort = "high",
    },
    opencode = {
      command_template = "opencode --context {context_file} --model {model} --effort {effort}",
    },
  },
  layouts = {
    non_tmux = "nvim-right",
  },
  tmux = {
    min_pane_width_for_right = 140,
  },
  external = {
    command_template = nil,
  },
  worktree = {
    mode = "off",
    root = ".worktrees",
    branch_template = "openspec/{change}",
    base = "HEAD",
    redirect = true,
    post_create = nil,
    init_submodules = false,
  },
}

return implement
