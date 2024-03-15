return {
	{
		"b0o/schemastore.nvim",
		ft = { "json", "jsonc", "yaml" },
	},

	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},

	-- Not quite LSP, but related
	{
		"chrisgrieser/nvim-rulebook",
		keys = {
			{ "<leader>ri", function() require("rulebook").ignoreRule() end },
			{ "<leader>rl", function() require("rulebook").lookupRule() end },
			{ "<leader>ry", function() require("rulebook").yankDiagnosticCode() end },
		},
		config = true
	},
}
