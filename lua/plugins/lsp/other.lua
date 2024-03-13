return {
	{
		"b0o/schemastore.nvim",
		ft = { "json", "jsonc", "yaml" },
	},

	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},

	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			settings = {
				expose_as_code_action = "all",
			},
		},
	},
}
