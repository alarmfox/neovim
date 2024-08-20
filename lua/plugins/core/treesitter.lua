return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			autotab = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			ensure_installed = {
				"c",
				"lua",
				"javascript",
				"html",
				"markdown",
				"markdown_inline",
				"json",
				"yaml",
				"make",
			},
		})
	end,
}
