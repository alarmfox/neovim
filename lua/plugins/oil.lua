return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  config = function()
    require("oil").setup({
      default_file_explorer = false,
    })
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
