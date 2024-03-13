return {
	{
		name = "amazon:whichkey",
		dir = "~/.config/nvim/lua/plugins/private/noop.lua",
		dependencies = "folke/which-key.nvim",
		config = function()
			require("which-key").register({
				["<leader>"] = {
					["a"] = {
						name = "[Amazon] ...",
						["b"] = {
							name = "[Brazil] ...",
						},
						["r"] = {
							name = "[CRUX] ...",
						},
						["u"] = {
							name = "[URLs] ...",
						},
					},
				},
			})
		end,
	},
}
