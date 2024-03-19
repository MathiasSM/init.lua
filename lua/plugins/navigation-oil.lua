return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		keys = {
			{ "<leader>m", "<cmd>Oil --float %:h<cr>", desc = "[Oil] Open folder float" },
			{ "<leader>M", "<cmd>Oil %:h<cr>", desc = "[Oil] Open folder" },
		},
		opts = {
			default_file_explorer = true,
			columns = {
				"icon",
			},
			float = {
				max_width = 60,
				max_height = 40,
				win_options = {
					winblend = 10,
				},
			},
			keymaps = {
				["g?"] = "actions.show_help",
				["s"] = "actions.select_vsplit",
				["S"] = "actions.select_split",
				["p"] = "actions.preview",
				["<esc>"] = "actions.close",
				["q"] = "actions.close",
				["R"] = "actions.refresh",
				["<BS>"] = "actions.parent",
				["H"] = "actions.toggle_hidden",
				["<leader>m"] = "actions.close",
			},
		},
	},
}
