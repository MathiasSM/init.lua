--- Telescope plugins for searching
--
-- * Telescope itself
-- * FZF: For faster fuzzy find files
-- * Ag: For grepping files
-- * Undo: For undo tree
-- * Nerdy: For searching nerdicons
--
-- Some plugins outside of this module may include other telescope extensions
-- if they are mainly _not_ for searching.
--
-- @module telescope

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = "Telescope",
		keys = {
			{
				"<leader>ff",
				require("telescope.builtin").find_files,
				desc = "[Telescope] Find files (fzf)",
			},
			{
				"<leader>fb",
				require("telescope.builtin").buffers,
				desc = "[Telescope] Buffers",
			},
			{
				"<leader>fh",
				require("telescope.builtin").help_tags,
				desc = "[Telescope] Help tags",
			},
		},
		opts = {},
		config = function()
			require("telescope").setup({})
			require("telescope").load_extension("fzf")
		end,
	},

	{
		"kelly-lin/telescope-ag",
		-- Needs rg/ag executable
		dependencies = { "nvim-telescope/telescope.nvim" },
		cmd = "Ag",
		keys = {
			{
				"<leader>fg",
				require("telescope.builtin").live_grep,
				desc = "[Telescope] Live grep (Ag)",
			},
		},
		config = function() require("telescope").load_extension("ag") end,
	},

	{
		"debugloop/telescope-undo.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{
				"<leader>fu",
				function() require("telescope").extensions.undo.undo({ side_by_side = true }) end,
				desc = "[Telescope] Undo History",
			},
		},
		config = function()
			require("telescope").setup({
				extensions = {
					undo = {
						layout_strategy = "horizontal",
						use_delta = false,
						entry_format = "#$ID\t$STAT\t$TIME",
						diff_context_lines = 5,
					},
				},
			})
			require("telescope").load_extension("undo")
		end,
	},
}
