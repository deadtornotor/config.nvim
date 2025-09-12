local plugin_utils = require("core.plugin")

local sync_setup = {
  'color.tokyonight',
  -- UI
  'ui.mini_icons',
  --'ui.oil',
  'ui.lualine',
}

---@type string[]
local async_setup = {
  'trouble',
  'undo_tree',
  'telescope',
  -- cmp
  'blink',
  'treesitter',
  'ui.which_key',
}

---List of plugin bases
---@type plugins.PluginResolved[]
local plugins = plugin_utils.resolve(sync_setup)

plugin_utils.add(plugins)

plugin_utils.setup(plugins)

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    --- Async during startup
    plugins = plugin_utils.resolve(async_setup)

    plugin_utils.add(plugins)
    plugin_utils.setup_async(plugins)
  end,
})
