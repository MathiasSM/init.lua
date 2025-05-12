--- Diagnostic-related configurations
-- @script

---@type vim.diagnostic.Opts
local diagnostic_config = {
	update_in_insert = false,
	severity_sort = true,
	signs = {
		priority = 10,
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚",
			[vim.diagnostic.severity.WARN] = "󰀪",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌶",
		},
	},
	underline = {
		severity = { min = vim.diagnostic.severity.ERROR }
	},
	virtual_text = {
		source = false,
		prefix = "●",
		severity = { min = vim.diagnostic.severity.WARN }
	},
	virtual_lines = false,
	float = {
		scope = "line",
		header = "Diagnostics",
		source = true,
	},
	jump = {
		wrap = true, -- loop around after last item
	}
}
vim.diagnostic.config(diagnostic_config)

-- Keymaps
local open_float = vim.diagnostic.open_float
local goto_prev = function() vim.diagnostic.jump({ count = -1 }) end
local goto_next = function() vim.diagnostic.jump({ count = 1 }) end
vim.keymap.set("n", "<space>e", open_float, { desc = "[Diagnostics] Open float" })
vim.keymap.set("n", "[d", goto_prev, { desc = "[Diagnostics] Previous" })
vim.keymap.set("n", "]d", goto_next, { desc = "[Diagnostics] Next" })

