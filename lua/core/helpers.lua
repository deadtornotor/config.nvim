--- ===================================================
--- Utility
--- ===================================================

---Inspect utility function
---@param param any Value to inspect
_G.I = function(param)
  print(vim.inspect(param))
end

---Benchmark function
---@param fn fun(...) Function to benchmark
---@vararg ... Arguments to benchmark with
---@return ... Return values of function
_G.T = function(fn, ...)
  local start = vim.loop.hrtime()
  local results = { fn(...) }
  local elapsed = (vim.loop.hrtime() - start) / 1e6 -- ms
  print(string.format("Function took %.3f ms", elapsed))
  if #results > 0 then
    print("Results:", unpack(results))
  end
  return unpack(results)
end
