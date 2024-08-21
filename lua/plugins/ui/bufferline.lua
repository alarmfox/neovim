return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			themable = true,
		},
	},
	lazy = false,
	keys = {
		{ "<leader>bn", "<cmd>BufferLineCycleNext<CR>", { desc = "Cycle next buffer" } },
		{ "<leader>bp", "<cmd>BufferLineCyclePrev<CR>", { desc = "Cycle prev buffer" } },
		{ "<leader>brw", "<cmd>BufferLineCloseRight<CR>", { desc = "Buffer close all right" } },
		{ "<leader>blw", "<cmd>BufferLineCloseLeft<CR>", { desc = "Buffer close all left" } },
	},
}
