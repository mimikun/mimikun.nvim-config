-- Core logic.
--
-- Each `.term` buffer is a real built-in terminal (`jobstart(shell, { term =
-- true })`). That matters for interoperability: the buffer's 'channel' is the
-- shell's PTY, so other terminal plugins (e.g. editable-term.nvim, which sends
-- keystrokes with `chansend(vim.bo.channel, ...)`) work, and `TermOpen` fires
-- so they attach. It also inherits real terminal behaviour for free -- no line
-- numbers, non-editable output, automatic resize.
--
-- Recording still works because a `term = true` job with an `on_stdout` callback
-- does *both*: Neovim renders the output to the buffer and hands us the raw
-- bytes (see Neovim's `on_channel_output`). We keep the exact raw stream so
-- replaying it on reopen reproduces the previous session's output with its
-- original colors -- the terminal re-parses the escape sequences.
--
-- History is replayed by `cat`-ing the recorded bytes into the terminal before
-- `exec`-ing the shell, so the previous output is printed (and re-recorded)
-- without being fed to the shell as input.

local session = require("termfile.session")

local M = {}

-- bufnr -> { job, path, chunks, bytes, max }
local state = {}

local function notify_err(msg)
  vim.schedule(function()
    vim.notify("[termfile] " .. msg, vim.log.levels.ERROR)
  end)
end

--- Is this buffer a termfile-managed terminal?
---@param bufnr integer
---@return boolean
function M.is_managed(bufnr)
  return state[bufnr] ~= nil
end

--- Append recorded output, keeping memory bounded to ~2x the byte cap.
local function record(st, data)
  st.chunks[#st.chunks + 1] = data
  st.bytes = st.bytes + #data
  if st.bytes > st.max * 2 then
    local s = table.concat(st.chunks)
    if #s > st.max then
      s = s:sub(#s - st.max + 1)
    end
    st.chunks = { s }
    st.bytes = #s
  end
end

--- Shell-escape and join a shell spec (string or list) into one command string.
---@param shell string|string[]
---@return string
local function shell_command_string(shell)
  local parts = {}
  local list = type(shell) == "table" and shell or { shell }
  for _, p in ipairs(list) do
    parts[#parts + 1] = vim.fn.shellescape(p)
  end
  return table.concat(parts, " ")
end

--- Build the launch command, replaying `previous` raw output first when given.
---@param shell string|string[]
---@param previous string|nil
---@param delimiter string
---@return string|string[] cmd
local function build_command(shell, previous, delimiter)
  local can_replay = previous and #previous > 0 and vim.fn.has("win32") == 0 and vim.fn.executable("/bin/sh") == 1
  if not can_replay then
    return shell
  end

  -- Materialize the recording and print it via a POSIX shell, then `exec` the
  -- real shell in its place. The path is passed as $1 to avoid quoting issues.
  local tmp = vim.fn.tempname()
  local fd = io.open(tmp, "wb")
  if not fd then
    return shell
  end
  fd:write(previous, delimiter)
  fd:close()

  local script = 'cat -- "$1"; rm -f -- "$1"; exec ' .. shell_command_string(shell)
  return { "/bin/sh", "-c", script, "termfile", tmp }
end

--- Convert an (empty) `.term` buffer into a live, recording terminal.
---@param bufnr integer
---@param path string absolute path to the `.term` file
---@param config table
function M.open(bufnr, path, config)
  if M.is_managed(bufnr) then
    return
  end
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local shell = config.shell or vim.o.shell
  local previous = config.restore and session.read_raw(path) or nil

  -- Recover the last working directory from the recording (an OSC 7 escape we
  -- embed on save). Fall back to the directory the `.term` file lives in.
  local dir
  local saved_cwd = previous and session.cwd_from_recording(previous) or nil
  if saved_cwd and vim.fn.isdirectory(saved_cwd) == 1 then
    dir = saved_cwd
  else
    dir = vim.fn.fnamemodify(path, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      dir = vim.fn.getcwd()
    end
  end

  local cmd = build_command(shell, previous, config.delimiter)

  local st = { path = path, chunks = {}, bytes = 0, max = config.max_bytes, job = nil }
  state[bufnr] = st

  -- Launch the built-in terminal in this buffer. `term = true` renders output
  -- *and* (because we pass on_stdout) hands us the raw bytes to record.
  local job
  vim.api.nvim_buf_call(bufnr, function()
    local ok, result = pcall(vim.fn.jobstart, cmd, {
      term = true,
      cwd = dir,
      on_stdout = function(_, data, _)
        if not data then
          return
        end
        local s = table.concat(data, "\n") -- reconstruct the raw bytes
        if s ~= "" then
          record(st, s)
        end
      end,
    })
    if ok then
      job = result
    else
      notify_err("failed to start terminal: " .. tostring(result))
    end
  end)

  if not job or type(job) ~= "number" or job <= 0 then
    state[bufnr] = nil
    return
  end
  st.job = job

  -- `term = true` renamed the buffer to `term://...`; restore its identity so
  -- pickers/grep/etc. see `watcher.term`.
  local term_name = vim.api.nvim_buf_get_name(bufnr)
  pcall(vim.api.nvim_buf_set_name, bufnr, path)
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if b ~= bufnr and vim.api.nvim_buf_get_name(b) == term_name then
      pcall(vim.api.nvim_buf_delete, b, { force = true })
    end
  end

  vim.b[bufnr].termfile_path = path
  vim.bo[bufnr].buflisted = true
  pcall(function()
    vim.bo[bufnr].modified = false
  end)

  if config.start_insert and vim.api.nvim_get_current_buf() == bufnr then
    vim.schedule(function()
      if vim.api.nvim_get_current_buf() == bufnr then
        vim.cmd("startinsert")
      end
    end)
  end
end

--- Best-effort lookup of the shell's current working directory (Linux).
---@param st table
---@return string|nil
local function shell_cwd(st)
  if not st.job then
    return nil
  end
  local ok, pid = pcall(vim.fn.jobpid, st.job)
  if not ok or type(pid) ~= "number" or pid <= 0 then
    return nil
  end
  local uv = vim.uv or vim.loop
  local okl, target = pcall(uv.fs_readlink, "/proc/" .. pid .. "/cwd")
  if okl and target and target ~= "" then
    return target
  end
  return nil
end

--- Persist the recorded output (trimmed to the byte cap) into the `.term` file.
--- The shell's current directory is embedded as an invisible OSC 7 sequence so
--- it can be recovered on the next open.
---@param bufnr integer
function M.save(bufnr)
  local st = state[bufnr]
  if not st then
    return
  end
  local cwd = shell_cwd(st)
  if cwd then
    record(st, session.osc7(cwd))
  end
  local s = table.concat(st.chunks)
  if #s > st.max then
    s = s:sub(#s - st.max + 1)
  end
  session.write_raw(st.path, s)
end

--- Persist, stop the shell, and forget the buffer.
---@param bufnr integer
function M.cleanup(bufnr)
  local st = state[bufnr]
  if not st then
    return
  end
  M.save(bufnr)
  if st.job then
    pcall(vim.fn.jobstop, st.job)
  end
  state[bufnr] = nil
end

--- All buffers currently managed as terminals.
---@return integer[]
function M.managed_buffers()
  local bufs = {}
  for bufnr in pairs(state) do
    bufs[#bufs + 1] = bufnr
  end
  return bufs
end

return M
