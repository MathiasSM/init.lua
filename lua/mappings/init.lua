--- Defines mappings
-- * Some override default nvim mappings
-- * Some are personal mappings I like to use
-- * Some are LSP-specific mappings to use the lsp client
-- * Some are diagnostic-related mappings
--
-- @see vim.diagnostic
-- @see vim.lsp

require("mappings.overrides")
require("mappings.personal")
require("mappings.lsp")
