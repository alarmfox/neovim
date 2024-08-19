return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = {
				"mfussenegger/nvim-dap",
			},
		},
		"williamboman/mason-lspconfig.nvim",
		"williamboman/mason.nvim",
	},
	lazy = false,
	config = function()
		local mason = require("mason")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({})

		mason_tool_installer.setup({
			ensure_installed = {
				-- lsp
				"lua_ls",
				"clangd",
				"gopls",
				"rust_analyzer",
				"html",
				"pyright",

				-- formatting
				"prettier",
				"stylua",
				"isort",
				"black",
				"eslint_d",
				"pylint",

				-- debug
				"delve",
				"codelldb",
				"python",
			},
			integrations = {
				["mason-null-ls"] = false,
			},
		})
	end,
}
