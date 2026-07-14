local M = {}

local function executable(name)
  return vim.fn.executable(name) == 1
end

local function parse_macos_html(payload)
  if not payload or payload == "" then
    return nil, "no-html"
  end

  local hex = payload:match("^%s*«data HTML([%x]+)»%s*$")
  if hex then
    local html = hex:gsub("..", function(byte)
      return string.char(tonumber(byte, 16))
    end)
    return html ~= "" and html or nil, html == "" and "no-html" or nil
  end

  if payload:match("^%s*<") then
    return payload, nil
  end

  return nil, "no-html"
end

function M.provider()
  if vim.fn.has("macunix") == 1 then
    if executable("osascript") then
      return {
        name = "macos",
        command = {
          "osascript",
          "-e",
          "try",
          "-e",
          "the clipboard as «class HTML»",
          "-e",
          "on error",
          "-e",
          "the clipboard as text",
          "-e",
          "end try",
        },
        parse = parse_macos_html,
      }
    end
    return nil, "missing:osascript"
  end

  if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    if executable("powershell.exe") then
      return {
        name = "windows",
        raw = true,
        command = {
          "powershell.exe",
          "-NoProfile",
          "-NonInteractive",
          "-STA",
          "-Command",
          table.concat({
            [[Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public static class YankdownClipboard {
  [DllImport("user32.dll", SetLastError=true)] static extern bool OpenClipboard(IntPtr hWndNewOwner);
  [DllImport("user32.dll", SetLastError=true)] static extern bool CloseClipboard();
  [DllImport("user32.dll", SetLastError=true, CharSet=CharSet.Auto)] static extern uint RegisterClipboardFormat(string lpszFormat);
  [DllImport("user32.dll", SetLastError=true)] static extern IntPtr GetClipboardData(uint uFormat);
  [DllImport("kernel32.dll", SetLastError=true)] static extern IntPtr GlobalLock(IntPtr hMem);
  [DllImport("kernel32.dll", SetLastError=true)] static extern bool GlobalUnlock(IntPtr hMem);
  [DllImport("kernel32.dll", SetLastError=true)] static extern UIntPtr GlobalSize(IntPtr hMem);
  public static byte[] GetHtml() {
    uint format = RegisterClipboardFormat("HTML Format");
    if (format == 0 || !OpenClipboard(IntPtr.Zero)) return null;
    try {
      IntPtr handle = GetClipboardData(format);
      if (handle == IntPtr.Zero) return null;
      IntPtr pointer = GlobalLock(handle);
      if (pointer == IntPtr.Zero) return null;
      try {
        int size = (int)GlobalSize(handle);
        if (size <= 0) return null;
        byte[] bytes = new byte[size];
        Marshal.Copy(pointer, bytes, 0, size);
        if (bytes.Length > 0 && bytes[bytes.Length - 1] == 0) Array.Resize(ref bytes, bytes.Length - 1);
        return bytes;
      } finally {
        GlobalUnlock(handle);
      }
    } finally {
      CloseClipboard();
    }
  }
}
'@;]],
            [=[$bytes = [YankdownClipboard]::GetHtml();]=],
            [=[if ($bytes) { $stdout = [Console]::OpenStandardOutput(); $stdout.Write($bytes, 0, $bytes.Length) }]=],
          }, " "),
        },
        parse = require("yankdown.cf_html").parse,
      }
    end
    return nil, "missing:powershell"
  end

  if vim.env.WAYLAND_DISPLAY and executable("wl-paste") then
    return {
      name = "wayland",
      command = { "wl-paste", "-t", "text/html" },
    }
  end

  if vim.env.DISPLAY and executable("xclip") then
    return {
      name = "x11",
      command = { "xclip", "-selection", "clipboard", "-t", "text/html", "-o" },
    }
  end

  if vim.env.WAYLAND_DISPLAY then
    return nil, "missing:wl-paste"
  end

  if vim.env.DISPLAY then
    return nil, "missing:xclip"
  end

  return nil, "unsupported"
end

function M.read_html(callback)
  local provider, err = M.provider()
  if not provider then
    callback(nil, err)
    return
  end

  vim.system(provider.command, { text = not provider.raw }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        callback(nil, "clipboard-failed")
        return
      end

      local stdout = result.stdout or ""
      if stdout == "" then
        callback(nil, "no-html")
        return
      end

      -- Apply a provider-specific parser (e.g., CF_HTML for Windows).
      if provider.parse then
        local html, perr = provider.parse(stdout)
        callback(html, perr)
        return
      end

      callback(stdout, nil)
    end)
  end)
end

return M
