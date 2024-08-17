return {
  "olexsmir/gopher.nvim",
  ft = "go",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
  },
  -- (optional) will update plugin's deps on every update
  build = function()
    vim.cmd.GoInstallDeps()
  end,
  keys = function()
    local gopher = require("gopher")
    return {
      { "<leader>gsj", function () gopher.tags.add("json") end , desc = "Add json tag to struct", {} },
      { "<leader>gsy", function () gopher.tags.add("yml") end, desc = "Add yml tag to struct" },
      { "<leader>gte", gopher.test.exported, desc = "Generate test for exported functions" },
      { "<leader>gtE", gopher.test.all, desc = "Generate test for all functions" },
      { "<leader>ge",  "<cmd>GoIfErr <CR>", desc = "Generate if error boilerplate" }
    }
  end
}
