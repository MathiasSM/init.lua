--- Autocomplete configuration (`nvim-cmp`)
-- @module autocomplete

return {
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			-- Base
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			-- LSP and other sources
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-path",
			"f3fora/cmp-spell",
			"petertriho/cmp-git",
			-- Nice to have
			"nvim-tree/nvim-web-devicons",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args) require("luasnip").lsp_expand(args.body) end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				---@diagnostic disable-next-line: missing-fields
				formatting = {
					format = function(entry, vim_item)
						return require("lspkind").cmp_format({
							with_text = true,
							menu = {
								nvim_lsp = "[LSP]",
								luasnip = "[LuaSnip]",
								buffer = "[Buffer]",
								spell = "[Spell]",
								path = "[Path]",
								git = "[Git]",
								gitmoji = "[Gitmoji]",
								conventionalcommits = "[ConvCom]",
							},
						})(entry, vim_item)
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{
						name = "spell",
						option = {
							keep_all_entries = false,
							enable_in_context = function()
								return require("cmp.config.context").in_treesitter_capture("spell")
							end,
						},
					},
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "conventionalcommits" },
					{ name = "gitmoji" },
					{ name = "git" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		lazy = true,
		config = function()
			require("luasnip").setup({
				history = true,
				delete_check_events = "TextChanged",
			})
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	{
		"Dynge/gitmoji.nvim",
		dependencies = { "hrsh7th/nvim-cmp" },
		opts = {},
		ft = "gitcommit",
	},
}
