return {
	"windwp/nvim-autopairs",
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	event = "InsertEnter",
	config = function()
		local autopairs = require("nvim-autopairs")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")

		autopairs.setup({
			check_ts = true,
			ts_config = {
				lua = { " string " },
				javascript = { "template_string" },
			},
			ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
			enable_check_bracket_line = false,
		})

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
