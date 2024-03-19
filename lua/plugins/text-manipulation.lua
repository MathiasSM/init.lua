--- Special actions to manipulate the current buffer
--
-- Insertions (manipulations that don't modify but are rather only inserting new text)
-- are defined in a different file.
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
		keys = {
			{ "<C-a>", desc = "Switch/increment" },
			{ "<C-x>", desc = "Switch/decrement" },
		},
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

	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = {
			{
				"<leader>j",
				"<cmd>TSJToggle<cr>",
				desc = "[TreeSJ] Toggle join/split code",
			},
		},
		config = function()
			require("treesj").setup({
				use_default_keymaps = false,
			})
		end,
	},
}
