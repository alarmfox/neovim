require("config.lazy")
require("config.options")

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- execute lua on the fly
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "Source current file" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "Execute selected file in lua" })

-- quick keymaps
vim.keymap.set("n", "<c-a>", "ggVG", { desc = "Select all content in the current window" })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Select all content in the current window" })

-- terminal stuff
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.relativenumber = false
		vim.opt.number = false
		vim.opt.wrap = true
	end,
})

vim.keymap.set("n", "<space>t", function()
	vim.cmd.new()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 10)
end, { desc = "Open a terminal at the bottom of the tab" })
