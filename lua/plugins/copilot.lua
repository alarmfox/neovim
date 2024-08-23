return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		build = "make tiktoken", -- Only on MacOS or Linux
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
			{ "nvim-telescope/telescope.nvim" },
		},
		-- See Commands section for default commands if you want to lazy load on them
		config = function()
			require("copilot").setup({})
			require("CopilotChat").setup()

			vim.keymap.set("n", "<leader>aic", "<cmd>CopilotChat<CR>", { desc = "[AI] [c]hat" })
			vim.keymap.set({ "n", "v" }, "<leader>aid", "<cmd>CopilotChatDocs<CR>", { desc = "[AI] [d]ocument" })
			vim.keymap.set({ "n", "v" }, "<leader>aie", "<cmd>CopilotChatExplain<CR>", { desc = "[AI] [e]xplain" })
			vim.keymap.set({ "n", "v" }, "<leader>aif", "<cmd>CopilotChatFix<CR>", { desc = "[AI] [f]ix" })
		end,
	},
}
