---@module "snacks"

local function set_lsp_mappings(event)
  --- Uses Snacks utility to only create the keymaps when LSP capability exists
  local smap = function(mode, lhs, rhs, method, desc)
    Snacks.keymap.set(mode, lhs, rhs, { lsp = { method = method }, desc = desc })
  end

  local this_buf = { bufnr = 0 }

  -- Movement
  smap("n", "gD", vim.lsp.buf.declaration, "textDocument/declaration", "[LSP] Go to declaration")
  smap("n", "gd", vim.lsp.buf.definition, "textDocument/definition", "[LSP] Go to definition")
  smap("n", "gt", vim.lsp.buf.type_definition, "textDocument/typeDefinition", "[LSP] Go to type definition")
  smap("n", "gi", vim.lsp.buf.implementation, "textDocument/implementation", "[LSP] Go to implementation")

  smap("n", "<space>r", vim.lsp.buf.references, "textDocument/references", "[Show] references")
  smap("n", "<space>s", vim.lsp.buf.document_symbol, "textDocument/documentSymbol", "[Show] document symbols")

  -- Hierarchies
  local supertypes = function() vim.lsp.buf.typehierarchy("supertypes") end
  local subtypes = function() vim.lsp.buf.typehierarchy("subtypes") end
  smap("n", "<space>t", supertypes, "typeHierarchy/supertypes", "[Show] super-types")
  smap("n", "<space>y", subtypes, "typeHierarchy/subtypes", "[Show] sub-types")

  smap("n", "<space>i", vim.lsp.buf.incoming_calls, "callHierarchy/incomingCalls", "[Show] Incoming calls")
  smap("n", "<space>o", vim.lsp.buf.outgoing_calls, "callHierarchy/outgoingCalls", "[Show] Outgoing calls")

  -- Actions
  local toggle_codelens = function()
    vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled(this_buf), { bufnr = 0 })
  end
  smap("n", "<space>R", vim.lsp.buf.rename, "textDocument/rename", "[Run] Rename all references")
  smap({ "n", "v" }, "<space>a", vim.lsp.buf.code_action, "textDocument/codeAction", "[Run] A Code Action")
  smap("n", "<space>L", toggle_codelens, "textDocument/codeLens", "[Toggle] Code Lens")
  smap("n", "<space>l", vim.lsp.codelens.run, "codeLens/resolve", "[Run] This Code Lens")

  -- Diagnostics/hover
  local hover = function() vim.lsp.buf.hover({ border = "rounded" }) end
  local signature_help = function() vim.lsp.buf.signature_help({ border = "rounded" }) end
  smap("n", "<space>k", hover, "textDocument/hover", "[Show] hover information")
  smap("n", "<space>K", signature_help, "textDocument/signatureHelp", "[Show] signature help")

  -- Color
  -- TODO: Probably needs more to avoid clashing with treesitter colors?
  local color = Snacks.toggle({
    name = "LSP colors",
    set = function() vim.lsp.document_color.enable(not vim.lsp.document_color.is_enabled(this_buf), this_buf) end,
    get = function() return vim.lsp.document_color.is_enabled(this_buf) end,
  })
  smap("n", "<space>c", function() color:toggle() end, "textDocument/documentColor", "[Toggle] LSP color")

  -- Workspace
  local workspace_folders = function()
    local list = vim.inspect(vim.lsp.buf.list_workspace_folders())
    vim.notify(list)
  end
  smap("n", "<space>ws", vim.lsp.buf.workspace_symbol, "workspace/symbol", "[Show] Workspace Symbols")
  smap("n", "<space>wd", vim.lsp.buf.workspace_diagnostics, "workspace/diagnostic", "[Show] Workspace diagnostics")
  smap("n", "<space>wl", workspace_folders, "workspace/workspaceFolders", "[Show] Folders")
  smap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "workspace/didChangeWorkspaceFolders", "[Add] Folder")
  smap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "workspace/didChangeWorkspaceFolders", "[Remove] Folder")

  --TODO: vim.lsp.buf.selection_range()

  -- NOTE: textDocument/documentHighlight -> Too much trouble for fancy '*'
  -- NOTE: textDocument/inlayHint: Handled by normal snack toggle
  -- NOTE: textDocument/linkedEditingRange: Hopefully handled by each server? Need to test
  -- NOTE: Format handled alongside non-lsp formatters

  vim.notify_once("Enabled LSP mappings")
end

-- Only create mappings off LspAttach'd buffers
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Enable mappings for LSP functionality",
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    set_lsp_mappings(event)
  end,
})

-- Launch LSPs on command instead of automatically (avoid quick edits launching heavy processes)
vim.keymap.set("n", "<space><space>", function()
  -- Defaults
  vim.lsp.config("*", {
    root_markers = { ".git", ".hg" },
    capabilities = require("plugins.lsp.configs").get_capabilities(),
  })
  for ls_name, ls_config in pairs(require("plugins.lsp.configs").get()) do
    vim.lsp.config(ls_name, ls_config)
  end
  require("mason-lspconfig").setup()
  vim.cmd("doautocmd BufReadPost") -- HACK: Without this, it doesn't attach
  -- Remove keymap once done
  vim.keymap.del("n", "<space><space>")
end, { desc = "[LSP] Turn on LSPs" })

