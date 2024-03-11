return {
	{
		"mrcjkb/haskell-tools.nvim",
		version = "^3", -- Recommended
		ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "haskell", "lhaskell", "cabal", "cabalproject" },
				desc = "Attach haskell-language-server on haskell files",
				group = vim.api.nvim_create_augroup("UserLspConfigHaskell", {}),
				callback = function()
					require("telescope").load_extension("ht")
					local ht = require("haskell-tools")
					local bufnr = vim.api.nvim_get_current_buf()
					local keyOpts = function(desc)
						return {
							noremap = true,
							silent = true,
							buffer = bufnr,
							desc = desc,
						}
					end
					vim.keymap.set(
						"n",
						"<space>hs",
						ht.hoogle.hoogle_signature,
						keyOpts("[LSP] Haskell: Show hoogle signature")
					)
					vim.keymap.set(
						"n",
						"<space>he",
						ht.lsp.buf_eval_all,
						keyOpts("[LSP] Haskell: Evaluate all")
					)
					vim.keymap.set(
						"n",
						"<leader>hp",
						ht.repl.toggle,
						keyOpts("[LSP] Haskell: Toggle REPL for package")
					)
					vim.keymap.set(
						"n",
						"<leader>hr",
						function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end,
						keyOpts("[LSP] Haskell: Toggle REPL for buffer")
					)
					vim.keymap.set(
						"n",
						"<leader>hrq",
						ht.repl.quit,
						keyOpts("[LSP] Haskell: Quit REPL")
					)
				end,
			})
		end,
	},
}
