---@class plugins.PluginBase
---@field spec vim.pack.Spec Plugin spec
---@field build? string Build command
---@field setup? fun(): nil Setup plugin
---
---@class plugins.Plugin : plugins.PluginBase
---@field dependencies? plugins.Plugin[]
---
---@class plugins.PluginResolved : plugins.PluginBase
---@field module_name string Name of the module which added the plugin
---@field path string? Path to the plugin (call add_path)

local M = {}

---Returns if the partial plugin spec is part of the full plugin spec
---@param partial vim.pack.Spec
---@param full vim.pack.SpecResolved
---@return boolean [true|false] Returns true if plugin spec is partial
local function is_plugin_partial(partial, full)
  if partial.name and partial.name ~= full.name then
    return false
  end
  if partial.src and partial.src ~= full.src then
    return false
  end
  if partial.version and partial.version ~= full.version then
    return false
  end
  return true
end

--- Resolve plugins
---@param dep_plugin plugins.Plugin Plugins (with depencencies)
---@param module_name string Module name
---@return plugins.PluginResolved[]|nil resolved_plugins Resolved plugins
local function resolve_plugin(dep_plugin, module_name)
  ---@type plugins.PluginResolved[]
  local plugins = {}

  if type(dep_plugin) ~= "table" then
    vim.notify(
      string.format("Invalid plugin %s", module_name),
      vim.log.levels.ERROR
    )
    return nil
  end

  if not dep_plugin.spec or type(dep_plugin) ~= "table" then
    vim.notify(
      string.format("Invalid plugin spec for %s", module_name),
      vim.log.levels.ERROR
    )
    return nil
  end

  if dep_plugin.dependencies and type(dep_plugin.dependencies) == "table" then
    for _, plugin in ipairs(dep_plugin.dependencies) do
      local resolved = resolve_plugin(plugin, module_name)

      if resolved == nil then
        goto continue
      end

      table.move(resolved, 1, #resolved, #plugins + 1, plugins)

      ::continue::
    end
  end

  ---@cast plugins.PluginResolved
  local resolved = dep_plugin
  resolved.module_name = module_name

  table.insert(plugins, resolved)

  return plugins
end

-- Run the build command for the plugin
---@param plugin plugins.PluginResolved
local function run_build_cmd(plugin)
  if not plugin.build then
    return
  end

  if not type(plugin.build) == "string" then
    vim.notify(
      string.format("Invalid plugin build command" .. I(plugin.build)),
      vim.log.levels.ERROR
    )
    return
  end

  M.add_path(plugin)

  local path = plugin.path or ""
  local name = plugin.module_name
  local cmd = plugin.build

  local os_conf = require("config.os")

  local exec_cmd

  if os_conf.type == "windows" then
    exec_cmd = { "cmd.exe", "/C", "cd /D " .. path .. " && " .. cmd }
  else
    exec_cmd = { "sh", "-c", "cd " .. vim.fn.shellescape(path) .. " && " .. cmd }
  end


  vim.system(
    exec_cmd, { text = true }, function(obj)
      if obj.code == 0 then
        return
      end

      vim.schedule(function()
        vim.notify(
          ("Build failed for %s:\n%s"):format(name, obj.stderr),
          vim.log.levels.ERROR
        )
      end)
    end)
end

---Resolve module names to plugins
---@param modules string[] Module names
---@return plugins.PluginResolved plugins Resolved plugins
function M.resolve(modules)
  ---@type plugins.PluginResolved[]
  local plugins = {}

  for _, module_name in ipairs(modules) do
    local ok, plugin = pcall(require, "plugins." .. module_name)

    if not ok or type(plugin) ~= "table" then
      vim.notify(
        string.format("Failed to load plugin %s: %s", module_name, tostring(plugin)),
        vim.log.levels.ERROR
      )
      goto continue
    end

    local resolved = resolve_plugin(plugin, module_name)

    if resolved == nil then
      goto continue
    end

    table.move(resolved, 1, #resolved, #plugins + 1, plugins)

    ::continue::
  end

  return plugins
end

function M.add_path(plugin)
  -- get the paths and add them to the plugin table
  local pack_plugins = vim.pack.get()

  for _, pack_plugin in ipairs(pack_plugins) do
    if is_plugin_partial(plugin.spec, pack_plugin.spec) then
      plugin.path = pack_plugin.path
      break
    end
  end
end

---Add plugins to nvim plugin manager
---@param resolved_plugins plugins.PluginResolved[]
function M.add(resolved_plugins)
  ---@type vim.pack.Spec[]
  local specs = {}

  for _, plugin in ipairs(resolved_plugins) do
    table.insert(specs, plugin.spec)
  end

  vim.pack.add(specs)
end

---Run the setup functions
---@param resolved_plugins plugins.PluginResolved[]
function M.setup(resolved_plugins)
  for _, plugin in ipairs(resolved_plugins) do
    if type(plugin.setup) ~= "function" then
      goto continue
    end

    local ok, err = pcall(run_build_cmd, plugin)

    if not ok then
      print("Failed to build plugin" .. plugin.module_name .. ": " .. tostring(err))
    end

    ok, err = pcall(plugin.setup)

    if not ok then
      print("Failed to setup plugin" .. plugin.module_name .. ": " .. tostring(err))
    end

    ::continue::
  end
end

---Run the setup functions
---@param resolved_plugins plugins.PluginResolved[]
function M.setup_timed(resolved_plugins)
  local hrtime = vim.loop.hrtime
  for _, plugin in ipairs(resolved_plugins) do
    if type(plugin.setup) == "function" then
      local start = hrtime()
      local ok, err = pcall(plugin.setup)
      local elapsed_ms = (hrtime() - start) / 1e6
      print(string.format("[Setup Time] %s took %.2fms", plugin.module_name, elapsed_ms))
      if not ok then
        print("Failed to setup plugin: " .. tostring(err))
      end
    end
  end
end

---Run the setup functions
---@param resolved_plugins plugins.PluginResolved[]
function M.setup_async(resolved_plugins)
  local i = 1
  local function step()
    local plugin = resolved_plugins[i]
    if not plugin then
      return -- done
    end

    if type(plugin.setup) == "function" then
      local ok, err = pcall(run_build_cmd, plugin)
      if not ok then
        vim.schedule(function()
          print("Failed to build plugin " .. plugin.module_name .. ": " .. tostring(err))
        end)
      end

      ok, err = pcall(plugin.setup)
      if not ok then
        vim.schedule(function()
          print("Failed to setup plugin" .. plugin.module_name .. ": " .. tostring(err))
        end)
      end
    end

    i = i + 1
    vim.schedule(step) -- yield back to UI before next plugin
  end

  vim.schedule(step) -- start the chain
end

return M
