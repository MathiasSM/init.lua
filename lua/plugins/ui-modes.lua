return {
	{
		"folke/zen-mode.nvim",
		cmd = { "ZenMode" },
		keys = {
			{ "<leader>z", function() require("zen-mode").toggle() end, desc = "[ZenMode] Toggle" },
		},
		opts = {
			window = {
				options = {
					signcolumn = "no",
					number = false,
					relativenumber = false,
					cursorline = false,
					cursorcolumn = false,
					foldcolumn = "0",
				},
			},
			on_open = function(win) end,
			on_close = function() end,
		},
	},

	{
		"nvim-treesitter/playground",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
		config = function()
			---@diagnostic disable-next-line missing-fields
			require("nvim-treesitter.configs").setup({
				playground = { enable = true },
			})
		end,
	},
}
