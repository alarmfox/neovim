return {
	"rmagatti/auto-session",
	lazy = false,
	dependencies = {
		"nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
	},
	opts = {
		auto_session_suppress_dirs = { "~/", "~/dev", "~/Downloads", "/" },
		auto_restore_enabled = false,
		auto_save_enabled = true,
	},
	keys = {
		{ "<leader>ws", "<cmd>SessionSave<CR>", { desc = "[W]orkspace [s]ave based on the cwd", silent = true } },
		{ "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "[W]orkspace [r]estore based on cwd", silent = true } },
		{ "<leader>wR", "<cmd>SessionSearch<CR>", { desc = "[W]orkspace [R]estore", silent = true } },
	},
}
