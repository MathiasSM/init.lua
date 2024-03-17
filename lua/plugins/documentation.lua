--- Documentation-related plugins
--
-- * Generation of documentation tags
-- * Generation of HTML/other documentation pages from comment tags
-- * Find documentation
--
-- @module documentation

return {
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
		cmd = { "Neogen" },
		keys = {
			{ "<leader>da", "<cmd>Neogen<cr>", desc = "[Neogen] Add docs" },
		},
	},

	{
		"Zeioth/dooku.nvim",
		cmd = {
			"DookuAutoSetup",
			"DookuGenerate",
			"DookuOpen",
		},
		keys = {
			{ "<leader>dg", "<cmd>DookuGenerate<cr>", desc = "[Dooku] Generate docs" },
			{ "<leader>do", "<cmd>DookuOpen<cr>", desc = "[Dooku] Open generated" },
		},
		opts = {
			browser_cmd = require("utils").get_open_cmd(),
		},
	},

	{
		"luckasRanarison/nvim-devdocs",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = {
			"DevdocsFetch",
			"DevdocsInstall",
			"DevdocsOpen",
			"DevdocsOpenCurrent",
			"DevdocsToggle",
			"DevdocsUpdateAll",
		},
		keys = {
			{ "<leader>dd", "<cmd>DevdocsToggle<cr>", desc = "[DevDocs] Toggle" },
			{ "<leader>do", "<cmd>DevdocsOpen<cr>", desc = "[DevDocs] Open all" },
		},
		opts = {
			wrap = true,
			previewer_cmd = vim.fn.executable("glow") == 1 and "glow" or nil,
			cmd_args = { "-s", "dark", "-w", "80" },
			picker_cmd_args = { "-s", "dark", "-w", "50" },
		},
	},
}
