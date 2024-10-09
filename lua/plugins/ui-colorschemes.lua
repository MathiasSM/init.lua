--- Colorschemes I like
-- The default one must have lazy=false, priority=1000
-- The others should have lazy=true
--
-- TODO: Find a switcher that loads the name from lazy config (?)
--
-- @module colorschemes

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				styles = {
					conditionals = {}, -- Defaults to italics
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				integrations = {
					cmp = true,
					dap = true,
					dap_ui = true,
					fidget = true,
					gitsigns = true,
					gitgutter = true,
					harpoon = true,
					headlines = true,
					lsp_trouble = true,
					markdown = true,
					mason = true,
					neotest = true,
					neotree = true,
					treesitter_context = true,
					which_key = true,
					native_lsp = {
						enabled = true,
						underlines = {
							errors = { "underline" },
							warnings = { "underline" },
							-- Disabling the following
							hints = {},
							information = {},
						},
					},
				},
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			dim_inactive = true,
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
				comments = { italic = true },
			},
		},
	},

	{
		"nyngwang/nvimgelion",
		lazy = true,
		config = function()
			vim.api.nvim_create_autocmd({ "ColorScheme", "FileType" }, {
				callback = function()
					vim.cmd([[
						hi IndentBlanklineChar gui=nocombine guifg=#444C55
						hi IndentBlanklineSpaceChar gui=nocombine guifg=#444C55
						hi IndentBlanklineContextChar gui=nocombine guifg=#FB5E2A
						hi IndentBlanklineContextStart gui=underline guisp=#FB5E2A
					]])
				end,
			})
		end,
	},
}
