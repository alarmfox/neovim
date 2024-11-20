return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		{
			"windwp/nvim-ts-autotag",
			config = true,
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = {
				line_numbers = true,
				enable = true,
			},
		},
	},
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			auto_install = false,
			sync_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "latex" },
			},
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
				"typescript",
				"html",
				"markdown",
				"markdown_inline",
				"json",
				"yaml",
				"make",
				"go",
				"cmake",
				"rust",
				"diff",
				"sql",
				"toml",
				"http",
				"latex",
			},
		})
	end,
}
