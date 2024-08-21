return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
			{ "nvim-telescope/telescope.nvim" },
		},
		-- See Commands section for default commands if you want to lazy load on them
		config = function()
			require("copilot").setup({})
			require("CopilotChat").setup()

			vim.keymap.set("n", "<leader>ai", "<cmd>CopilotChat<CR>", { desc = "Open Copilot chat" })
			vim.keymap.set(
				{ "n", "v" },
				"<leader>aid",
				"<cmd>CopilotChatDocs<CR>",
				{ desc = "Copilot document the selected code" }
			)
			vim.keymap.set(
				{ "n", "v" },
				"<leader>aie",
				"<cmd>CopilotChatExplain<CR>",
				{ desc = "Copilot explain the selected code" }
			)
			vim.keymap.set(
				{ "n", "v" },
				"<leader>aif",
				"<cmd>CopilotChatFix<CR>",
				{ desc = "Copilot fix selected code" }
			)
			vim.keymap.set(
				{ "n", "v" },
				"<leader>aif",
				"<cmd>CopilotChatFix<CR>",
				{ desc = "Copilot fix selected code" }
			)
		end,
	},
}
