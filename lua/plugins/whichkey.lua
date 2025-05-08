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
			require("which-key").setup({ preset = "modern" })
			require("which-key").add({
				-- Personal (leader)
				{ "<leader>", group = "[Personal]" },
				{ "<leader>d", group = "[Docs]" },
				{ "<leader>b", group = "[Debug]" },
				{ "<leader>f", group = "[Find]" },
				{ "<leader>g", group = "[Git]" },
				{ "<leader>h", group = "[Git hunk]" },
				{ "<leader>l", group = "[Log]" },
				{ "<leader>r", group = "[Rulebook/Rest]" },
				{ "<leader>t", group = "[Test]" },
				{ "<leader>x", group = "[Trouble]" },
				{ "<leader>y", group = "[Yeet]" },
				-- LSP (space)
				{ "<space>", group = "[LSP]" },
				{ "<space>s", group = "[Symbols]" },
				{ "<space>h", group = "[Haskell]" },
				{ "<space>t", group = "[Typescript]" },
				{ "<space>ti", group = "[Imports]" },
				{ "<space>w", group = "[Workspace]" },
				-- Other
				{ "g", group = "Go to" },
				{ "[", group = "Previous" },
				{ "]", group = "Next" },
			})
		end,
	},
}
