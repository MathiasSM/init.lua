--- Formatters configuration
-- These should be installed (via Mason or otherwise)
--
-- @module formatters

--- Builds map<filetype -> formatter[]> expected by formatter.setup
-- All formatter configurations are opt-in (and so must be included here)
-- For each ft, formatters are applied in order.
-- The `*` applies to all filetypes.
local get_formatters_by_ft = function()
	local js = require("formatter.filetypes.javascript")
	local jsx = require("formatter.filetypes.javascriptreact")
	local lua = require("formatter.filetypes.lua")
	local sh = require("formatter.filetypes.sh")
	local sql = require("formatter.filetypes.sql")
	local ts = require("formatter.filetypes.typescript")
	local tsx = require("formatter.filetypes.typescriptreact")
	local any = require("formatter.filetypes.any")
	return {
		javascript = { js.eslint_d },
		javascriptreact = { jsx.eslint_d },
		lua = { lua.stylua },
		sh = { sh.shfmt },
		sql = { sql.pgformat, sql.sqlfluff },
		typescript = { ts.eslint_d },
		typescriptreact = { tsx.eslint_d },
		["*"] = { any.remove_trailing_whitespace },
	}
end

return {
	{
		"mhartington/formatter.nvim",
		keys = {
			{ "<leader>pp", ":FormatWrite<CR>", desc = "[Formatter] Run" },
		},
		cmd = { "Format", "FormatWrite" },
		config = function()
			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = get_formatters_by_ft(),
			})
		end,
	},
}
