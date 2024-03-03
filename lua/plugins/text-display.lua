return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			vim.cmd[[
				set foldmethod=expr
				set foldexpr=nvim_treesitter#foldexpr()
				set nofoldenable                     
			]]
			---@diagnostic disable-next-line missing-fields
			configs.setup({
				auto_install = true,
				sync_install = false,
				incremental_selection = { enable = true },
				indent = { enable = true },
				highlight = { enable = true },
				-- Grouped, some are purposely duplicated into multiple groups
				-- stylua: ignore
				ensure_installed = {
					-- Markup
					"html", "css", "scss",
					"rst", "markdown", "markdown_inline", "latex", "bibtex",
					"mermaid", "gnuplot", "dot",
					-- Scripting
					"bash", "awk", "jq", "make", "cmake", "passwd", "regex", "printf",
					-- Data
					"sql", "jsonnet",
					"csv", "tsv", "xml", "json", "json5", "jsonc", "yaml",
					-- Programming
					"c", "cmake", "comment", "cpp", "cuda", "go", "graphql", "haskell",
					"java", "javascript", "kotlin", "lua", "matlab", "ocaml",
					"perl", "python", "ruby", "rust", "scala",
					"sql", "typescript", "vim",
					-- Documentation
					"doxygen", "jsdoc", "luadoc", "vimdoc", "comment",
					-- Configuration
					"dhall", "toml", "json", "yaml", "nix", "ini",
					"dockerfile", "requirements", "ssh_config", "readline", "tmux",
					"git_config", "gitignore", "gitattributes", "requirements",
					-- Specific tooling/work
					"diff", "git_rebase", "gitcommit",
					"regex", "printf",
					"gdscript", "godot_resource",
					"gpg",
					"http",
					"ledger",
					"muttrc",
					"hlsplaylist",
					-- Other
					"html",  -- Required for luckasRanarison/nvim-devdocs
					"http", "json", -- Both required for rest.nvim
					"query" -- Recommended for playground
				},
			})
		end,
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
				"[c",
				function() tsc.go_to_context(vim.v.count1) end,
				{ desc = "[Treesitter] Jump to previous context" }
			)
			vim.cmd([[hi TreesitterContextBottom gui=underline guisp=Grey]])
			vim.cmd(
				[[hi TreesitterContextLineNumberBottom gui=underline guisp=Grey]]
			)
		end,
	},

	{
		'nvim-treesitter/playground',
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = "TSPlaygroundToggle",
		config = function ()
			---@diagnostic disable-next-line missing-fields
			require("nvim-treesitter.configs").setup({
				playground = { enable = true, }
			})
		end
	},

	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "markdown", "rmd", "norg", "org" },
		opts = {
			-- Default doesn't work on my font
			markdown = { fat_headline_lower_string = "▔" },
			rmd = { fat_headline_lower_string = "▔" },
			norg = { fat_headline_lower_string = "▔" },
			org = { fat_headline_lower_string = "▔" },
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
			},
			custom_colorcolumn = {
				java = "100",
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
		opts = {
			scope = { show_start = false, show_end = false }
		},
	},

	{
		"psliwka/vim-dirtytalk",
		build = ":DirtytalkUpdate",
		event = "VeryLazy",
		config = function() vim.cmd("set spelllang+=programming") end,
	},
}
