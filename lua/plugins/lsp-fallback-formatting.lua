--- Formatting configuration
--
-- These formatters will be used if LSP provides no formatting capability
--
-- They should be installed first (via Mason or otherwise)
--
-- @module formatters

local filetypes_formatters = {
	lua = { "stylua" },
	sh = { "shfmt" },
	sql = { "pgformat", "sqlfluff" },
}

--- Builds map<filetype -> formatter[]> expected by formatter.setup
-- All formatter configurations are opt-in (and so must be included here)
-- For each ft, formatters are applied in order.
-- The `*` applies to all filetypes.
local get_formatters_by_ft = function()
	local registered_formatters = {}
	for ft, formatter_names in pairs(filetypes_formatters) do
		registered_formatters[ft] = {}
		for _, formatter_name in ipairs(formatter_names) do
			table.insert(
				registered_formatters[ft],
				require("formatter.filetypes." .. ft)[formatter_name]
			)
		end
	end
	registered_formatters["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace }
	return registered_formatters
end

local Utils = require("utils")

return {
	{
		"mhartington/formatter.nvim",
		keys = {
			{
				"<leader>p",
				function()
					if vim.bo.filetype == "" then
						vim.notify("No filetype detected, won't format.")
						return
					end
					local non_lsp_formatters = filetypes_formatters[vim.bo.filetype]
					local has_normal_formatting = non_lsp_formatters ~= nil
					local has_lsp_formatting = Utils.lsp_has_formatting()
					if has_lsp_formatting then
						local active_clients = vim.lsp.get_active_clients({ bufnr = 0 })
						local active_client_names = {}
						for _, client in ipairs(active_clients) do
							table.insert(active_client_names, client.name)
						end
						vim.notify(
							"Formatting using LSP(s): " .. table.concat(active_client_names, ", ")
						)
						vim.lsp.buf.format()
					elseif has_normal_formatting then
						vim.notify(
							"Formatting using (Non-LSP): " .. table.concat(non_lsp_formatters, ", ")
						)
						vim.cmd("FormatWrite")
					else
						vim.notify("No formatters available for " .. vim.bo.filetype)
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
