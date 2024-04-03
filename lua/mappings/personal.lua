-- Set highlights off
vim.keymap.set("n", "<leader><CR>", "<cmd>nohlsearch<cr>", { desc = "[Personal] Highlights off" })

-- Text manipulation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "[Personal] Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "[Personal] Move selection up" })

-- Clipboard/registers
vim.keymap.set("n", "<leader>P", '"_dP', { desc = "[Personal] Paste preserving register" })

-- Notes
--- Copies filepath (from workspce root) and position
vim.keymap.set("n", "<leader>c", function()
	local fname = vim.fn.expand("%")
	local root = vim.loop.cwd()
	if root == nil then return fname end
	if vim.startswith(fname, root) then
		root = vim.fn.fnamemodify(root, ":h")
		fname = string.gsub(fname, root .. "/", "")
	end
	local info = fname .. ":" .. vim.api.nvim_win_get_cursor(0)[1]
	vim.fn.setreg('"', info .. "\n") -- Yank it to the system clipboard
	vim.notify("Yanked: " .. info)
end, { noremap = true, silent = true, desc = "Yank current filepath:linenr" })
