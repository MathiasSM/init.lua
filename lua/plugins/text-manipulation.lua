--- Text manipulation
--
-- Special actions to manipulate the current buffer
-- * Toggle code comments
-- * EasyAlign magic
-- * Drawing diagrams
--
-- @module text-manipulation

return {
	{
		"numToStr/Comment.nvim",
		event = "InsertEnter",
		keys = {
			{ "gc", mode = "v", desc = "[Comment] Line" },
			{ "gb", mode = "v", desc = "[Comment] Block" },
			{ "gcc", desc = "[Comment] Line" },
			{ "gbc", desc = "[Comment] Block" },
		},
		opts = {
			mappings = { extra = false },
		},
	},

	{
		"junegunn/vim-easy-align",
		cmd = { "EasyAlign" },
	},

	{
		"nat-418/boole.nvim", -- TODO: Check nguyenvukhang/nvim-toggler
		config = function()
			require("boole").setup({
				mappings = {
					increment = "<C-a>",
					decrement = "<C-x>",
				},
				additions = {
					{ "Foo", "Bar" },
					{ "tic", "tac", "toe" },
				},
				allow_caps_additions = {
					{ "enable", "disable" }, -- Enable → Disable, ENABLE → DISABLE, ...
				},
			})
		end,
	},
}
