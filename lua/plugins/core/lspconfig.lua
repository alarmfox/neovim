return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"p00f/clangd_extensions.nvim",
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"williamboman/mason-lspconfig.nvim",
		"stevearc/conform.nvim",
		"mfussenegger/nvim-lint",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local conform = require("conform")
		local lint = require("lint")

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
			},
			integrations = {
				["mason-null-ls"] = false,
			},
		})

		mason_lspconfig.setup({
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				lua_ls = function()
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
							workspace = {
								checkThirdParty = false,
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
								maxPreload = 100000,
								preLoadFileSize = 10000,
							},
							telemetry = { enable = false },
							runtime = {
								version = "LuaJIT",
							},
						},
					})
				end,

				rust_analyzer = function()
					lspconfig["rust_analyzer"].setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
						end,
					})
				end,

				gopls = function()
					lspconfig["gopls"].setup({
						capabilities = capabilities,
						settings = {
							gopls = {
								usePlaceholders = true,
							},
						},
					})
				end,

				clangd = function()
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
			},
		})

		-- formatting
		local conform_opts = {
			lsp_fallback = true,
			timeout_ms = 1000,
			async = false,
		}

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				conform.format({ bufnr = args.buf })
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format(conform_opts)
		end, { desc = "Format file or range (in visual mode)" })

		conform.setup({
			format_on_save = conform_opts,
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofmt" },
				python = { "isort", "black" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				c = { "clangd" },
				cpp = { "clangd" },
			},
		})

		-- linting
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
