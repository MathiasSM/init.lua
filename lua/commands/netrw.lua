vim.api.nvim_create_user_command(
	"Netrw",
	"Lexplore",
	{ desc = "[Netrw] Open for current file directory" }
)
vim.api.nvim_create_user_command(
	"NetrwW",
	"Lexplore",
	{ desc = "[Netrw] Open for current workspace directory" }
)
