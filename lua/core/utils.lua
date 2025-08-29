require "core.helpers"

local M = {}

M.keys = require("core.keymap")
M.plugin = require("core.plugin")

-- Safely require modules
-- e.g. even if one part fails the config will try its best to still work
---@param module_name string Module name
---@return table|nil module The Module
function M.safe_require(module_name)
  local ok, mod = pcall(require, module_name)
  if not ok then
    vim.notify(
      string.format("Failed to load module: %s\nError: %s", module_name, mod),
      vim.log.levels.ERROR
    )
    return nil
  end
  return mod
end

return M
