return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.statusline").setup({ use_icons = true })
		require("mini.pairs").setup()
	end,
}
