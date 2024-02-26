return {
	{
		"numToStr/Comment.nvim",
		event = "InsertEnter",
		keys = {
			{ "gc", mode = "v" },
			{ "gb", mode = "v" },
			"gcc",
			"gbc",
		},
		opts = {
			mappings = { extra = false },
		},
	},

	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
		cmd = { "Neogen" },
	},

	{
		"junegunn/vim-easy-align",
		cmd = { "EasyAlign" },
	},
}
