local function set_lsp_mappings(event)
	local nmap = function(lhs, rhs, desc)
		vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
	end
	local vmap = function(lhs, rhs, desc)
		vim.keymap.set("v", lhs, rhs, { buffer = event.buf, desc = desc })
	end

	-- Buffer local mappings.
	nmap("gD", vim.lsp.buf.declaration, "[LSP] Go to declaration")
	nmap("gd", vim.lsp.buf.definition, "[LSP] Go to definition")
	nmap("gi", vim.lsp.buf.implementation, "[LSP] Go to implementation")
	nmap("gs", vim.lsp.buf.type_definition, "[LSP] Go to type definition")
	nmap("gr", vim.lsp.buf.references, "[LSP] Show references")

	nmap("<space>k", vim.lsp.buf.hover, "[LSP] Show hover information")
	nmap("<space>K", vim.lsp.buf.signature_help, "[LSP] Show signature help")

	-- (w*)orkspace (wa)dd, (wr)emove, (wl)ist
	nmap("<space>wa", vim.lsp.buf.add_workspace_folder, "[LSP] Add workspace folder")
	nmap("<space>wr", vim.lsp.buf.remove_workspace_folder, "[LSP] Remove workspace folder")
	nmap("<space>wl", function()
		local list = vim.inspect(vim.lsp.buf.list_workspace_folders())
		print(list)
	end, "[LSP] List workspace folders")

	-- (r)ename, (c)ode action, (f)ormat
	nmap("<space>r", vim.lsp.buf.rename, "[LSP] Rename all references")
	nmap("<space>c", vim.lsp.buf.code_action, "[LSP] Select code action to execute")
	vmap("<space>c", vim.lsp.buf.code_action, "[LSP] Select code action to execute")
	nmap("<space>f", function() vim.lsp.buf.format({ async = true }) end, "[LSP] Format buffer")
end

-- Only create mappings on LspAttach'd buffers
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Enable mappings for LSP functionality",
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(event)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- TODO: Understand
		set_lsp_mappings(event)
	end,
})
