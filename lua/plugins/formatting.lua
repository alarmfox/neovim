return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		local opts = {
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
			conform.format(opts)
		end, { desc = "Format file or range (in visual mode)" })

		conform.setup({
			format_on_save = opts,
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
	end,
}
