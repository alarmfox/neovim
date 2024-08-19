return {
	"xiyaowong/transparent.nvim",
	config = function()
		local transparent = require("transparent")
		transparent.clear_prefix("NeoTree")
		transparent.setup({
			extra_groups = { "NormalFloat" },
		})
	end,
}
