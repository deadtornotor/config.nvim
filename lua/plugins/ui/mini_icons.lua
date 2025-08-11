---@type plugins.Plugin
return {
  spec = {
    src = "https://github.com/echasnovski/mini.icons.git"
  },
  setup = function()
    require("mini.icons").setup({
      style = 'glyph',
    })

    require("mini.icons").mock_nvim_web_devicons()
  end,
}
