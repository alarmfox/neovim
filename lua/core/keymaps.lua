vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
vim.keymap.set("n", "<leader>nh", "<cmd> nohl<CR>", { desc = "Clear search highlights" })

-- split management
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>s", "<cmd>split<CR>", { desc = "Horizontal split" })
