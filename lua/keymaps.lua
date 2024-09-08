vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<C-a>", "gg0VG$", { noremap = true, silent = true, desc = "Select all" })

vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true, desc = "Exit insert mode with jj" })
vim.keymap.set("n", "<leader>nh", "<cmd> nohl<CR>", { noremap = true, silent = true, desc = "Clear search highlights" })

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { noremap = true, silent = true, desc = "[S]plit [v]ertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { noremap = true, silent = true, desc = "[S]plit [h]orizontally" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<cr>", { noremap = true, silent = true, desc = "E[x]it current [s]plit" })

-- navigate in insert mode
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true, desc = "Move left" })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true, desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true, desc = "Move up" })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true, desc = "Move right" })

-- clipboard
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
vim.keymap.set({ "v", "x" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
vim.keymap.set(
	{ "n", "v", "x" },
	"<leader>yy",
	'"+yy',
	{ noremap = true, silent = true, desc = "Yank line to clipboard" }
)
vim.keymap.set(
	{ "n", "v", "x" },
	"<leader>Y",
	'"+yy',
	{ noremap = true, silent = true, desc = "Yank line to clipboard" }
)
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.keymap.set(
	"i",
	"<C-p>",
	"<C-r>+",
	{ noremap = true, silent = true, desc = "Paste from clipboard from within insert mode" }
)
vim.keymap.set(
	"x",
	"<leader>P",
	'"_dP',
	{ noremap = true, silent = true, desc = "Paste over selection without erasing unnamed register" }
)

-- kulala commands
vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "http" },
	desc = "Kulala keybindings",
	callback = function()
		vim.keymap.set(
			"n",
			"<leader>rc",
			require("kulala").run,
			{ desc = "[R]un [c]urrent request", noremap = true, silent = true }
		)

		vim.keymap.set(
			"n",
			"<C-k>",
			require("kulala").jump_prev,
			{ desc = "Jump prev request", noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<C-j>",
			require("kulala").jump_next,
			{ desc = "Jump next request", noremap = true, silent = true }
		)
	end,
})

vim.keymap.set("n", "<leader>rs", function()
	require("kulala").scratchpad()
end, { desc = "[R]equest [s]cratchpad", noremap = true, silent = true })

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
