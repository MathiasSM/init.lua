return {
	{
		"mfussenegger/nvim-lint",
		event = "BufWritePost",
		config = function()
			require("lint").linters_by_ft = {
				markdown = { "alex", "proselint", "vale", "writegood" },
				cfn = { "cfn_lint", "cfn_nag" },
				java = { "checkstyle" },
				latex = { "chktex" },
				gitcommit = { "commitlist", "gitlist" },
				["*"] = { "blocklint", "typos", "woke" },
				dotenv = { "dotenv_linter" },
				-- js/ts use eslint-lsp
				html = { "htmlhint" },
				sql = { "sqlfluff" },
				bash = { "shellcheck" },
				css = { "stylelint" },
				zsh = { "shellcheck", "zsh" },
				vim = { "vint" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function() require("lint").try_lint() end,
			})
		end,
	},
}
