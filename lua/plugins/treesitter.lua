---@type plugins.Plugin
return {
  spec = {
    src = "https://github.com/nvim-treesitter/nvim-treesitter.git",
  },
  setup = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = require("core.config").languages,

   auto_install = true,

      highlight = {
        enable = true,

        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stat = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = {
        enable = true,
      },

      additional_vim_regex_highlighting = true,
    })
  end
}
