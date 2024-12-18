-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- add http file type
vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

-- cmd
vim.opt.showcmd = true
vim.opt.cmdheight = 0

-- tabs and indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wrap = false

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true

-- termgui forr colors
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- backspace
vim.opt.backspace = "indent,eol,start" --allow backspace on indent, end of line and insert mode start

-- sync buffer automatically
vim.opt.autoread = true

-- disable neovim generating a swapfile
vim.opt.swapfile = false
