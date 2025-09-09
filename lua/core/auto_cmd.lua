--- ===================================================
--- Auto commands
--- ===================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", {})
local utils = require('core.utils')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Return to last edit position when entering",
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  desc = "Auto-close terminal after process exits",
  group = augroup,
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end
})

vim.api.nvim_create_autocmd("VimResized", {
  desc = "Auto resize splits",
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Create parent directories when saving",
  group = augroup,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end
})


vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Lsp ataching",
  group = augroup,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    local bufnr = args.buf

    -- Set keymaps
    utils.keys.set(require("config.binds").lsp)

    -- Auto format on save
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
        end
      })
    end

    -- Auto completion
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end
  end
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Remap refresh to C-o and moving to C-l",
  pattern = "netrw",
  group = augroup,
  callback = function()
    vim.cmd("nnoremap <buffer> <C-l> <C-W>l")
    vim.cmd("nnoremap <buffer> <C-o> <Plug>NetrwRefresh")
  end
})
