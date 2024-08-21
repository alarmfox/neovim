vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
vim.keymap.set("n", "<leader>nh", "<cmd> nohl<CR>", { desc = "Clear search highlights" })

-- window management
