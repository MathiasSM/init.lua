local diagnostic_config = require('diagnostic.config')

vim.api.nvim_create_user_command("HideDiagnosticVirtualText", function()
	local newConfig = vim.deepcopy(diagnostic_config)
	newConfig.virtual_text = false
	vim.diagnostic.config(newConfig)
end, { desc = "[Diagnostic] Hide virtual text" })

vim.api.nvim_create_user_command(
	"ShowDiagnosticVirtualText",
	function() vim.diagnostic.config(diagnostic_config) end,
	{ desc = "[Diagnostic] Show virtual text" }
)
