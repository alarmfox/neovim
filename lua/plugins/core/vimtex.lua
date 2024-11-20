return {
	"lervag/vimtex",
	ft = { "latex", "tex" },
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		-- VimTeX configuration goes here, e.g.
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_quickfix_open_on_warning = 0
	end,
}
