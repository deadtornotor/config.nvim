return {
  {
    'saghen/blink.cmp',
    event = "VeryLazy",
    optional = true,
    lazy = true,
    dependencies = {
      'rafamadriz/friendly-snippets',
      "L3MON4D3/LuaSnip",
      "danymat/neogen",
    },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
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
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },

      signature = {
        enabled = true,
      },
    },
    opts_extend = { "sources.default" }
  }
}
