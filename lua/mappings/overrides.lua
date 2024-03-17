-- Keep cursor centered on movements
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "[Override] <C-d> and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "[Override] <C-u> and center cursor" })

vim.keymap.set("n", "n", "nzzzv", { desc = "[Override] Search forward and center cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "[Override] Search back and center cursor" })

-- Keep cursor position on edits
vim.keymap.set("n", "J", "mzJ`z", { desc = "[Override] J but keep cursor in place" })

