return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePost", "BufRead" },
		config = function()
			require("lint").linters_by_ft = {
				markdown = { "alex", "proselint", "vale", "write_good" },
				cfn = { "cfn_lint", "cfn_nag" },
				java = { "checkstyle" },
				latex = { "chktex" },
				gitcommit = { "commitlint", "gitlint" },
				["*"] = { "blocklint", "typos", "woke" },
				help = {},
				dotenv = { "dotenv_linter" },
				javascript = {},
				typescript = {},
				html = { "htmlhint" },
				sql = { "sqlfluff" },
				bash = { "shellcheck" },
				css = { "stylelint" },
				zsh = { "shellcheck", "zsh" },
				vim = { "vint" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufRead" }, {
				callback = function() require("lint").try_lint() end,
			})

			vim.api.nvim_create_user_command("LintProgress", function()
				local linters = require("lint").get_running()
				if #linters == 0 then
					print("󰦕 Nothing running")
					return
				end
				print("󱉶 " .. table.concat(linters, ", "))
			end, { desc = "[Linters] Display current status" })
		end,
	},
}
