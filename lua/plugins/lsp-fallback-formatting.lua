--- Formatting configuration
--
-- These formatters will be used if LSP provides no formatting capability
--
-- They should be installed first (via Mason or otherwise)
--
-- @module formatters

--- Builds map<filetype -> formatter[]> expected by formatter.setup
-- All formatter configurations are opt-in (and so must be included here)
-- For each ft, formatters are applied in order.
-- The `*` applies to all filetypes.
local get_formatters_by_ft = function()
	local lua = require("formatter.filetypes.lua")
	local sh = require("formatter.filetypes.sh")
	local sql = require("formatter.filetypes.sql")
	local any = require("formatter.filetypes.any")
	return {
		-- javascript: eslint-lsp
		-- javascriptreact: eslint-lsp
		lua = { lua.stylua },
		sh = { sh.shfmt },
		sql = { sql.pgformat, sql.sqlfluff },
		-- typescript: eslint-lsp
		-- typescriptreact: eslint-lsp
		["*"] = { any.remove_trailing_whitespace },
	}
end

local Utils = require("utils")

return {
	{
		"mhartington/formatter.nvim",
		keys = {
			{
				"<leader>p",
				function()
					if Utils.lsp_has_formatting() then
						vim.notify("Formatting using LSP")
						vim.lsp.buf.format()
					else
						vim.notify("Formatting using formatters (No LSP)")
						vim.cmd("FormatWrite")
					end
				end,
				desc = "[Format] Run",
			},
		},
		config = function()
			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = get_formatters_by_ft(),
			})
		end,
	},
}
