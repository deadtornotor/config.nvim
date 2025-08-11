---@type plugins.Plugin
return {
  spec = {
    src = "https://github.com/mbbill/undotree.git"
  },
  setup = function()
    vim.keymap.set("n", "<leader>u", "<CMD>UndotreeToggle<CR>", { desc = "Toggle [u]ndotree" })
  end
}
