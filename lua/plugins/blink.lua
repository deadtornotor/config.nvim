local opts = {
  snippets = { preset = 'luasnip' },
  keymap = { preset = 'default' },
  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono'
  },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  signature = {
    enabled = true,
  },
}

---@type plugins.Plugin
return {
  spec = {
    src = "https://github.com/Saghen/blink.cmp.git",
    version = "v1.6.0"
  },
  dependencies = {
    require("plugins.luasnip"),
    require("plugins.mason"),
  },
  build = "rustup run nightly cargo build --release",
  setup = function()
    local cmp = require('blink.cmp')

    cmp.setup(opts)


    --- Lsp configurations ---
    local servers = require("config.lang").servers

    local capabilities = nil

    capabilities = cmp.get_lsp_capabilities()

    for _, server in ipairs(servers) do
      local opts = {}

      opts.capabilities = capabilities

      if server == "lua_ls" then
        opts.settings = {
          Lua = {
            workspace = {
              library = vim.tbl_extend(
                "force",
                vim.api.nvim_get_runtime_file("", true),
                {}
              )
            },
          }
        }
      end

      vim.lsp.config(server, opts)
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        if client:supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end
          })
        end
      end,
    })
  end
}
