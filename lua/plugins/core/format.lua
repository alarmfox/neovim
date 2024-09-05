return {

	"stevearc/conform.nvim",
	config = function()
		local conform_opts = {
			lsp_fallback = true,
			timeout_ms = 1000,
			async = false,
		}

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			require("conform").format(conform_opts)
		end, { desc = "Format file or range (in visual mode)" })

		require("conform").setup({
			format_on_save = conform_opts,
			formatters = {
				yamlfix = {
					env = {
						YAMLFIX_SEQUENCE_STYLE = "block_style",
					},
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofmt" },
				python = { "isort", "black" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				css = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				yaml = { "yamlfix" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},
		})
	end,
}
