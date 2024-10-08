return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 1000
	end,
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
