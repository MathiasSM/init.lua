return {
	{
		"laytan/cloak.nvim",
		lazy = false, -- Plugin loads before text file is displayed
		opts = {
			highlight_group = "Comment",
			cloak_length = 8,
			patterns = {
				{
					file_pattern = {
						".env*",
					},
					cloak_pattern = { "=.+", ":.+" },
				},
			},
		},
	},
}
