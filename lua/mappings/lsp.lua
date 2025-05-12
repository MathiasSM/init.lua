--- Mappings for LSP actions
--
-- Mostly prefixed with `<space>`
--
-- @script

--- Sets all the LSP mappings; meant to be used on an autocmd
--
-- Includes:
-- - (Unprefixed) `g*`: "Go to" commands; some of which open a quickfix list to pick
-- - `k` and `K`: Hover/hover-like info pop-ups
-- - `s*`: Show/highlight/list symbols in file/project
-- - `w*`: Workspace-related commands
-- - Single-letter for text-manipulation commands
local function set_lsp_mappings(event)
  local nmap = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
  end
  local nvmap = function(lhs, rhs, desc)
    vim.keymap.set({ "n", "v" }, lhs, rhs, { buffer = event.buf, desc = desc })
  end

  -- Buffer local mappings.
  nmap("gD", vim.lsp.buf.declaration,       "[LSP] Go to declaration")
  nmap("gd", vim.lsp.buf.definition,        "[LSP] Go to definition")
  nmap("gi", vim.lsp.buf.implementation,    "[LSP] Go to implementation")
  nmap("gs", vim.lsp.buf.type_definition,   "[LSP] Go to type definition")
  nmap("gr", vim.lsp.buf.references,        "[LSP] Go to references")
  nmap("gI", vim.lsp.buf.incoming_calls,    "[LSP] Show incoming calls")
  nmap("gO", vim.lsp.buf.outgoing_calls,    "[LSP] Show outgoing calls")

  nmap("<space>k", vim.lsp.buf.hover,            "[LSP] Show hover information")
  nmap("<space>K", vim.lsp.buf.signature_help,   "[LSP] Show signature help")

  -- (s*)ymbol: (sh)ighlight, (ss)ymbols in current document, (sw)orkspace
  nmap("<space>sh", vim.lsp.buf.document_highlight,   "[LSP] Highlight symbol references")
  nmap("<space>ss", vim.lsp.buf.document_symbol,      "[LSP] List symbols in current buffer")
  nmap("<space>sw", vim.lsp.buf.workspace_symbol,     "[LSP] List symbols in current workspace")

  -- (w*)orkspace: (wa)dd, (wr)emove, (wl)ist
  nmap("<space>wa",   vim.lsp.buf.add_workspace_folder,      "[LSP] Add workspace folder")
  nmap("<space>wr",   vim.lsp.buf.remove_workspace_folder,   "[LSP] Remove workspace folder")
  nmap("<space>wl", function()
    local list = vim.inspect(vim.lsp.buf.list_workspace_folders())
    print(list)
  end, "[LSP] List workspace folders")

  -- (r)ename, (c)ode action, (f)ormat
  nmap("<space>r",  vim.lsp.buf.rename,        "[LSP] Rename all references")
  nvmap("<space>a", vim.lsp.buf.code_action,   "[LSP] Select code action to execute")
  nmap("<space>l",  vim.lsp.codelens.run,      "[LSP] Codelens")
end

-- Only create mappings off LspAttach'd buffers
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Enable mappings for LSP functionality",
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    -- Enable LSP completion
    vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    set_lsp_mappings(event)
  end,
})
