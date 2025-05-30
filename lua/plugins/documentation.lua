return {
  {
    "danymat/neogen",
    config = function()
      require('neogen').setup {
        snippet_engine = "luasnip"
      }
    end,
    keys = {
      {
        "<leader>dc",
        "<CMD>Neogen<CR>",
        "n",
        desc = "Search buffers"
      },
    }
  }
}
