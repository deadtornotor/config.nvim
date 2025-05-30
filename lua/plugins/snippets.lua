-- Snippet Courtesy of @Zeioth,
return {
  {
    'rafamadriz/friendly-snippets',
    lazy = true,
    event = "VeryLazy",
    version = '2.*',
    build = function()
      -- Build Step is needed for regex support in snippets.
      -- This step is not supported in many windows environments.
      -- Remove the below condition to re-enable on windows.
      if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
        return
      end
      return 'make install_jsregexp'
    end,
    dependencies = {
      'L3MON4D3/LuaSnip',
    },
    config = function(_, opts)
      if opts then require("luasnip").config.setup(opts) end

      require('luasnip.loaders.from_vscode').lazy_load()

      -- friendly-snippets - enable standardized comments snippets
      require("luasnip").filetype_extend("typescript", { "tsdoc" })
      require("luasnip").filetype_extend("javascript", { "jsdoc" })
      require("luasnip").filetype_extend("lua", { "luadoc" })
      require("luasnip").filetype_extend("python", { "pydoc" })
      require("luasnip").filetype_extend("rust", { "rustdoc" })
      require("luasnip").filetype_extend("cs", { "csharpdoc" })
      require("luasnip").filetype_extend("java", { "javadoc" })
      require("luasnip").filetype_extend("c", { "cdoc" })
      require("luasnip").filetype_extend("cpp", { "cppdoc" })
      require("luasnip").filetype_extend("php", { "phpdoc" })
      require("luasnip").filetype_extend("kotlin", { "kdoc" })
      require("luasnip").filetype_extend("ruby", { "rdoc" })
      require("luasnip").filetype_extend("sh", { "shelldoc" })
    end,
    opts = {},
  },
  {
    'folke/lazydev.nvim',
    lazy = true,
    event = "VeryLazy",
  }
}
