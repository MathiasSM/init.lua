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
		"luc-tielen/telescope_hoogle",
		keys = {
			{
				"<space>ho",
				":Telescope hoogle<cr>",
				desc = "[Telescope] Hoogle",
			},
		},
		config = function() require("telescope").load_extension("hoogle") end,
	},

	{
		"debugloop/telescope-undo.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{
				"<leader>u",
				"<cmd>Telescope undo<cr>",
				desc = "[Telescope] Undo History",
			},
		},
		opts = {
			-- don't use `defaults = { }` here, do this in the main telescope spec
			extensions = {
				undo = {
					use_delta = true, -- Requires installing `dandavison/delta`
					side_by_side = true,
					layout_strategy = "vertical",
					layout_config = {
						preview_height = 0.8,
					},
					entry_format = "#$ID\t$STAT\t$TIME",
					diff_context_lines = 5,
				},
				-- no other extensions here, they can have their own spec too
			},
		},
		config = function(_, opts)
			-- Calling telescope's setup from multiple specs does not hurt,
			-- it will happily merge the configs for us.
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
		end,
	},
}
