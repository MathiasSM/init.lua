---
return {
	{ "kevinhwang91/nvim-bqf", ft = "qf" },

	{ "yorickpeterse/nvim-pqf", ft = "qf", opts = {} },

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "TroubleToggle" },
		event = { "LspAttach" },
		keys = {
			{ "<leader>xx", function() require("trouble").toggle() end, desc = "[Trouble] Toggle" },
			{
				"<leader>xw",
				function() require("trouble").toggle("workspace_diagnostics") end,
				desc = "[Trouble] Workspace diagnostics",
			},
			{
				"<leader>xd",
				function() require("trouble").toggle("document_diagnostics") end,
				desc = "[Trouble] Document diagnostics",
			},
			{
				"<leader>xq",
				function() require("trouble").toggle("quickfix") end,
				desc = "[Trouble] Quickfix list",
			},
			{
				"<leader>xl",
				function() require("trouble").toggle("loclist") end,
				desc = "[Trouble] Location list",
			},
		},
		config = function() end,
	},

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
		"vladdoster/remember.nvim",
		lazy = false,
		config = true,
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
