return {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require('catppuccin').setup({
				styles = {
					conditionals = { }, -- Defaults to italics
				},
				integrations = {
					harpoon=true,
					headlines=true,
					markdown=true,
					mason=true,
					neotree=true,
					neotest=true,
					treesitter_context = false,
					lsp_trouble = true,
					which_key = true,
					native_lsp = {
						enabled = true,
						underlines = {
							errors = { "underline" },
							warnings = { "underline" },
							hints = { },
							information = { },
						},
					},
				}
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
				comments = { italic = true }
			},
		},
	},

	{
		'nyngwang/nvimgelion',
		lazy = true,
		config = function ()
			vim.api.nvim_create_autocmd({ 'ColorScheme', 'FileType' }, {
				callback = function ()
					vim.cmd([[
						hi IndentBlanklineChar gui=nocombine guifg=#444C55
						hi IndentBlanklineSpaceChar gui=nocombine guifg=#444C55
						hi IndentBlanklineContextChar gui=nocombine guifg=#FB5E2A
						hi IndentBlanklineContextStart gui=underline guisp=#FB5E2A
					]])
				end,
			})
		end
	}

}
