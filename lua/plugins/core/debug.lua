return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap-python",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "python", "delve", "codelldb" },
      })
      local dap = require("dap")
      local ui = require("dapui")

      require("mason").setup()
      local mason_registry = require("mason-registry")

      require("dapui").setup()
      require("dap-go").setup()

      -- python

      local debugpy = mason_registry.get_package("debugpy")
      local debugpy_path = debugpy:get_install_path() ..
          "/venv/bin/python" -- returns a string like "/home/user/.local/share/nvim/mason/packages/codelldb"

      require("dap-python").setup(debugpy_path)

      -- c, cpp, rust
      local codelldb = mason_registry.get_package("codelldb") -- note that this will error if you provide a non-existent package name

      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

      dap.adapters["codelldb"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--liblldb", liblldb_path, "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
        {
          name = "Debug using codelldb",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      -- keymaps
      vim.keymap.set("n", "<space>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<space>gb", dap.run_to_cursor, { desc = "Run to rursor" })

      -- Eval var under cursor
      vim.keymap.set("n", "<space>?", function() require("dapui").eval(nil, { enter = true }) end,
        { desc = "Evaluate expression under cursor" })

      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug continue" })
      vim.keymap.set("n", "<F6>", dap.step_into, { desc = "Debug step into" })
      vim.keymap.set("n", "<F7>", dap.step_over, { desc = "Debug step over" })
      vim.keymap.set("n", "<F8>", dap.step_out, { desc = "Debug step out" })
      vim.keymap.set("n", "<F9>", dap.step_back, { desc = "Debug step back" })
      vim.keymap.set("n", "<F10>", dap.restart, { desc = "Debug restart" })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
