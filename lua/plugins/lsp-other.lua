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
		"adoyle-h/lsp-toggle.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"neovim/nvim-lspconfig",
			"keyvchan/telescope-find-pickers.nvim",
		},
		cmd = { "ToggleLSP" },
		keys = {
			{
				"<space>T",
				"<cmd>ToggleLSP<cr>",
				desc = "[LSP] Toggle clients",
			},
		},
		config = function()
			require("lsp-toggle").setup({
				create_cmds = true,
				telescope = true,
			})
		end,
	},
}
