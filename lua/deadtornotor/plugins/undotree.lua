return {
  {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
    end,
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, "n", desc = "Toggle undo tree" },
    }
  }
}
