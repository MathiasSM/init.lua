--- Special actions that insert text into the buffer
--
-- These do not manipulate the buffer in any other way.
--
-- @module text-inserts
return {
	{
		"chrisgrieser/nvim-chainsaw",
		keys = {
			{
				"<leader>ll",
				function() require("chainsaw").messageLog() end,
				desc = "[Log] Enter",
			},
			{
				"<leader>lv",
				function() require("chainsaw").variableLog() end,
				mode = { "n", "v" },
				desc = "[Log] Variable",
			},
			{
				"<leader>lo",
				function() require("chainsaw").objectLog() end,
				desc = "[Log] Stringify",
			},
			{
				"<leader>la",
				function() require("chainsaw").assertLog() end,
				desc = "[Log] Assert",
			},
			{
				"<leader>lT",
				function() require("chainsaw").stracktraceLog() end,
				desc = "[Log] Stack trace",
			},
			{
				"<leader>le",
				function() require("chainsaw").beepLog() end,
				desc = "[Log] Beep",
			},
			{
				"<leader>lt",
				function() require("chainsaw").timeLog() end,
				desc = "[Log] Time + Time",
			},
			{
				"<leader>ld",
				function() require("chainsaw").debugLog() end,
				desc = "[Log] Debugging",
			},
			{
				"<leader>lr",
				function() require("chainsaw").removeLogs() end,
				desc = "[Log] Remove All",
			},
		},
	},

	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
		cmd = { "Neogen" },
		keys = {
			{ "<leader>da", "<cmd>Neogen<cr>", desc = "[Neogen] Add docs" },
		},
	},
}
