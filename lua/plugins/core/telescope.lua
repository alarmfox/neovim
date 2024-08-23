return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
			},
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						-- even more opts
					}),
				},
			},
		})

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [f]iles" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind with grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [b]uffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [h]elp tags" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[F]ind [r]ecent files" })
		vim.keymap.set("n", "<leader>fc", builtin.colorscheme, { desc = "[F]ind [c]olors" })
		vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "[F]ind [t]odos" })

		telescope.load_extension("ui-select")
		telescope.load_extension("fzf")
	end,
}
