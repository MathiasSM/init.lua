--- WhichKey configuration for "nested" keymaps
--
-- I initially had each plugin spec define their own tree, but got into overwrites
-- and decided to keep it all groups sync'd on one file (this one).
--
-- @module whichkey

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({ window = { border = "single" } })
			require("which-key").register({
				["<leader>"] = {
					name = "[Personal] ...",
					["d"] = {
						name = "[Docs] ...",
					},
					["f"] = {
						name = "[Find] ...",
					},
					["h"] = {
						name = "[Git] (hunk) ...",
					},
					["g"] = {
						name = "[Git] ...",
					},
					["x"] = {
						name = "[Trouble] ...",
					},
					["y"] = {
						name = "[Yeet] ...",
					},
				},
				["<space>"] = {
					name = "[LSP] ...",
					["w"] = {
						name = "[Workspace] ...",
					},
					["h"] = {
						name = "[Haskell] ...",
					},
					["t"] = {
						name = "[Typescript] ...",
						["i"] = {
							name = "[Imports] ...",
						},
					},
				},
				["g"] = {
					name = "Go to...",
				},
				["["] = {
					name = "Previous...",
				},
				["]"] = {
					name = "Next...",
				},
			})
		end,
	},
}
