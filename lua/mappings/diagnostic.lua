vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "[Diagnostics] Open float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "[Diagnostics] Previous" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "[Diagnostics] Next" })
