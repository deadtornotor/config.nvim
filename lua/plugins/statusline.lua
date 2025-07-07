local function format_cwd()
  local cwd = vim.fn.getcwd() -- Full current working directory path
  local display_path = cwd

  if #cwd > 15 then
    display_path = '*' .. cwd:sub(-14)
  end

  return ' ' .. display_path
end


return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = "VeryLazy",
  config = function()
    require('lualine').setup({
      sections = {
        lualine_y = {
          'progress',
          format_cwd,
        },
      },
    })
  end
}
