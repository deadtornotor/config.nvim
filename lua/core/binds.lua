local utils = require('core.utils')

local keymaps = {
  -- Sourcing
  { '<leader>o',      '<CMD>update<CR>',            { desc = "S[o]urce current file" } },
  -- Save
  { '<leader>w',      '<CMD>write<CR>',             { desc = "[w]rite current file" } },
  -- Quit
  { '<leader>p',      '<CMD>quit<CR>',              { desc = "[q]uit" } },
  -- Unselect search
  { '<Esc>',          '<CMD>nohlsearch<CR>',        { desc = "Deselect search" } },
  -- Moving in split screen
  { '<C-h>',          '<C-w><C-h>',                 { desc = "Move focus to left window" } },
  { '<C-l>',          '<C-w><C-l>',                 { desc = "Move focus to right window" } },
  { '<C-j>',          '<C-w><C-j>',                 { desc = "Move focus to lower window" } },
  { '<C-k>',          '<C-w><C-k>',                 { desc = "Move focus to upper window" } },
  -- Moving in tabs
  { '<F1>',           '<CMD>tabprevious<CR>',       { desc = "Move to previous tab" } },
  { '<F2>',           '<CMD>tabnext<CR>',           { desc = "Move to next tab" } },
  -- Diagnostics
  { '<leader>q',      vim.diagnostic.setloclist,    { desc = "Open diagnostic [q]uickfix" } },
  -- LSP Buffer
  --- Action
  { { 'n', 'x' },     '<leader>ba',                 vim.lsp.buf.code_action,                  { desc = "[b]uffer [a]ction" } },
  --- Rename
  { '<leader>br',     vim.lsp.buf.rename,           { desc = "[b]uffer [r]ename" } },
  --- Goto
  { 'g<S-d>',         vim.lsp.buf.declaration,      { desc = "[g]oto [D]eclaration" } },
  { 'gd',             vim.lsp.buf.definition,       { desc = "[g]oto [d]efinition" } },
  { 'gr',             vim.lsp.buf.references,       { desc = "[g]oto [r]eferences" } },
  { 'gI',             vim.lsp.buf.implementation,   { desc = "[g]oto [I]mplementations" } },
  { '<leader>t',      vim.lsp.buf.type_definition,  { desc = "Goto [t]ype definition" } },
  --- Clear references
  { '<leader>bc',     vim.lsp.buf.clear_references, { desc = "[b]uffer [c]lear references" } },
  --- Symbols
  { '<leader>bs',     vim.lsp.buf.document_symbol,  { desc = "[b]uffer document [s]ymbols" } },
  { '<leader>b<S-S>', vim.lsp.buf.workspace_symbol, { desc = "[b]uffer workspace [S]ymbols" } },
  --- Format
  { '<leader>bf',     vim.lsp.buf.format,           { desc = "[b]uffer [f]ormat" } },
}

utils.keys.set(keymaps)

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('deadtornotor-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set("n", "<leader>cd", function()
  local using_oil, oil = pcall(require, "oil")
  local path

  if using_oil and oil.get_current_dir() then
    -- Inside an Oil buffer
    path = oil.get_current_dir()
  else
    -- Regular file buffer
    path = vim.fn.expand("%:p:h")
  end

  -- Change the working directory
  vim.cmd("cd " .. vim.fn.fnameescape(path))
  print("Changed directory to: " .. path)
end, { desc = "Change working directory to current file's directory" })
