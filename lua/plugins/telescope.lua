local utils = require('core.utils')

---@type plugins.Plugin
return {
  spec = {
    version = "0.1.8",
    src = "https://github.com/nvim-telescope/telescope.nvim.git"
  },
  dependencies = {
    {
      spec = {
        src = "https://github.com/nvim-telescope/telescope-ui-select.nvim.git"
      }
    },
    {
      spec = {
        src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim.git"
      },
      build = require("config.os").fzf_build_cmd
    },
    {
      spec = {
        src = "https://github.com/nvim-lua/plenary.nvim.git"
      }
    },
  },
  setup = function()
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


    local builtin = require("telescope.builtin")
    -- Keymaps
    local keymaps = {
      -- Search
      { '<leader><leader>', builtin.buffers,     { desc = '[ ] Search buffers' } },
      { '<leader>sh',       builtin.help_tags,   { desc = '[s]earch [h]elp tags' } },
      { '<leader>sk',       builtin.keymaps,     { desc = '[s]earch [k]eymaps' } },
      { '<leader>sf',       builtin.find_files,  { desc = '[s]earch [f]iles' } },
      { '<leader>s.',       builtin.oldfiles,    { desc = '[s]earch recent files [.]' } },
      { '<leader>sr',       builtin.resume,      { desc = '[s]earch [r]esume' } },
      { '<leader>sd',       builtin.diagnostics, { desc = '[s]earch [d]iagnostics' } },
      { '<leader>sg',       builtin.live_grep,   { desc = '[s]earch with [g]rep' } },
      { '<leader>sw',       builtin.grep_string, { desc = '[s]earch [w]ord' } },

      { '<leader>sn', function()
        builtin.find_files {
          find_command = { "fd", "--type", "f", "-L" },
          cwd = vim.fn.stdpath("config")
        }
      end, { desc = '[s]earch [n]eovim config' } },
    }

    utils.keys.set(keymaps)
  end,
}
