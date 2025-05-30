local M = {}

local bit = require("bit")
local uv = vim.uv

--- Scan for executable files in the given directory
--- @param dir string: Directory to scan
--- @return table: List of executable file paths
function M.scan_executables(dir)
  local executables = {}

  local function is_executable(mode)
    -- Check if any execute bit is set
    return bit.band(mode, 0x49) ~= 0
  end

  local function scan(path)
    local fd = uv.fs_scandir(path)
    if not fd then return end

    while true do
      local name, type = uv.fs_scandir_next(fd)
      if not name then break end
      local full_path = path .. "/" .. name
      if type == "directory" then
        scan(full_path)
      elseif type == "file" then
        local stat = uv.fs_stat(full_path)
        if stat and is_executable(stat.mode) then
          table.insert(executables, full_path)
        end
      end
    end
  end

  scan(dir)
  return executables
end

--- Prompt the user to select an executable
--- @param executables table: List of executable file paths
--- @param callback function: Function to call with the selected path
function M.select_executable(executables, callback)
  if #executables == 0 then
    vim.notify("No executables found", vim.log.levels.WARN)
    callback(nil)
    return
  end

  vim.ui.select(executables, {
    prompt = "Select an executable:",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    callback(choice)
  end)
end

return M
