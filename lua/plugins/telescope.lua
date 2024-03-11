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
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>ff",
				require("telescope.builtin").find_files,
				desc = "[Telescope] Find files (fzf)",
			},
			{
				"<leader>fg",
				require("telescope.builtin").live_grep,
				desc = "[Telescope] Live grep",
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
		config = true,
		cmd = "Telescope",
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		lazy = true,
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function() require("telescope").load_extension("fzf") end,
	},

	{
		"kelly-lin/telescope-ag",
		-- Needs rg/ag executable
		dependencies = { "nvim-telescope/telescope.nvim" },
		cmd = "Ag",
		keys = {
			{
				"<leader>fgg",
				require("telescope.builtin").live_grep,
				desc = "[Telescope] Live Ag",
			},
		},
		config = function() require("telescope").load_extension("ag") end,
	},

	{
		"debugloop/telescope-undo.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{
				"<leader>u",
				function() require("telescope").extensions.undo.undo({ side_by_side = true }) end,
				desc = "[Telescope] Undo History",
			},
		},
		config = function()
			-- Calling telescope's setup from multiple specs does not hurt,
			-- it will happily merge the configs for us.
			require("telescope").setup({
				extensions = {
					undo = {
						layout_strategy = "horizontal",
						use_delta = false,
						entry_format = "#$ID\t$STAT\t$TIME",
						diff_context_lines = 5,
					},
					-- no other extensions here, they can have their own spec too
				},
			})
			require("telescope").load_extension("undo")
		end,
	},

	{
		'2kabhishek/nerdy.nvim',
		dependencies = {
			'stevearc/dressing.nvim',
			'nvim-telescope/telescope.nvim',
		},
		cmd = 'Nerdy',
		build = "python3 scripts/generator.py",
		config = function()
			require('telescope').load_extension('nerdy')
		end
	},
}
