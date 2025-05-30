local M = {}

M.languages = {
  "c",
  "lua",
  "vim",
  "vimdoc",
  "query",
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
  "sql",
  "doxygen",
}

M.servers = {
  "clangd",
  "lua_ls",
  "vimls",
  "html",
  "cmake",
  "pyright",
  "cssls",
  "gopls",
  "jdtls",
  "jsonls",
  "lemminx",
}

if require("deadtornotor.conf.os").type == "linux" then
  table.insert(M.servers, "sqls")
end

M.debuggers = {
  "cpptools",
  "python",
  "debugpy",
  "java-debug-adapter",
}

return M
