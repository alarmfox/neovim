return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"nvim-lua/plenary.nvim",
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		require("mason").setup({})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(_)
				vim.keymap.set("n", "gd", vim.lsp.buf.declaration, { desc = "Jump to declaration" })
				vim.keymap.set("n", "gD", vim.lsp.buf.definition, { desc = "Jump to definition" })
			end,
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()
		require("mason-lspconfig").setup({
			automatic_installation = false,
			ensure_installed = {
				-- lsp
				"lua_ls",
				"clangd",
				"gopls",
				"rust_analyzer",
				"html",
				"pyright",
				"bashls",
				"ts_ls",
			},

			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["lua_ls"] = function(name)
					require("lspconfig")[name].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								telemetry = {
									enable = false,
								},
							},
						},
					})
				end,

				["rust_analyzer"] = function(name)
					require("lspconfig")[name].setup({
						capabilities = capabilities,
						on_attach = function(_, bufnr)
							vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
						end,
					})
				end,

				["clangd"] = function(name)
					require("lspconfig")[name].setup({
						capabilities = capabilities,
						on_attach = function(_, _)
							vim.keymap.set(
								"n",
								"<leader>ch",
								"<cmd>ClangdSwitchSourceHeader<cr>",
								{ desc = "Switch Source/Header (C/C++)" }
							)
						end,
						cmd = {
							"clangd",
							"-j=4",
							"--background-index",
							"--clang-tidy",
							"--completion-style=detailed",
							"--function-arg-placeholders",
							"--fallback-style=llvm",
							"--header-insertion=never",
							"--pch-storage=memory",
						},
						init_options = {
							completeUnimported = true,
							clangdFileStatus = true,
						},
					})
				end,
			},
		})
	end,
}
