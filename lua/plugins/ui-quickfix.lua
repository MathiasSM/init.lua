---
return {
	{
		"vladdoster/remember.nvim",
		lazy = false,
		config = true,
	},

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
		config = function()
			local telescope = require("telescope")
			local trouble = require("trouble.providers.telescope")
			telescope.setup({
				defaults = {
					mappings = {
						i = { ["<c-t>"] = trouble.open_with_trouble },
						n = { ["<c-t>"] = trouble.open_with_trouble },
					},
				},
			})
		end,
	},
}
