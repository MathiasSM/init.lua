local M = {}

local function config_sources()
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
end

local function build_source_lists()
    local lists = {}

    local base_native_sources = {
		{ name = "omni" },
		{ name = "buffer" },
		{ name = "path",  options = { trailing_slash = true } },
    }

    local lsp_sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
    }

    lists.base_file_sources = {}
    vim.list_extend(lists.base_file_sources, base_native_sources)
    vim.list_extend(lists.base_file_sources, lsp_sources)
    vim.list_extend(lists.base_file_sources, {
        { name = "calc" },
        { name = "luasnip", option = { show_autosnippets = true } },
    })

	lists.base_code_sources = {}
    vim.list_extend(lists.base_code_sources, base_native_sources)
    vim.list_extend(lists.base_code_sources, {
        name = "spell",
        option = {
            keep_all_entries = false,
            enable_in_context = function()
                return require("cmp.config.context").in_treesitter_capture("spell")
            end,
        },
    })

    lists.base_markup_sources = {}
    vim.list_extend(lists.base_markup_sources, base_native_sources)
    vim.list_extend(lists.base_markup_sources, {
        { name = "spell" }, -- NOTE: No restriction to comment context
        { name = "emoji" },
        { name = "greek" },
        { name = "cmp_pandoc" },
        { name = "IM" }
    })

    lists.fallback_sources = vim.deepcopy(base_native_sources)

    return lists
end


--- Setup global and specifc sources
function M.setup_sources()
	local cmp = require("cmp")
    config_sources()
    local lists = build_source_lists()

    -- Default
	cmp.setup({
		sources = cmp.config.sources(lists.base_code_sources, lists.fallback_sources),
	})

    -- For cmdline
    cmp.setup.cmdline({ '/', '?' }, {
        sources = {{ name = "buffer" }}
    })
    cmp.setup.cmdline(':', {
        sources = cmp.config.sources(
            {{ name = 'path' }},
            {{ name = 'cmdline' }}
        ),
    })

    -- By filetype
	local function setup_ft_sources(ft, ...)
		cmp.setup.filetype(ft, {
			sources = cmp.config.sources(
				vim.tbl_deep_extend('keep', {}, ...),
				lists.fallback_sources
			),
		})
	end

	setup_ft_sources("asciidoc", lists.base_markup_sources)
	setup_ft_sources("html", lists.base_markup_sources)
	setup_ft_sources("markdown", lists.base_markup_sources)
	setup_ft_sources("rst", lists.base_markup_sources)
	setup_ft_sources("tex", lists.base_markup_sources, {{ name = "latex_symbols" }})
	setup_ft_sources("text", lists.base_markup_sources)

	setup_ft_sources("vim", lists.base_code_sources, {{ name = "nerdfont" }})
	setup_ft_sources("lua", lists.base_code_sources, {{ name = "nerdfont" }})

	setup_ft_sources("gitcommit", lists.base_markup_sources, {
		{ name = "conventionalcommits" },
		{ name = "gitmoji" },
		{ name = "git" },
	})
end

return M
