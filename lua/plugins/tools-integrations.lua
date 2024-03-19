--- Integration with external tools
--
-- @module

return {
	{
		"aserowy/tmux.nvim",
		event = "VeryLazy", -- So clipboard works
		keys = {
			{ "<C-h>", function() require("tmux").move_left() end, desc = "[TMUX] Left" },
			{ "<C-j>", function() require("tmux").move_bottom() end, desc = "[TMUX] Down" },
			{ "<C-k>", function() require("tmux").move_top() end, desc = "[TMUX] Up" },
			{ "<C-l>", function() require("tmux").move_right() end, desc = "[TMUX] Right" },
		},
		opts = {
			copy_sync = {
				redirect_to_clipboard = true,
			},
			navigation = {
				enable_default_keybindings = false,
			},
		},
	},

	{
		"tpope/vim-fugitive",
		cmd = {
			"Git",
			"Gedit",
			"Gdiffsplit",
			"Gvdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
		},
	},

	{
		"gennaro-tedesco/nvim-jqx",
		cmd = { "JqxList", "JqxQuery" },
	},

	{
		"samharju/yeet.nvim",
		dependencies = {
			"stevearc/dressing.nvim",
			"ThePrimeagen/harpoon",
		},
		cmd = "Yeet",
		keys = {
			{
				"<leader>yt",
				function() require("yeet").select_target() end,
				desc = "[Yeet] Select target",
			},
			{
				"<leader>yc",
				function() require("yeet").set_cmd() end,
				desc = "[Yeet] Set cmd",
			},
			{
				"<leader>\\",
				function() require("yeet").execute() end,
				desc = "[Yeet] Execute",
			},
			{
				"<leader>9",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(
						harpoon:list("yeet"),
						{ title = "Yeet  " .. harpoon.config.settings.key() }
					)
				end,
				desc = "[Yeet] Open harpoon list",
			},
		},
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({
				yeet = {
					select = function(list_item, _, _) require("yeet").execute(list_item.value) end,
				},
			})
		end,
	},
}
