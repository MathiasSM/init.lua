return {
	{
		name = "whichkey--brazil",
		dir = "~/.config/nvim/lua/plugins/private/noop.lua",
		dependencies = "folke/which-key.nvim",
		lazy = true,
		config = function()
			require("which-key").register({
				["<leader>"] = {
					["a"] = {
						name = "[Brazil] ...",
					},
				},
			})
		end,
	},
}
