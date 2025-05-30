return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    recommended = true,
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
      "nvim-neotest/nvim-nio",
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    keys = {
      { "<F3>",      function() require("dap").continue() end,          desc = "Run/Continue" },
      { "<F5>",      function() require("dap").step_into() end,         desc = "Step into" },
      { "<F6>",      function() require("dap").step_over() end,         desc = "Step over" },
      { "<F7>",      function() require("dap").step_out() end,          desc = "Step out" },
      { "<F8>",      function() require("dap").step_back() end,         desc = "Step back" },
      { "<F9>",      function() require("dap").restart() end,           desc = "Restart" },
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Toggle [b]reackpoint" },
    },

    config = function()
      local dap = require("dap")

      -- Set up debuggers
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.adapters.java = {
        type = "server",
        host = "localhost",
        port = 5005,
      }

      -- Python configuration
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch Python File",
          program = "${file}",
        },
      }

      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-dap',
        name = "lldb"
      }


      --[[ requires copying
      -- cd ~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin
      -- cp cppdbg.ad7Engine.json nvim-dap.ad7Engine.json
      ----]]
      dap.adapters.cpptools = {
        type = 'executable',
        name = 'cpptools',
        command = vim.fn.stdpath('data') .. '/mason/bin/OpenDebugAD7',
        args = {},
        attach = {
          pidProperty = 'processId',
          pidSelect = 'ask',
        },
      }

      -- C++ configuration
      dap.configurations.cpp = {
        {
          name = "Launch C++ File",
          type = "cpptools",
          request = "launch",
          program = function()
            local cwd = vim.fn.getcwd()
            local select = require("deadtornotor.utils.select")
            local executables = select.scan_executables(cwd)
            return coroutine.create(function(dap_run_co)
              select.select_executable(executables, function(choice)
                coroutine.resume(dap_run_co, choice)
              end)
            end)
          end,
          cwd = "${workspaceFolder}",
          args = {},
          runInTerminal = false,
        },
      }

      dap.configurations.c = dap.configurations.cpp

      -- Java configuration
      dap.configurations.java = {
        {
          name = "Launch Java File",
          type = "java",
          request = "launch",
          mainClass = "${file}",
          projectName = "${workspaceFolderBasename}",
        },
      }
    end,
  }
}
