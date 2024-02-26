return {
	{
		"aserowy/tmux.nvim",
		opts = {
			copy_sync = {
				redirect_to_clipboard = false,
			},
		},
	},

	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		init = function() vim.g.startuptime_tries = 10 end,
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
		"luckasRanarison/nvim-devdocs",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = {
			"DevdocsFetch",
			"DevdocsInstall",
			"DevdocsOpen",
			"DevdocsOpenCurrent",
			-- 'DevdocsOpenFloat',
			-- 'DevdocsOpenCurrentFloat',
			"DevdocsToggle",
			-- 'DevdocsUpdate',
			"DevdocsUpdateAll",
		},
		opts = {
			wrap = true,
			previewer_cmd = vim.fn.executable("glow") == 1 and "glow" or nil,
			cmd_args = { "-s", "dark", "-w", "80" },
			picker_cmd_args = { "-s", "dark", "-w", "50" },
		},
	},

	{
		"Zeioth/dooku.nvim",
		cmd = {
			"DookuAutoSetup",
			"DookuGenerate",
			"DookuOpen",
		},
		opts = {
			browser_cmd = (function()
				if vim.env.OS == "macos" then return "open" end
				if vim.env.DISPLAY == nil or vim.env.DISPLAY == "" then
					return "lynx"
				end
				return "xdg-open"
			end)(),
		},
	},

	{
		"rest-nvim/rest.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		ft = "http",
		keys = {
			{ "<leader>R", "<Plug>RestNvim<cr>", desc = "RestNvim" },
			{
				"<leader>RP",
				"<Plug>RestNvimPreview<cr>",
				desc = "RestNvimPreview",
			},
			{ "<leader>RL", "<Plug>RestNvimLast<cr>", desc = "RestNvimLast" },
		},
		config = true,
	},

	{
		"gennaro-tedesco/nvim-jqx",
		ft = { "json", "yaml" },
	},
}
