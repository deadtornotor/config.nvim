local function build_cmd()
  if require("config.os").type == "windows" then
    return nil
  end

  return "make install_jsregexp"
end

---@type plugins.Plugin
return {
  spec = {
    src = "https://github.com/L3MON4D3/LuaSnip.git",
    version = "v2.4.0",
  },
  dependencies = {
    {
      spec = {
        src = "https://github.com/rafamadriz/friendly-snippets.git"
      }
    },
    {
      spec = {
        src = "https://github.com/danymat/neogen.git"
      },
      setup = function()
        require('neogen').setup {
          snippet_engine = "luasnip"
        }

        vim.keymap.set("n", "<leader>d", "<CMD>Neogen<CR>", { desc = "[d]ocument code" })
      end,
    }
  },
  build = build_cmd(),
  setup = function()
    require("luasnip.loaders.from_vscode").lazy_load()

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
  end
}
