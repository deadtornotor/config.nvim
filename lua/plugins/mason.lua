---@type plugins.Plugin
return {
  spec         = {
    src = "https://github.com/mason-org/mason.nvim.git",
  },
  dependencies = {
    {
      spec = {
        src = "https://github.com/mason-org/mason-lspconfig.nvim.git"
      },
    },
    {
      spec = {
        src = 'https://github.com/neovim/nvim-lspconfig'
      },
    },
  },
  setup        = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    local servers = require("config.lang").servers

    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,
    })
  end
}
