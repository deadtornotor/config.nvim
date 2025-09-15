vim.keymap.set("n", "<leader>cp", "<CMD>MarkdownPreviewToggle<CR>", { desc = "Markdown Preview", buffer = true })

vim.keymap.set("n", "<leader>c", function()
  local line = vim.api.nvim_get_current_line()
  if line:match("%[ %]") then
    line = line:gsub("%[ %]", "[x]", 1)
  elseif line:match("%[x%]") then
    line = line:gsub("%[x%]", "[ ]", 1)
  end
  vim.api.nvim_set_current_line(line)
end, { buffer = true, desc = "Toggle checkbox" })
