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
}
