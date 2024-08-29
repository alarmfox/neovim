return {
	{
		"catppuccin/nvim",
		priority = 1000,
		lazy = false,
		opts = {
			flavour = "mocha",
		},
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
}
