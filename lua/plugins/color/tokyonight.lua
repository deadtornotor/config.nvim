---@type plugins.Plugin
return {
  spec = {
    src = "https://github.com/folke/tokyonight.nvim.git"
  },
  setup = function()
    require("tokyonight").setup({
      style = "night",
      light_style = "storm",
      dim_inactive = true,
    })

    vim.cmd.colorscheme "tokyonight"
  end
}
