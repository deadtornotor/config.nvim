return {
  {
    "echasnovski/mini.icons",
    priority = 1000,
    config = function()
      require("mini.icons").setup({
        style = 'glyph',
      })

      require("mini.icons").mock_nvim_web_devicons()
    end,
  }
}
