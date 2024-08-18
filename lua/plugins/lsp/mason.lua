return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	lazy = false,
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({})
		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"clangd",
				"gopls",
				"rust_analyzer",
				"html",
				"pyright",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"eslint_d",
				"pylint",
			},
		})
	end,
}