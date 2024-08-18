vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
vim.keymap.set("n", "<leader>nh", "<cmd> nohl<CR>", { desc = "Clear search highlights" })

-- window management

