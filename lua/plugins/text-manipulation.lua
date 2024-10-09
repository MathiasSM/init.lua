--- Special actions to manipulate the current buffer
--
-- Insertions (manipulations that don't modify but are rather only inserting new text)
-- are defined in a different file.
--
-- @module text-manipulation

return {
	{
		"numToStr/Comment.nvim",
		dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
		event = "InsertEnter",
		config = function ()
			require('ts_context_commentstring').setup({
			  enable_autocmd = false,
			})
			require('Comment').setup({
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			})
		end
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
				max_join_length = 1200,
				use_default_keymaps = false,
			})
		end,
	},
}
