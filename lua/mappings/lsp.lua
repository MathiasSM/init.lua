
local function set_lsp_mappings(event)
  vim.notify_once("Enabled LSP mappings")
  local nmap = function(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc }) end
  local nvmap = function(lhs, rhs, desc) vim.keymap.set({ "n", "v" }, lhs, rhs, { buffer = event.buf, desc = desc }) end

  -- Buffer local mappings.
  nmap("gd", vim.lsp.buf.definition, "[LSP] Go to definition")
  nmap("gD", vim.lsp.buf.declaration, "[LSP] Go to declaration")
  nmap("gi", vim.lsp.buf.implementation, "[LSP] Go to implementation")
  nmap("gI", vim.lsp.buf.incoming_calls, "[LSP] Show incoming calls")
  nmap("gO", vim.lsp.buf.outgoing_calls, "[LSP] Show outgoing calls")
  nmap("gr", vim.lsp.buf.references, "[LSP] Go to references")
  nmap("gt", vim.lsp.buf.type_definition, "[LSP] Go to type definition")
  nmap("gT", function() vim.lsp.buf.typehierarchy("supertypes") end, "[LSP] Show super-types")
  nmap("gY", function() vim.lsp.buf.typehierarchy("subtypes") end, "[LSP] Show sub-types")
  nmap("gs", vim.lsp.buf.document_symbol, "[LSP] List document symbols")
  nmap("gS", vim.lsp.buf.workspace_symbol, "[LSP] List Workspace Symbols")

  -- (w*)orkspace: (wa)dd, (wr)emove, (wl)ist
  nmap("<space>wa", vim.lsp.buf.add_workspace_folder, "[Workspace] Add folder")
  nmap("<space>wr", vim.lsp.buf.remove_workspace_folder, "[Workspace] Remove folder")
  nmap("<space>wl", function()
    local list = vim.inspect(vim.lsp.buf.list_workspace_folders())
    vim.notify(list)
  end, "[Workspace] List folders")

  -- (r)ename, (c)ode action, (f)ormat
  nmap("<space>r", vim.lsp.buf.rename, "[LSP] Rename all references")
  nvmap("<space>a", vim.lsp.buf.code_action, "[LSP] Select code action to execute")
  nmap("<space>l", vim.lsp.codelens.run, "[LSP] Codelens")

  -- Diagnostics/hover
  nmap("<space>e", vim.diagnostic.open_float, "[Diagnostics] Open float")
  nmap("<space>k", function() vim.lsp.buf.hover({ border = "rounded" }) end, "[LSP] Show hover information")
  nmap("<space>K", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, "[LSP] Show signature help")
end

-- Only create mappings off LspAttach'd buffers
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Enable mappings for LSP functionality",
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event) set_lsp_mappings(event) end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
  desc = "Refresh CodeLens",
  group = vim.api.nvim_create_augroup("UserLspCodeLens", {}),
  callback = function(event) vim.lsp.codelens.refresh({ bufnr = event.buf }) end,
})
