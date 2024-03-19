--- Plugins that change the way the buffer text is displayed
--
-- * Hide secrets
-- * Indentation guides
-- * Colorcolumn guide
-- * Spelling
-- * Extra highlighting (color codes, etc.)
--
-- @module text-display

return {
	{
		"laytan/cloak.nvim",
		lazy = false, -- Plugin loads before text file is displayed
		opts = {
			highlight_group = "Comment",
			cloak_length = 8,
			patterns = {
				{
					file_pattern = {
						".env*",
					},
					cloak_pattern = { "=.+", ":.+" },
				},
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		cmd = { "TSContextToggle" },
		config = function()
			local tsc = require("treesitter-context")
			tsc.setup({
				min_window_height = 30,
			})
			vim.keymap.set(
				"n",
				"[u", -- TODO: Not a fan of using the prev [ for this
				function() tsc.go_to_context(vim.v.count1) end,
				{ desc = "[Treesitter] Jump Up to scope context start" }
			)
			vim.cmd([[hi TreesitterContextBottom gui=underline guisp=Grey]])
			vim.cmd([[hi TreesitterContextLineNumberBottom gui=underline guisp=Grey]])
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {
			signs = true, -- show icons in the signs column
			sign_priority = 8, -- sign priority 
			highlight = {
				multiline = false,
			},
			keywords = {
				FIX = {
					icon = " ",
					color = "error",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = "󰶯 ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = "󰑮 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
		},
	},

	{
		"m4xshen/smartcolumn.nvim",
		event = "VeryLazy",
		opts = {
			colorcolumn = "80",
			disabled_filetypes = {
				"help",
				"text",
				"markdown",
				"neo-tree",
				"lazy",
				"lspinfo",
				"noice",
				"Trouble",
				"mason",
				"netrw",
				"qf",
			},
			custom_colorcolumn = {
				java = "120",
				lua = "100",
			},
		},
	},

	{
		"nmac427/guess-indent.nvim",
		event = "VeryLazy",
		opts = {
			filetype_exclude = {
				"netrw",
				"tutor",
				"neo-tree",
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "VeryLazy",
		opts = {
			scope = { show_start = false, show_end = false },
		},
	},

	{
		"psliwka/vim-dirtytalk",
		build = ":DirtytalkUpdate",
		event = "VeryLazy",
		config = function() vim.cmd("set spelllang+=programming") end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		cmd = { "ColorizerAttachToBuffer" },
		ft = { "css" }, -- Autoload automatically
		opts = {
			"*", -- Highlight all files, but customize some others.
			css = { css = true }, -- Enable parsing rgb(...) functions in css.
			html = { names = false },
		},
	},
}
