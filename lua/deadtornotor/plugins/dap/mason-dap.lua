return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    -- mason-nvim-dap is loaded when nvim-dap loads
    config = function()
      local servers = require("deadtornotor.conf.languages").debuggers

      require("mason-nvim-dap").setup({
        ensure_installed = servers
      })
    end,
  }
}
