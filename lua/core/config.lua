local M = {}

M.languages = {
  "c",
  "lua",
  --  "vim",
  --  "vimdoc",
  --  "query",
  "javascript",
  "html",
  "cpp",
  "cmake",
  "python",
  "css",
  "go",
  "java",
  "json",
  "make",
  --  "sql",
  "doxygen",
}

M.servers = {
  "clangd",
  "lua_ls",
  -- "vimls", -- Vimscript
  -- "html", -- HTML
  "cmake",
  "pyright",
  -- "cssls", -- CSS
  "gopls",
  --  "jdtls", -- Java
  "jsonls",
  --  "lemminx", -- XML
}

M.os = require("core.os")


return M
