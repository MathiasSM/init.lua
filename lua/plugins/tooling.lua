--- Integration with external tools
--
-- @module tooling

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
		"rest-nvim/rest.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "RestNvim", "RestNvimPreview", "RestNvimLast" },
		keys = {
			{ "<leader>rr", "<Plug>RestNvim<cr>", desc = "[RestNvim] Run", ft = "http" },
			{
				"<leader>rp",
				"<Plug>RestNvimPreview<cr>",
				desc = "[RestNvim] Preview",
				ft = "http",
			},
			{ "<leader>rl", "<Plug>RestNvimLast<cr>", desc = "[RestNvim] Run Last", ft = "http" },
		},
		config = true,
	},

	{
		"gennaro-tedesco/nvim-jqx",
		ft = { "json", "yaml" },
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
			},
			{
				"<leader>yc",
				function() require("yeet").set_cmd() end,
			},
			{
				"<leader>\\",
				function() require("yeet").execute() end,
			},
		},
		init = function()
			local harpoon = require("harpoon")
			harpoon:setup({
				yeet = {
					select = function(list_item, _, _) require("yeet").execute(list_item.value) end,
				},
			})

			vim.keymap.set(
				"n",
				"<leader>9",
				function()
					harpoon.ui:toggle_quick_menu(
						harpoon:list("yeet"),
						{ title = "Yeet  " .. harpoon.config.settings.key() }
					)
				end
			)
		end,
	},
}
