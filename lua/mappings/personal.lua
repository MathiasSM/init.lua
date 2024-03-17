-- Set highlights off
vim.keymap.set("n", "<leader><CR>", "<cmd>nohlsearch<cr>", { desc = "[Personal] Highlights off" })

-- Text manipulation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "[Personal] Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "[Personal] Move selection up" })

-- Clipboard/registers
vim.keymap.set("n", "<leader>P", '"_dP', { desc = "[Personal] Paste preserving register" })
