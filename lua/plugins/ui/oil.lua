---@type plugins.Plugin
local M = {
  spec = {
    src = "https://github.com/stevearc/oil.nvim.git"
  },
  setup = function()
    require("oil").setup(
      {
        columns = { "icon" },

        default_file_explorer = true,

        keymaps = {
          ["<C-h>"] = false,
          ["<C-l>"] = false,
        },
        win_options = {
          winbar = "%{v:lua.CustomOilBar()}",
        },
        view_options = {
          show_hidden = true,
        },
      }
    )


    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Open parent directory in floating window" })
  end,
}

CustomOilBar = function()
  local path = vim.fn.expand "%"
  path = path:gsub("oil://", "")

  -- Convert /x/ to x:/ for fs_realpath on windows
  if require("core.os").type == "windows" then
    path = path:gsub("^/([A-Za-z])/", "%1:/")
  end

  local real_path = vim.loop.fs_realpath(path) or path

  -- Always use forward slash
  local dir = vim.fn.fnamemodify(path, ":h"):gsub("\\", "/")

  return "  " .. dir
end

return M
