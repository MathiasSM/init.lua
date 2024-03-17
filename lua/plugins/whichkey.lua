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
			require("which-key").setup({ window = { border = "single", winblend = 25 } })
			require("which-key").register({
				["<leader>"] = {
					name = "[Personal]",
					["d"] = { name = "[Docs]" },
					["b"] = { name = "[Debug]" },
					["f"] = { name = "[Find]" },
					["g"] = { name = "[Git]" },
					["h"] = { name = "[Git hunk]" },
					["r"] = { name = "[Rulebook/Rest]" },
					["t"] = { name = "[Test]" },
					["x"] = { name = "[Trouble]" },
					["y"] = { name = "[Yeet]" },
				},
				["<space>"] = {
					name = "[LSP]",
					["s"] = { name = "[Symbols]" },
					["h"] = { name = "[Haskell]" },
					["t"] = {
						name = "[Typescript]",
						["i"] = { name = "[Imports]" },
					},
					["w"] = { name = "[Workspace]" },
				},
				["g"] = { name = "Go to" },
				["["] = { name = "Previous" },
				["]"] = { name = "Next" },
			})
		end,
	},
}
