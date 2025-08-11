local utils = require('core.utils')

---@type plugins.Plugin
return {
  spec = {
    src = "https://github.com/folke/trouble.nvim.git"
  },
  setup = function()
    require("trouble").setup({
      modes = {
        lsp = {
          win = {
            position = "right"
          }
        }
      }
    })


    local keymaps = {
      { "n", "<leader>xx",     "<cmd>Trouble diagnostics toggle<cr>",                        { desc = "Diagnostics" } },
      { "n", "<leader>x<S-X>", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           { desc = "Buffer Diagnostics" } },
      { "n", "<leader>xs",     "<cmd>Trouble symbols toggle focus=false<cr>",                { desc = "Symbols" } },
      { "n", "<leader>xl",     "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ..." } },
      { "n", "<leader>x<S-L>", "<cmd>Trouble loclist toggle<cr>",                            { desc = "Location List" } },
      { "n", "<leader>x<S-Q>", "<cmd>Trouble qflist toggle<cr>",                             { desc = "Quickfix List" } },
    }

    utils.keys.set(keymaps)
  end
}
