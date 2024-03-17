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

	{
		"ziontee113/icon-picker.nvim",
		dependencies = {"stevearc/dressing.nvim"},
		keys = {
			{
				"<leader>fii",
				"<cmd>IconPickerNormal<cr>",
				desc = "[Icon] Pick from all",
				noremap = true,
				silent = true,
			},
			{
				"<leader>fia",
				"<cmd>IconPickerNormal alt_font<cr>",
				desc = "[Icon] Alt-font",
				noremap = true,
				silent = true,
			},
			{
				"<leader>fin",
				"<cmd>IconPickerNormal nerd_font<cr>",
				desc = "[Icon] Nerd font",
				noremap = true,
				silent = true,
			},
			{
				"<leader>fie",
				"<cmd>IconPickerNormal emoji<cr>",
				desc = "[Icon] Emoji",
				noremap = true,
				silent = true,
			},
			{
				"<leader>fis",
				"<cmd>IconPickerNormal symbols<cr>",
				desc = "[Icon] Symbols",
				noremap = true,
				silent = true,
			},
			{
				"<C-i>",
				"<cmd>IconPickerInsert<cr>",
				mode = "i",
				desc = "[Icon] Pick from all",
				noremap = true,
				silent = true,
			},
		},
		config = function() require("icon-picker").setup({ disable_legacy_commands = true }) end,
	},
}
