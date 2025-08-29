--- ===================================================
--- Keybinds
--- ===================================================

local keymaps = {
  -- Basics
  { 'n',               '<leader>u',  '<CMD>update<CR>',             { desc = "Source file" } },
  { 'n',               '<leader>w',  '<CMD>write<CR>',              { desc = "Write file" } },
  { 'n',               '<leader>o',  '<CMD>quit<CR>',               { desc = "Quit" } },
  { 'n',               '<Esc>',      '<CMD>nohlsearch<CR>',         { desc = "Deselect" } },
  { 't',               "<esc><esc>", "<C-\\><C-N>" },
  { { 'n', 'x', 'v' }, '<leader>y',  '"+y<CR>',                     { desc = "Yank to system clipboard" } },
  { { 'n', 'x', 'v' }, '<leader>d',  '"+d<CR>',                     { desc = "Paset from system clipboard" } },
  -- Moving in split screen
  { 'n',               '<C-h>',      '<C-w><C-h>',                  { desc = "Move focus to left window" } },
  { 'n',               '<C-l>',      '<C-w><C-l>',                  { desc = "Move focus to right window" } },
  { 'n',               '<C-j>',      '<C-w><C-j>',                  { desc = "Move focus to lower window" } },
  { 'n',               '<C-k>',      '<C-w><C-k>',                  { desc = "Move focus to upper window" } },
  -- Resizing
  { 'n',               '<C-Up>',     '<CMD>resize +2<CR>',          { desc = "Increase window height" } },
  { 'n',               '<C-Down>',   '<CMD>resize -2<CR>',          { desc = "Decrease window height" } },
  { 'n',               '<C-Left>',   '<CMD>vertical resize -2<CR>', { desc = "Decrease window width" } },
  { 'n',               '<C-Right>',  '<CMD>vertical resize +2<CR>', { desc = "Increase window width" } },
  -- Tabs
  { 'n',               '<leader>tn', '<CMD>tabnew<CR>',             { desc = "New Tab" } },
  { 'n',               '<leader>to', '<CMD>tabclose<CR>',           { desc = "Close Tab" } },
  { 'n',               '<leader>tm', '<CMD>tabmove<CR>',            { desc = "Move tab" } },
  { 'n',               '<leader>t>', '<CMD>tabmove -1<CR>',         { desc = "Move tab right" } },
  { 'n',               '<leader>t<', '<CMD>tabmove +1<CR>',         { desc = "Move tab left" } },
  { 'n', '<leader>t<S-N>', function()
    vim.ui.input({ prompt = 'File to open in new tab: ', completion = 'file' }, function(input)
      if not input or input == "" then
        return
      end
      vim.cmd.tabnew(input)
    end)
  end, { desc = "Open file in new Tab" } },
  -- Buffers
  { 'n',          '<leader>q',      vim.diagnostic.setloclist,                        { desc = "Open diagnostics" } },
  { 'n',          '<leader>bn',     '<CMD>bnext<CR>',                                 { desc = "Next buffer" } },
  { 'n',          '<leader>bp',     '<CMD>bprevious<CR>',                             { desc = "Previous buffer" } },
  { 'n',          '<leader>bt',     vim.lsp.buf.type_definition,                      { desc = "Type definitions" } },
  { 'n',          '<leader>bc',     vim.lsp.buf.clear_references,                     { desc = "Clear references" } },
  { 'n',          '<leader>bs',     vim.lsp.buf.document_symbol,                      { desc = "Document symbols" } },
  { 'n',          '<leader>b<S-S>', vim.lsp.buf.workspace_symbol,                     { desc = "Workspace symbols" } },
  { 'n',          '<leader>bf',     vim.lsp.buf.format,                               { desc = "Format buffer" } },
  { 'n',          '<leader>br',     vim.lsp.buf.rename,                               { desc = "Buffer rename" } },
  { { 'n', 'x' }, '<leader>ba',     vim.lsp.buf.code_action,                          { desc = "Code actions" } },
  -- Move lines
  { 'n',          '<A-j>',          '<CMD>m .+1<CR>==',                               { desc = "Move lines down" } },
  { 'n',          '<A-k>',          '<CMD>m .-2<CR>==',                               { desc = "Move lines up" } },
  { 'v',          '<A-j>',          "<CMD>m '>+1<CR>gv=gv",                           { desc = "Move selection down" } },
  { 'v',          '<A-k>',          "<CMD>m '<-2<CR>gv=gv",                           { desc = "Move selection up" } },
  { 'v',          '<',              '<gv',                                            { desc = "Indent left" } },
  { 'v',          '>',              '>gv',                                            { desc = "Indent right" } },
  -- Utility
  { 'n',          '-',              '<CMD>Ex<CR>',                                    { desc = "Open explorer" } },
  { 'n',          '<leader>f',      '<CMD>find',                                      { desc = "Find file" } },
  { 'n',          '<leader>sn',     '<CMD>Ex ' .. vim.fn.stdpath("config") .. "<CR>", { desc = "Neovim Config" } },
  -- Copy path
  { 'n', '<leader>p', function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("file:", path)
  end, { desc = "Neovim Config" } },
  { "n", "<leader>cd", function()
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
  end,
    { desc = "Change working directory to current file's directory" }
  },
}

-- These are keymaps remapped on the lsp attaching
local lsp_keymaps = {
  -- Goto
  { 'n', 'gd',     vim.lsp.buf.definition,     { desc = "Goto definitions" } },
  { 'n', 'g<S-D>', vim.lsp.buf.declaration,    { desc = "Goto declaration" } },
  { 'n', 'gr',     vim.lsp.buf.references,     { desc = "Goto references" } },
  { 'n', 'gI',     vim.lsp.buf.implementation, { desc = "Goto implementations" } },
}

return { base = keymaps, lsp = lsp_keymaps }
