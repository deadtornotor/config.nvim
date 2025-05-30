return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    event = "VeryLazy",
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-telescope/telescope-ui-select.nvim',
      { "nvim-telescope/telescope-fzf-native.nvim", build = require("deadtornotor.conf.os").fzf_build_cmd },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        pickers = {
          live_grep = {
            additional_args = function()
              return { "--follow" }
            end,
          },
          grep_string = {
            additional_args = function()
              return { "--follow" }
            end,
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--follow",
          },
          find_command = { "fd", "--type", "f", "-L" },
        },
        extentions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          }
        }
      })

      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
    end,
    keys = {
      {
        "<leader><leader>",
        function()
          require("telescope.builtin").buffers()
        end,
        "n",
        desc = "Search buffers"
      },
      {
        "<leader>sh",
        function()
          require("telescope.builtin").help_tags()
        end,
        "n",
        desc = "[s]earch [h]elp tags"
      },
      {
        "<leader>s?",
        function()
          require("telescope.builtin").keymaps()
        end,
        "n",
        desc = "[s]earch command help [?]"
      },
      {
        "<leader>sf",
        function()
          require("telescope.builtin").find_files()
        end,
        "n",
        desc = "[s]earch [f]iles"
      },
      {
        "<leader>s.",
        function()
          require("telescope.builtin").oldfiles()
        end,
        "n",
        desc = '[s]earch recent files [.]'
      },
      {
        "<leader>sr",
        function()
          require("telescope.builtin").resume()
        end,
        "n",
        desc = '[s]earch [r]esume'
      },
      {
        "<leader>sd",
        function()
          require("telescope.builtin").diagnostics()
        end,
        "n",
        desc = '[s]earch [d]iagnostics'
      },
      {
        "<leader>sg",
        function()
          require("telescope.builtin").live_grep()
        end,
        "n",
        desc = '[s]earch with [g]rep'
      },
      {
        "<leader>sw",
        function()
          require("telescope.builtin").grep_string()
        end,
        "n",
        desc = '[s]earch [w]ord'
      },
      {
        "<leader>st",
        function()
          require("telescope.builtin").builtin()
        end,
        "n",
        desc = '[s]earch select [t]elescope'
      },
      {
        "<leader>sn",
        function()
          require("telescope.builtin").find_files {
            find_command = { "fd", "--type", "f", "-L" },
            cwd = vim.fn.stdpath("config")
          }
        end,
        "n",
        desc = "[s]earch [n]eovim config directory"
      },
      {
        "<leader>ss",
        function()
          require("telescope.builtin").find_files {
            find_command = { "fd", "--type", "f", "-L" },
            cwd = vim.fn.expand('%:p:h')
          }
        end,
        "n",
        desc = "[s]earch current files directory"
      },
      {
        "<leader>sp",
        function()
          require("telescope.builtin").find_files {
            find_command = { "fd", "--type", "f", "-L" },
            cwd = "~/projects"
          }
        end,
        "n",
        desc = "[s]earch [p]rojects directory"
      },
      {
        "<leader>sd",
        function()
          require("telescope.builtin").find_files {
            find_command = { "fd", "--type", "f", "-L" },
            cwd = vim.fn.input("Directory: ")
          }
        end,
        "n",
        desc = "[s]earch specified [d]irectory"
      },
      {
        "gd",
        function()
          require("telescope.builtin").lsp_definitions()
        end,
        "n",
        desc = "[g]oto [d]efinition"
      },
      {
        "gr",
        function()
          require("telescope.builtin").lsp_references()
        end,
        "n",
        desc = "[g]oto [r]eferences"
      },
      {
        "gI",
        function()
          require("telescope.builtin").lsp_implementations()
        end,
        "n",
        desc = "[g]oto [I]mplementations"
      },
      {
        "<leader>D",
        function()
          require("telescope.builtin").lsp_type_definitions()
        end,
        "n",
        desc = "type [D]efinition"
      },
      {
        "<leader>ds",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        "n",
        desc = "[d]ocument [s]ymbols"
      },
      {
        "<leader>ws",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols()
        end,
        "n",
        desc = "[w]orkspace [s]ymbols"
      },
    },
  }
}
