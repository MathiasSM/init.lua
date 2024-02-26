return {
	{
		"eandrju/cellular-automaton.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = "CellularAutomaton",
		keys = {
			{
				"<leader>fml",
				"<cmd>CellularAutomaton make_it_rain<CR>",
				desc = "FML",
			},
			{
				"<leader>gol",
				"<cmd>CellularAutomaton game_of_life<CR>",
				desc = "FML",
			},
		},
	},
}
