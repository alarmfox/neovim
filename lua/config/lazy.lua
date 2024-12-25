-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import plugins
		{ import = "plugins" },
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				vim.cmd([[colorscheme tokyonight]])
			end,
		},
		{
			"norcalli/nvim-colorizer.lua",
			opts = {
				"css",
				"javascript",
				html = { mode = "background" },
			},
		},
		{
			"lewis6991/gitsigns.nvim",
			opts = {
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "u" },
				},
				current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
			},
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			event = { "BufReadPre", "BufNewFile" },
			main = "ibl",
			opts = {
				indent = { char = "┊" },
			},
		},
		{
			"lervag/vimtex",
			-- tag = "v2.15", -- uncomment to pin to a specific release
			init = function()
				-- VimTeX configuration goes here, e.g.
				vim.g.vimtex_view_method = "zathura"
				vim.g.vimtex_quickfix_open_on_warning = 0
			end,
		},
		{
			"j-hui/fidget.nvim",
			opts = {},
		},
		{
			"mistweaverco/kulala.nvim",
			opts = {},
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "tokyonight" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
