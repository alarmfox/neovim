return {
  'rmagatti/auto-session',
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
  },
  opts = {
    auto_session_suppress_dirs = { '~/', '~/dev', '~/Downloads', '/' },
    auto_restore_enabled = false,
    auto_save_enabled = true
  },
  keys = {
    { "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session based on the cwd"} },
    { "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session based on cwd"} },
    { "<leader>wR", "<cmd>SessionSearch<CR>", { desc = "Search session"} },
  }
}
