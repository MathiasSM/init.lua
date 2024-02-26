return {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function() vim.cmd([[colorscheme catppuccin]]) end,
	},

	{
		"folke/tokyonight.nvim",
		event = "VeryLazy",
		opts = {
			styles = { comments = { italic = true } },
			dim_inactive = true,
		},
	},

	{ "ellisonleao/gruvbox.nvim" },
}
