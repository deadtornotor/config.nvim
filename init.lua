--- ===================================================
--- Settings
--- ===================================================

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basics
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.wrap = false

-- Indentation
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true

-- Visual
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.showmode = false
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.g.have_nerd_font = true

-- Files
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.updatetime = 300
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 0
vim.o.autoread = true
vim.o.autowrite = false

-- Behaviour
vim.o.hidden = true
vim.o.mouse = 'a'
vim.o.encoding = 'UTF-8'

vim.cmd.colorscheme("habamax")
vim.cmd("set completeopt+=noselect")


--- ===================================================
--- LSP Servers
--- ===================================================

local servers = {
  {
    name = 'lua_ls',
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
      '.luarc.json',
      '.luarc.jsonc',
      '.luacheckrc',
      '.stylua.toml',
      'stylua.toml',
      'selene.toml',
      'selene.yml',
      '.git',
    },
    settings = {
      Lua = {
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true)
        },
      }
    }
  },
}

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
}

-- These are keymaps remapped on the lsp attaching
local lsp_keymaps = {
  -- Goto
  { 'n', 'gd',     vim.lsp.buf.definition,     { desc = "Goto definitions" } },
  { 'n', 'g<S-D>', vim.lsp.buf.declaration,    { desc = "Goto declaration" } },
  { 'n', 'gr',     vim.lsp.buf.references,     { desc = "Goto references" } },
  { 'n', 'gI',     vim.lsp.buf.implementation, { desc = "Goto implementations" } },
}

for _, map in ipairs(keymaps) do
  local mode, lhs, rhs, opts = unpack(map)
  vim.keymap.set(mode, lhs, rhs, opts)
end

--- ===================================================
--- Utility
--- ===================================================

---Inspect utility function
---@param param any Value to inspect
_G.I = function(param)
  print(vim.inspect(param))
end

---Benchmark function
---@param fn fun(...) Function to benchmark
---@vararg ... Arguments to benchmark with
---@return ... Return values of function
_G.T = function(fn, ...)
  local start = vim.loop.hrtime()
  local results = { fn(...) }
  local elapsed = (vim.loop.hrtime() - start) / 1e6 -- ms
  print(string.format("Function took %.3f ms", elapsed))
  if #results > 0 then
    print("Results:", unpack(results))
  end
  return unpack(results)
end

--- ===================================================
--- Auto commands
--- ===================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

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
    for _, map in ipairs(lsp_keymaps) do
      local mode, lhs, rhs, opts = unpack(map)
      opts = opts or {}

      opts.buffer = bufnr

      if opts.desc then
        opts.desc = "LSP: " .. opts.desc
      end

      vim.keymap.set(mode, lhs, rhs, opts)
    end

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

--- ===================================================
--- LSP
--- ===================================================

local function find_root(patterns)
  local path = vim.fn.expand("%:p:h")
  local root = vim.fs.find(patterns, { path = path, upward = true })
  return root and vim.fn.fnamemodify(root[1], ':h') or path
end

local lsp_names = {}

-- Register/Configure --
for _, config in ipairs(servers) do
  config.root_dir = find_root(config.root_markers)

  vim.lsp.config(config.name, config)
  table.insert(lsp_names, config.name)

  if not config.filetypes then
    goto continue
  end

  for _, type in ipairs(config.filetypes) do
    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      pattern = config.filetypes,
      callback = function()
        vim.lsp.start(config)
      end,
    })
  end

  ::continue::
end

-- Enable
vim.lsp.enable(lsp_names)

--- ===================================================
--- Status bar ---
--- ===================================================

function git_branch()
  local ok, branch = pcall(function()
    return vim.fn.systemlist({ "git", "branch", "--show-current" })[1]
  end)

  if ok and branch and branch ~= "" and not branch:match("^fatal:") then
    return branch .. " | "
  end

  return ""
end

-- File type with icon
function file_type()
  local ft = vim.bo.filetype
  local icons = {
    lua = "[LUA]",
    python = "[PY]",
    javascript = "[JS]",
    html = "[HTML]",
    css = "[CSS]",
    json = "[JSON]",
    markdown = "[MD]",
    vim = "[VIM]",
    sh = "[SH]",
    cpp = "[CPP]",
    hpp = "[HPP]",
    c = "[C]",
    h = "[H]",
    go = "[GO]",
  }

  if ft == "" then
    return "  "
  end

  return (icons[ft] or ft)
end

-- Mode indicators with icons
function mode_icon()
  local mode = vim.fn.mode()
  local modes = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK", -- Ctrl-V
    c = "COMMAND",
    s = "SELECT",
    S = "S-LINE",
    ["\19"] = "S-BLOCK", -- Ctrl-S
    R = "REPLACE",
    r = "REPLACE",
    ["!"] = "SHELL",
    t = "TERMINAL"
  }
  return modes[mode] or ("  " .. mode:upper())
end

vim.cmd([[
  highlight StatusLineBold gui=bold cterm=bold
]])

-- Function to change statusline based on window focus
local function setup_dynamic_statusline()
  vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    callback = function()
      vim.opt_local.statusline = table.concat {
        "  ",
        "%#StatusLineBold#",
        mode_icon(),
        "%#StatusLine#",
        git_branch(),
        " | %f %h%m%r",
        "%=", -- Right-align everything after this
        " │ ",
        "%#StatusLineBold#",
        file_type(),
        "%#StatusLine#",
        " │ ",
        "%l:%c  %P ", -- Line:Column and Percentage
      }
    end
  })
  vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

  vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    callback = function()
      vim.opt_local.statusline = "  %f %h%m%r │ %{v:lua.file_type()} | %=  %l:%c   %P "
    end
  })
end

setup_dynamic_statusline()
