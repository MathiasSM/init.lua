local current_file_directory = "%:p:h:s?^$?.?"

return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		keys = {
			{
				"<leader>m",
				"<cmd>Oil --float <cr>",
				desc = "[Oil] Open folder float",
			},
			{
				"<leader>M",
				"<cmd>Oil <cr>",
				desc = "[Oil] Open folder",
			},
		},
		opts = {
			default_file_explorer = true,
			skip_confirm_for_simple_edits = false,
			columns = {
				"icon",
				{ "size", highlight = "Special" },
				{ "permissions", highlight = "Comment" },
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
