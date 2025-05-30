-- File: lua/conf/os.lua
---@class deadtornotor.os
---@field type string Name of OS
---@field node string Path to node.js executable
---@field python string Path to python executable
---@field lldb string Path to lldb executable
---@field fzf_build_cmd string Command for building fzf
---@field setup fun() Initializes system-dependent settings

-- OS-specific executable paths
---@type deadtornotor.os
local linux = {
  type = "linux",
  node = "/usr/bin/node",      -- path to node executable
  python = "/usr/bin/python3", -- path to python executable
  lldb = "lldb",               -- codelldb (installed by mason)
  fzf_build_cmd = "make",
  setup = function()
    vim.schedule(function()
      vim.opt.clipboard = "unnamedplus" -- This enables the system clipboard integration
      vim.g.clipboard = {
        name = "wl-copy",
        copy = {
          ["+"] = "wl-copy",
          ["*"] = "wl-copy",
        },
        paste = {
          ["+"] = "wl-paste --no-newline",
          ["*"] = "wl-paste --no-newline",
        },
      }
    end)
  end
}

---@type deadtornotor.os
local windows = {
  type = "windows",
  node = "C:\\Program Files\\nodejs\\node.exe", -- path to node executable
  python = "C:\\Python39\\python.exe",          -- path to python executable
  lldb = "lldb",                                -- codelldb (installed by mason)
  fzf_build_cmd =
  "cmake -S. -Bbuild -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  setup = function()
    vim.opt.shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
    vim.opt.backup = false
    vim.opt.swapfile = false
    vim.opt.undodir = os.getenv('LOCALAPPDATA') .. '/nvim-data/undo'
    vim.opt.undofile = true
  end
}

-- This determines the current OS and returns the appropriate paths
---@type deadtornotor.os
local current = (vim.loop.os_uname().sysname:find 'Windows' and true or false) and windows or linux

return current
