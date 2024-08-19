return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"p00f/clangd_extensions.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP definition"
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

				opts.desc = "Show documentation"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Show available code actions"
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			end,
		})
		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostic = {
								globals = { "vim" },
							},
							completion = {
								cellSnippet = "Replace",
							},
						},
					},
				})
			end,
			["rust_analyzer"] = function()
				lspconfig["rust_analyzer"].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end,
				})
			end,
			["gopls"] = function()
				lspconfig["gopls"].setup({
					capabilities = capabilities,
					settings = {
						gopls = {
							usePlaceholders = true,
						},
					},
				})
			end,
			["clangd"] = function()
				lspconfig["clangd"].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						require("clangd_extensions.inlay_hints").setup_autocmd()
						require("clangd_extensions.inlay_hints").set_inlay_hints()
						vim.keymap.set(
							"n",
							"<leader>ch",
							"<cmd>ClangdSwitchSourceHeader<cr>",
							{ desc = "Switch Source/Header (C/C++)" }
						)
					end,
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				})
			end,
		})
	end,
}
