---@class core.utils.keymap
local M = {}

---Set one or more keymaps.
---Accepted forms:
--- - mode, lhs, rhs[, opts]
--- - lhs, rhs[, opts] (defaults to normal mode)
--- - { mode?, lhs, rhs, opts? }
--- - { {...}, {...} } array of either style
function M.set(...)
  local args = { ... }

  -- 1. Handle array of maps
  if #args == 1 and type(args[1]) == "table" and type(args[1][1]) == "table" then
    for _, map in ipairs(args[1]) do
      M.set(unpack(map))
    end
    return
  end

  -- 2. Handle single table {mode?, lhs, rhs, opts?}
  if #args == 1 and type(args[1]) == "table" then
    return M.set(unpack(args[1]))
  end

  local mode, lhs, rhs, opts = "n", nil, nil, {}

  if #args == 2 then
    lhs, rhs = args[1], args[2]
  elseif #args == 3 then
    if type(args[3]) == "table" then
      lhs, rhs, opts = args[1], args[2], args[3]
    else
      mode, lhs, rhs = args[1], args[2], args[3]
    end
  elseif #args == 4 then
    mode, lhs, rhs, opts = args[1], args[2], args[3], args[4]
  else
    error(string.format("Invalid arguments: args %s mode %s lhs %s rhs %s opts %s",#args, mode, lhs, rhs, opts))
  end

  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
