--- (Auto)completion configuration (`nvim-cmp`)
--
-- @module completion

--- Formatting for the completion menu items
--
-- Adds the item type icon and source name. Requires lspkind.
local function format_completion_popup(entry, vim_item)
	return require("lspkind").cmp_format({
		with_text = true,
		-- stylua: ignore
		menu = {
			buffer                  = "[Buffer]",
			calc                    = "=",
			cmp_pandoc              = "[Pandoc]",
			emoji                   = "[Emoji]",
			git                     = "[Git]",
			gitmoji                 = "[Gitmoji]",
			greek                   = "[Greek]",
			latex_symbols           = "[LaTeX]",
			luasnip                 = "",
			nerdfont                = "[Nerd]",
			nvim_lsp                = "[LSP]",
			nvim_lsp_signature_help = "[LSP sig]",
			omni                    = "[Omni]",
			path                    = "[Path]",
			spell                   = "[Spell]",
		},
	})(entry, vim_item)
end

--- True if the cursor follows an alphanumeric character
local function has_words_before()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	if col == 0 then return false end
	local prev_char = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
	local is_alphanumeric = prev_char:match("%w") ~= nil
	return is_alphanumeric
end

return {
	{
		"hrsh7th/nvim-cmp",
		version = false, -- copied from LazyVim
		event = "InsertEnter", -- Since we're not completing cmdline
        -- stylua: ignore
		dependencies = {
			-- Base
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			-- Sources
			"hrsh7th/cmp-buffer",                  -- buffer
			"hrsh7th/cmp-calc",                    -- calc
            {"aspeddro/cmp-pandoc.nvim",           -- cmp_pandoc
             dependencies="/jbyuki/nabla.nvim" },
			"hrsh7th/cmp-emoji",                   -- emoji
			"petertriho/cmp-git",                  -- git
			"Dynge/gitmoji.nvim",                  -- gitmoji
			"max397574/cmp-greek",                 -- greek
			"kdheepak/cmp-latex-symbols",          -- latex_symbols
            {"yehuohan/cmp-im",                    -- IM
             dependencies="MathiasSM/ZFVimIM_japanese_base" },
			"chrisgrieser/cmp-nerdfont",           -- nerdfont
			"hrsh7th/cmp-nvim-lsp",                -- nvim_lsp
			"hrsh7th/cmp-nvim-lsp-signature-help", -- nvim_lsp_signature_help
			"hrsh7th/cmp-omni",                    -- omni
			"hrsh7th/cmp-path",                    -- path
			"f3fora/cmp-spell",                    -- spell
			-- Nice to have
			"nvim-tree/nvim-web-devicons",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Minimum configuration
			cmp.setup({
				snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
			})

			-- UI
			cmp.setup({
				---@diagnostic disable-next-line: missing-fields
				formatting = { format = format_completion_popup },
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})

			-- Mappings
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
			})

			-- Sources
			---@diagnostic disable-next-line: missing-fields
			require("gitmoji").setup({ completion = { complete_as = "emoji" } })
			require("cmp_git").setup()
			require("cmp_pandoc").setup({ crossref = { enable_nabla = true } })
			require("cmp_im").setup({
				enable = true,
				tables = {
					vim.fn.stdpath("data") .. "/lazy/ZFVimIM_japanese_base/misc/japanese.txt",
				},
			})

			--- Default sources for code
			local code_sources = {
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "luasnip", option = { show_autosnippets = true } },
				{ name = "calc" },
				{ name = "omni" },
				{
					name = "spell",
					option = {
						keep_all_entries = false,
						enable_in_context = function()
							return require("cmp.config.context").in_treesitter_capture("spell")
						end,
					},
				},
			}
			--- Default fallback sources
			local code_sources_fallback = {
				{ name = "omni" }, -- If no LSP
				{ name = "buffer" }, -- If no LSP, snippet or else
				{ name = "path", options = { trailing_slash = true } },
				{ name = "calc" },
			}

			-- Global/default sources
			cmp.setup({
				sources = cmp.config.sources(code_sources, code_sources_fallback),
			})

			-- Filetype-specific configurations
			local neovim_sources = vim.deepcopy(code_sources)
			table.insert(neovim_sources, { name = "nerdfont" })
			for _, ft in ipairs({ "lua", "vim" }) do
				cmp.setup.filetype(ft, {
					sources = cmp.config.sources(neovim_sources, code_sources_fallback),
				})
			end

			local markup_sources = vim.deepcopy(code_sources)
			table.insert(markup_sources, { name = "emoji" })
			table.insert(markup_sources, { name = "greek" })
			table.insert(markup_sources, { name = "cmp_pandoc" })
			table.insert(markup_sources, { name = "spell" })
			table.insert(markup_sources, { name = "IM" }) -- TEST: performance
			-- TODO: Add wiki filetypes?
			for _, ft in ipairs({ "text", "markdown", "rst", "asciidoc", "html" }) do
				cmp.setup.filetype(ft, {
					sources = cmp.config.sources(markup_sources, code_sources_fallback),
				})
			end

			local latex_sources = vim.deepcopy(markup_sources)
			table.insert(latex_sources, { name = "latex_symbols" })
			cmp.setup.filetype("tex", {
				sources = cmp.config.sources(latex_sources, code_sources_fallback),
			})

			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "conventionalcommits" },
					{ name = "gitmoji" }, -- Instead of emoji
					{ name = "git" },
					{ name = "spell" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		lazy = true,
		config = function()
			require("luasnip").setup({
				history = true,
				delete_check_events = "TextChanged",
			})
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
