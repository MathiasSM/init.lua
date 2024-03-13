--- Plugins that change the way text is displayed
--
-- * Hide secrets
-- * Syntax highlighting (treesitter)
-- * Indentation guides
-- * Colorcolumn guide
-- * Spelling
-- * Extra highlighting (color codes, etc.)
--
-- @module text-display

-- stylua: ignore
local treesitter_grammars_to_install = {
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
	"doxygen", "jsdoc", "luadoc", "vimdoc",
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
}

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
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			vim.o.foldmethod = "expr"
			vim.o.foldexpr = "nvim_treesitter#foldexpr()"
			vim.o.foldenable = false

			---@diagnostic disable-next-line missing-fields
			configs.setup({
				auto_install = true,
				sync_install = false,
				incremental_selection = { enable = true },
				indent = { enable = true },
				highlight = { enable = true },
				-- Grouped, some are purposely duplicated into multiple groups
				ensure_installed = treesitter_grammars_to_install,
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
		opts = {
			signs = true, -- show icons in the signs column
			sign_priority = 8, -- sign priority
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

	{ -- TODO: Do I even like this?
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
